// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get appName => '循环清单';

  @override
  String get signIn => '登录';

  @override
  String get signUp => '注册';

  @override
  String get email => '邮箱';

  @override
  String get password => '密码';

  @override
  String get checklist => '清单';

  @override
  String get events => '事件';

  @override
  String get settings => '设置';

  @override
  String get sort => '排序';

  @override
  String get deleteAllChecked => '删除所有已完成';

  @override
  String get addEvent => '添加事件';

  @override
  String get eventName => '事件名称';

  @override
  String get eventNote => '事件备注';

  @override
  String get createEvent => '创建事件';

  @override
  String get editEvent => '编辑事件';

  @override
  String get deleteEvent => '删除事件';

  @override
  String get addChecklistToPool => '添加清单到池';

  @override
  String get signOut => '退出登录';

  @override
  String get deleteAccount => '删除账户';

  @override
  String get language => '语言';

  @override
  String get english => '英语';

  @override
  String get chinese => '中文';

  @override
  String get systemDefault => '系统默认';

  @override
  String get makeRecurring => '设为循环事件';

  @override
  String get welcomeBack => '欢迎回来';

  @override
  String get enterEmailValidation => '请输入邮箱';

  @override
  String get enterPasswordValidation => '密码长度至少6位';

  @override
  String get forgetPassword => '忘记密码？';

  @override
  String get couldNotSignIn => '无法登录';

  @override
  String get dontHaveAccount => '没有账号？';

  @override
  String get couldNotSignUp => '无法注册';

  @override
  String get alreadyHaveAccount => '已有账号？';

  @override
  String get confirmDeleteAccountTitle => '确认删除账户';

  @override
  String get confirmDeleteAccountContent => '您确定要删除您的账户吗？此操作无法撤销。';

  @override
  String get cancelButton => '取消';

  @override
  String get deleteButton => '删除';

  @override
  String get repeatEvery => '重复间隔';

  @override
  String get days => '天';

  @override
  String get weeks => '周';

  @override
  String get months => '月';

  @override
  String get scheduledTime => '预定时间:';

  @override
  String eventChecklistAdded(Object eventName) {
    return '$eventName 清单已添加到池中！';
  }

  @override
  String get addChecklistItemToEvent => '添加清单项到事件';

  @override
  String get itemContent => '项目内容';

  @override
  String get add => '添加';

  @override
  String error(Object errorMessage) {
    return '错误: $errorMessage';
  }

  @override
  String get noEventsYet => '暂无事件！';

  @override
  String get removeChecklistItems => '移除清单项';

  @override
  String get doneRemovingItems => '完成移除';

  @override
  String get noneSortOption => '无';

  @override
  String get alphabeticalSortOption => '按字母顺序';

  @override
  String get checkedStatusSortOption => '按选中状态';

  @override
  String get addedTimeSortOption => '按添加时间';

  @override
  String get noChecklistItemsYet => '暂无清单项！';
}
