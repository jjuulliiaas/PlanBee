// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `PlanBee`
  String get appName {
    return Intl.message('PlanBee', name: 'appName', desc: '', args: []);
  }

  /// `Cancel`
  String get cancel {
    return Intl.message('Cancel', name: 'cancel', desc: '', args: []);
  }

  /// `Save`
  String get save {
    return Intl.message('Save', name: 'save', desc: '', args: []);
  }

  /// `Confirm`
  String get confirm {
    return Intl.message('Confirm', name: 'confirm', desc: '', args: []);
  }

  /// `Today`
  String get today {
    return Intl.message('Today', name: 'today', desc: '', args: []);
  }

  /// `Tomorrow`
  String get tomorrow {
    return Intl.message('Tomorrow', name: 'tomorrow', desc: '', args: []);
  }

  /// `New Task`
  String get newTask {
    return Intl.message('New Task', name: 'newTask', desc: '', args: []);
  }

  /// `Task title...`
  String get taskTitle {
    return Intl.message('Task title...', name: 'taskTitle', desc: '', args: []);
  }

  /// `Add description (optional)`
  String get addDescription {
    return Intl.message(
      'Add description (optional)',
      name: 'addDescription',
      desc: '',
      args: [],
    );
  }

  /// `Deadline`
  String get deadline {
    return Intl.message('Deadline', name: 'deadline', desc: '', args: []);
  }

  /// `Set Date`
  String get setDate {
    return Intl.message('Set Date', name: 'setDate', desc: '', args: []);
  }

  /// `Set Time`
  String get setTime {
    return Intl.message('Set Time', name: 'setTime', desc: '', args: []);
  }

  /// `Category`
  String get category {
    return Intl.message('Category', name: 'category', desc: '', args: []);
  }

  /// `Choose category`
  String get chooseCategory {
    return Intl.message(
      'Choose category',
      name: 'chooseCategory',
      desc: '',
      args: [],
    );
  }

  /// `High priority`
  String get highPriority {
    return Intl.message(
      'High priority',
      name: 'highPriority',
      desc: '',
      args: [],
    );
  }

  /// `Morning (9 AM)`
  String get timeMorning {
    return Intl.message(
      'Morning (9 AM)',
      name: 'timeMorning',
      desc: '',
      args: [],
    );
  }

  /// `Evening (7 PM)`
  String get timeEvening {
    return Intl.message(
      'Evening (7 PM)',
      name: 'timeEvening',
      desc: '',
      args: [],
    );
  }

  /// `+1 Hour`
  String get plusOneHour {
    return Intl.message('+1 Hour', name: 'plusOneHour', desc: '', args: []);
  }

  /// `Health`
  String get health {
    return Intl.message('Health', name: 'health', desc: '', args: []);
  }

  /// `Personal`
  String get personal {
    return Intl.message('Personal', name: 'personal', desc: '', args: []);
  }

  /// `Home`
  String get home {
    return Intl.message('Home', name: 'home', desc: '', args: []);
  }

  /// `Work`
  String get work {
    return Intl.message('Work', name: 'work', desc: '', args: []);
  }

  /// `Study`
  String get study {
    return Intl.message('Study', name: 'study', desc: '', args: []);
  }

  /// `Finance`
  String get finance {
    return Intl.message('Finance', name: 'finance', desc: '', args: []);
  }

  /// `No Category`
  String get noCategory {
    return Intl.message('No Category', name: 'noCategory', desc: '', args: []);
  }

  /// `Add New Category`
  String get createNewCategory {
    return Intl.message(
      'Add New Category',
      name: 'createNewCategory',
      desc: '',
      args: [],
    );
  }

  /// `Category title`
  String get categoryTitle {
    return Intl.message(
      'Category title',
      name: 'categoryTitle',
      desc: '',
      args: [],
    );
  }

  /// `Select icon`
  String get selectIcon {
    return Intl.message('Select icon', name: 'selectIcon', desc: '', args: []);
  }

  /// `Edit Task`
  String get editTask {
    return Intl.message('Edit Task', name: 'editTask', desc: '', args: []);
  }

  /// `Update`
  String get update {
    return Intl.message('Update', name: 'update', desc: '', args: []);
  }

  /// `Today's plan`
  String get todaysPlan {
    return Intl.message(
      'Today\'s plan',
      name: 'todaysPlan',
      desc: '',
      args: [],
    );
  }

  /// `Add`
  String get addTask {
    return Intl.message('Add', name: 'addTask', desc: '', args: []);
  }

  /// `YESTERDAY SUCCESS`
  String get yesterdaySuccess {
    return Intl.message(
      'YESTERDAY SUCCESS',
      name: 'yesterdaySuccess',
      desc: '',
      args: [],
    );
  }

  /// `You completed {count} tasks.`
  String completedTasks(Object count) {
    return Intl.message(
      'You completed $count tasks.',
      name: 'completedTasks',
      desc: '',
      args: [count],
    );
  }

  /// `Busy Bee! 🐝`
  String get busyBee {
    return Intl.message('Busy Bee! 🐝', name: 'busyBee', desc: '', args: []);
  }

  /// `Timer is running... {time}`
  String timerIsRunning(String time) {
    return Intl.message(
      'Timer is running... $time',
      name: 'timerIsRunning',
      desc: 'Label showing the current status and time of the countdown',
      args: [time],
    );
  }

  /// `Yesterday`
  String get yesterday {
    return Intl.message('Yesterday', name: 'yesterday', desc: '', args: []);
  }

  /// `Task Details`
  String get taskDetails {
    return Intl.message(
      'Task Details',
      name: 'taskDetails',
      desc: '',
      args: [],
    );
  }

  /// `Edit`
  String get edit {
    return Intl.message('Edit', name: 'edit', desc: '', args: []);
  }

  /// `Description (optional)`
  String get addDescriptionOptional {
    return Intl.message(
      'Description (optional)',
      name: 'addDescriptionOptional',
      desc: '',
      args: [],
    );
  }

  /// `Description`
  String get description {
    return Intl.message('Description', name: 'description', desc: '', args: []);
  }

  /// `Status`
  String get status {
    return Intl.message('Status', name: 'status', desc: '', args: []);
  }

  /// `Focus Timer`
  String get focusTimer {
    return Intl.message('Focus Timer', name: 'focusTimer', desc: '', args: []);
  }

  /// `Start Focus`
  String get startFocus {
    return Intl.message('Start Focus', name: 'startFocus', desc: '', args: []);
  }

  /// `Stop Focus`
  String get stopFocus {
    return Intl.message('Stop Focus', name: 'stopFocus', desc: '', args: []);
  }

  /// `{count}`
  String minutesShort(int count) {
    return Intl.message(
      '$count',
      name: 'minutesShort',
      desc: '',
      args: [count],
    );
  }

  /// `Custom`
  String get custom {
    return Intl.message('Custom', name: 'custom', desc: '', args: []);
  }

  /// `Mark as completed`
  String get markAsCompleted {
    return Intl.message(
      'Mark as completed',
      name: 'markAsCompleted',
      desc: '',
      args: [],
    );
  }

  /// `Task Completed`
  String get taskCompleted {
    return Intl.message(
      'Task Completed',
      name: 'taskCompleted',
      desc: '',
      args: [],
    );
  }

  /// `No description provided`
  String get noDescriptionProvided {
    return Intl.message(
      'No description provided',
      name: 'noDescriptionProvided',
      desc: '',
      args: [],
    );
  }

  /// `Add 5 min`
  String get add5Min {
    return Intl.message('Add 5 min', name: 'add5Min', desc: '', args: []);
  }

  /// `Time's up. Great focus session!`
  String get timeUpGreatFocus {
    return Intl.message(
      'Time\'s up. Great focus session!',
      name: 'timeUpGreatFocus',
      desc: '',
      args: [],
    );
  }

  /// `Done`
  String get done {
    return Intl.message('Done', name: 'done', desc: '', args: []);
  }

  /// `Pause Focus`
  String get pauseFocus {
    return Intl.message('Pause Focus', name: 'pauseFocus', desc: '', args: []);
  }

  /// `Resume Timer`
  String get resumeTimer {
    return Intl.message(
      'Resume Timer',
      name: 'resumeTimer',
      desc: '',
      args: [],
    );
  }

  /// `mins`
  String get minutesUnit {
    return Intl.message('mins', name: 'minutesUnit', desc: '', args: []);
  }

  /// `All Tasks`
  String get allTasks {
    return Intl.message('All Tasks', name: 'allTasks', desc: '', args: []);
  }

  /// `List`
  String get list {
    return Intl.message('List', name: 'list', desc: '', args: []);
  }

  /// `Calendar`
  String get calendar {
    return Intl.message('Calendar', name: 'calendar', desc: '', args: []);
  }

  /// `Planned`
  String get filterPlanned {
    return Intl.message('Planned', name: 'filterPlanned', desc: '', args: []);
  }

  /// `In Progress`
  String get filterInProgress {
    return Intl.message(
      'In Progress',
      name: 'filterInProgress',
      desc: '',
      args: [],
    );
  }

  /// `Completed`
  String get filterCompleted {
    return Intl.message(
      'Completed',
      name: 'filterCompleted',
      desc: '',
      args: [],
    );
  }

  /// `Missed`
  String get filterMissed {
    return Intl.message('Missed', name: 'filterMissed', desc: '', args: []);
  }

  /// `Sort Tasks`
  String get sortTasks {
    return Intl.message('Sort Tasks', name: 'sortTasks', desc: '', args: []);
  }

  /// `Newest First`
  String get sortNewest {
    return Intl.message('Newest First', name: 'sortNewest', desc: '', args: []);
  }

  /// `Oldest First`
  String get sortOldest {
    return Intl.message('Oldest First', name: 'sortOldest', desc: '', args: []);
  }

  /// `High Priority`
  String get sortHighPriority {
    return Intl.message(
      'High Priority',
      name: 'sortHighPriority',
      desc: '',
      args: [],
    );
  }

  /// `Alphabet (A-Z)`
  String get sortAlphabet {
    return Intl.message(
      'Alphabet (A-Z)',
      name: 'sortAlphabet',
      desc: '',
      args: [],
    );
  }

  /// `No tasks found 🐝`
  String get noTasksFound {
    return Intl.message(
      'No tasks found 🐝',
      name: 'noTasksFound',
      desc: '',
      args: [],
    );
  }

  /// `Statistics`
  String get statistics {
    return Intl.message('Statistics', name: 'statistics', desc: '', args: []);
  }

  /// `Overview`
  String get overview {
    return Intl.message('Overview', name: 'overview', desc: '', args: []);
  }

  /// `Tasks created`
  String get tasksCreated {
    return Intl.message(
      'Tasks created',
      name: 'tasksCreated',
      desc: '',
      args: [],
    );
  }

  /// `To do`
  String get toDo {
    return Intl.message('To do', name: 'toDo', desc: '', args: []);
  }

  /// `Completed`
  String get completed {
    return Intl.message('Completed', name: 'completed', desc: '', args: []);
  }

  /// `Remaining`
  String get remaining {
    return Intl.message('Remaining', name: 'remaining', desc: '', args: []);
  }

  /// `Activity`
  String get activity {
    return Intl.message('Activity', name: 'activity', desc: '', args: []);
  }

  /// `Weekly`
  String get weekly {
    return Intl.message('Weekly', name: 'weekly', desc: '', args: []);
  }

  /// `Yearly`
  String get yearly {
    return Intl.message('Yearly', name: 'yearly', desc: '', args: []);
  }

  /// `Daily completion rate`
  String get dailyRate {
    return Intl.message(
      'Daily completion rate',
      name: 'dailyRate',
      desc: '',
      args: [],
    );
  }

  /// `Monthly consistency`
  String get monthlyConsistency {
    return Intl.message(
      'Monthly consistency',
      name: 'monthlyConsistency',
      desc: '',
      args: [],
    );
  }

  /// `Low`
  String get low {
    return Intl.message('Low', name: 'low', desc: '', args: []);
  }

  /// `High`
  String get high {
    return Intl.message('High', name: 'high', desc: '', args: []);
  }

  /// `Golden Bee Hour`
  String get goldenBeeHour {
    return Intl.message(
      'Golden Bee Hour',
      name: 'goldenBeeHour',
      desc: '',
      args: [],
    );
  }

  /// `Progress by category`
  String get progressByCategory {
    return Intl.message(
      'Progress by category',
      name: 'progressByCategory',
      desc: '',
      args: [],
    );
  }

  /// `Jan`
  String get monthJan {
    return Intl.message('Jan', name: 'monthJan', desc: '', args: []);
  }

  /// `Feb`
  String get monthFeb {
    return Intl.message('Feb', name: 'monthFeb', desc: '', args: []);
  }

  /// `Mar`
  String get monthMar {
    return Intl.message('Mar', name: 'monthMar', desc: '', args: []);
  }

  /// `Apr`
  String get monthApr {
    return Intl.message('Apr', name: 'monthApr', desc: '', args: []);
  }

  /// `May`
  String get monthMay {
    return Intl.message('May', name: 'monthMay', desc: '', args: []);
  }

  /// `Jun`
  String get monthJun {
    return Intl.message('Jun', name: 'monthJun', desc: '', args: []);
  }

  /// `Jul`
  String get monthJul {
    return Intl.message('Jul', name: 'monthJul', desc: '', args: []);
  }

  /// `Aug`
  String get monthAug {
    return Intl.message('Aug', name: 'monthAug', desc: '', args: []);
  }

  /// `Sep`
  String get monthSep {
    return Intl.message('Sep', name: 'monthSep', desc: '', args: []);
  }

  /// `Oct`
  String get monthOct {
    return Intl.message('Oct', name: 'monthOct', desc: '', args: []);
  }

  /// `Nov`
  String get monthNov {
    return Intl.message('Nov', name: 'monthNov', desc: '', args: []);
  }

  /// `Dec`
  String get monthDec {
    return Intl.message('Dec', name: 'monthDec', desc: '', args: []);
  }

  /// `Mo`
  String get dayMon {
    return Intl.message('Mo', name: 'dayMon', desc: '', args: []);
  }

  /// `Tu`
  String get dayTue {
    return Intl.message('Tu', name: 'dayTue', desc: '', args: []);
  }

  /// `We`
  String get dayWed {
    return Intl.message('We', name: 'dayWed', desc: '', args: []);
  }

  /// `Th`
  String get dayThu {
    return Intl.message('Th', name: 'dayThu', desc: '', args: []);
  }

  /// `Fr`
  String get dayFri {
    return Intl.message('Fr', name: 'dayFri', desc: '', args: []);
  }

  /// `Sa`
  String get daySat {
    return Intl.message('Sa', name: 'daySat', desc: '', args: []);
  }

  /// `Su`
  String get daySun {
    return Intl.message('Su', name: 'daySun', desc: '', args: []);
  }

  /// `Settings`
  String get settings {
    return Intl.message('Settings', name: 'settings', desc: '', args: []);
  }

  /// `General`
  String get general {
    return Intl.message('General', name: 'general', desc: '', args: []);
  }

  /// `Language`
  String get language {
    return Intl.message('Language', name: 'language', desc: '', args: []);
  }

  /// `Data Management`
  String get dataManagement {
    return Intl.message(
      'Data Management',
      name: 'dataManagement',
      desc: '',
      args: [],
    );
  }

  /// `Clear All Data`
  String get clearAllData {
    return Intl.message(
      'Clear All Data',
      name: 'clearAllData',
      desc: '',
      args: [],
    );
  }

  /// `Clear`
  String get clear {
    return Intl.message('Clear', name: 'clear', desc: '', args: []);
  }

  /// `Clear All Data?`
  String get clearAllDataTitle {
    return Intl.message(
      'Clear All Data?',
      name: 'clearAllDataTitle',
      desc: '',
      args: [],
    );
  }

  /// `This action is permanent. All your tasks will be deleted.`
  String get clearAllDataDescription {
    return Intl.message(
      'This action is permanent. All your tasks will be deleted.',
      name: 'clearAllDataDescription',
      desc: '',
      args: [],
    );
  }

  /// `Planned`
  String get statusPlanned {
    return Intl.message('Planned', name: 'statusPlanned', desc: '', args: []);
  }

  /// `In Progress`
  String get statusInProgress {
    return Intl.message(
      'In Progress',
      name: 'statusInProgress',
      desc: '',
      args: [],
    );
  }

  /// `Completed`
  String get statusCompleted {
    return Intl.message(
      'Completed',
      name: 'statusCompleted',
      desc: '',
      args: [],
    );
  }

  /// `Missed`
  String get statusMissed {
    return Intl.message('Missed', name: 'statusMissed', desc: '', args: []);
  }

  /// `Free day! 🐝`
  String get freeDay {
    return Intl.message('Free day! 🐝', name: 'freeDay', desc: '', args: []);
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'uk'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
