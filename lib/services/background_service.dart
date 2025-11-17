import 'package:workmanager/workmanager.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:recurrent_checklist/firebase_options.dart';
import 'package:recurrent_checklist/models/event.dart';
import 'package:recurrent_checklist/models/checklist_item.dart';
import 'package:uuid/uuid.dart';

const String RECURRING_EVENT_TASK = "recurringEventTask";

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

    final FirebaseAuth auth = FirebaseAuth.instance;
    final FirebaseFirestore db = FirebaseFirestore.instance;

    // This is a placeholder for the actual user ID.
    // In a real application, you would need to pass the user ID
    // as inputData to the task or handle authentication within the background task.
    // For now, we'll assume a logged-in user or fetch the first user's events.
    // This part needs careful consideration for multi-user scenarios.
    final User? user = auth.currentUser;
    if (user == null) {
      // Attempt to sign in anonymously or handle no user case
      try {
        await auth.signInAnonymously();
        print("Signed in anonymously for background task.");
      } catch (e) {
        print("Failed to sign in anonymously: $e");
        return Future.value(true); // Task failed, retry
      }
    }

    final String? userId = auth.currentUser?.uid;

    if (userId == null) {
      print("No user ID available for background task.");
      return Future.value(true); // Task failed, retry
    }

    print("Executing $RECURRING_EVENT_TASK for user $userId");

    try {
      final eventsSnapshot = await db
          .collection('users')
          .doc(userId)
          .collection('events')
          .where('isRecurring', isEqualTo: true)
          .get();

      for (var doc in eventsSnapshot.docs) {
        final event = Event.fromDocumentSnapshot(doc);
        final now = DateTime.now();

        // Check if the event is due
        if (event.nextRunDate != null && event.nextRunDate!.isBefore(now)) {
          print("Processing recurring event: ${event.name}");

          // Duplicate checklist items
          for (var item in event.checklistItems) {
            final newItem = item.copyWith(id: const Uuid().v4(), isChecked: false, createdAt: DateTime.now());
            await db
                .collection('users')
                .doc(userId)
                .collection('checklistItems')
                .doc(newItem.id)
                .set(newItem.toMap());
          }

          // Calculate next run date
          DateTime newNextRunDate = now;
          final int scheduledHour = int.parse(event.scheduledTime.split(':')[0]);
          final int scheduledMinute = int.parse(event.scheduledTime.split(':')[1]);

          // Set the time for today
          newNextRunDate = DateTime(
            now.year,
            now.month,
            now.day,
            scheduledHour,
            scheduledMinute,
          );

          // If the scheduled time for today has already passed, schedule for tomorrow
          if (newNextRunDate.isBefore(now)) {
            newNextRunDate = newNextRunDate.add(const Duration(days: 1));
          }

          // Add repeat interval
          if (event.repeatFrequency == 'Days') {
            newNextRunDate = newNextRunDate.add(Duration(days: event.repeatInterval));
          } else if (event.repeatFrequency == 'Weeks') {
            newNextRunDate = newNextRunDate.add(Duration(days: event.repeatInterval * 7));
          } else if (event.repeatFrequency == 'Months') {
            newNextRunDate = DateTime(
              newNextRunDate.year,
              newNextRunDate.month + event.repeatInterval,
              newNextRunDate.day,
              newNextRunDate.hour,
              newNextRunDate.minute,
            );
          }

          // Update event with new lastRunDate and nextRunDate
          await db
              .collection('users')
              .doc(userId)
              .collection('events')
              .doc(event.id)
              .update({
            'lastRunDate': now.toIso8601String(),
            'nextRunDate': newNextRunDate.toIso8601String(),
          });
        }
      }
      return Future.value(true); // Task completed successfully
    } catch (e) {
      print("Error in background task: $e");
      return Future.value(false); // Task failed
    }
  });
}