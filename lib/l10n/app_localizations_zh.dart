// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get appTitle => '循环清单';

  @override
  String get signIn => '登录';

  @override
  String get signUp => '注册';

  @override
  String get register => '注册';

  @override
  String get emailHint => '电子邮件';

  @override
  String get passwordHint => '密码';

  @override
  String get passwordLengthError => '密码长度至少6个字符';

  @override
  String get signInError => '无法使用这些凭据登录';

  @override
  String get emailEmptyError => '请输入电子邮件';

  @override
  String get homeScreenTitle => '循环清单';

  @override
  String get logout => '注销';

  @override
  String get checklistTab => '清单';

  @override
  String get eventsTab => '事件';

  @override
  String get settingsTab => '设置';

  @override
  String get dailyChecklistTitle => '每日清单';

  @override
  String get noChecklistItems => '今天没有清单项目。';

  @override
  String get sortChecklistItems => '排序清单项目';

  @override
  String get deleteAllCheckedItems => '删除所有已勾选项目';

  @override
  String toggleStatus(Object itemContent, Object newValue) {
    return '将 $itemContent 的状态切换为 $newValue';
  }

  @override
  String get eventsScreenTitle => '事件';

  @override
  String get noEventsYet => '还没有事件。添加一个吧！';

  @override
  String editEvent(Object eventName) {
    return '编辑事件：$eventName';
  }

  @override
  String deleteEvent(Object eventName) {
    return '删除事件：$eventName';
  }

  @override
  String addChecklistItemToEvent(Object eventName) {
    return '向事件添加清单项目：$eventName';
  }

  @override
  String get addEvent => '添加新事件';

  @override
  String get addEditEventDialogTitleAdd => '添加新事件';

  @override
  String get addEditEventDialogTitleEdit => '编辑事件';

  @override
  String get eventNameLabel => '事件名称';

  @override
  String get eventNameEmptyError => '请输入事件名称';

  @override
  String get noteLabel => '备注（可选）';

  @override
  String get cancel => '取消';

  @override
  String get add => '添加';

  @override
  String get save => '保存';

  @override
  String get addChecklistItemDialogTitle => '添加清单项目';

  @override
  String get itemContentLabel => '项目内容';

  @override
  String get itemContentEmptyError => '请输入项目内容';

  @override
  String get settingsScreenTitle => '设置';

  @override
  String get signOut => '注销';

  @override
  String get delete => '删除';

  @override
  String get deleteAccount => '删除账户';

  @override
  String get deleteAccountConfirmationTitle => '删除账户';

  @override
  String get deleteAccountConfirmationMessage =>
      '您确定要删除您的账户吗？此操作不可逆，并将删除您的所有数据。';

  @override
  String get language => '语言';

  @override
  String get english => '英语';

  @override
  String get chinese => '中文';

  @override
  String get systemDefault => '系统默认';

  @override
  String errorLoadingChecklistItems(Object error) {
    return '加载清单项目时出错：$error';
  }

  @override
  String get noChecklistItemsForEvent => '此事件没有清单项目。';

  @override
  String get checklistItems => '清单项目：';

  @override
  String get deletedCheckedItems => '已删除已勾选项目';

  @override
  String get noItemsCheckedToDelete => '没有已勾选项目可删除';

  @override
  String get deleteEventConfirmationTitle => '删除事件';

  @override
  String deleteEventConfirmationMessage(Object eventName) {
    return '您确定要删除“$eventName”吗？这将同时删除所有关联的清单项目。';
  }

  @override
  String get pleaseSignInToViewEvents => '请登录以查看事件。';
}
