// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static String m0(count) => "You completed ${count} tasks.";

  static String m1(count) => "${count}";

  static String m2(time) => "Timer is running... ${time}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "activity": MessageLookupByLibrary.simpleMessage("Activity"),
    "add5Min": MessageLookupByLibrary.simpleMessage("Add 5 min"),
    "addDescription": MessageLookupByLibrary.simpleMessage(
      "Add description (optional)",
    ),
    "addDescriptionOptional": MessageLookupByLibrary.simpleMessage(
      "Description (optional)",
    ),
    "addTask": MessageLookupByLibrary.simpleMessage("Add"),
    "allTasks": MessageLookupByLibrary.simpleMessage("All Tasks"),
    "appName": MessageLookupByLibrary.simpleMessage("PlanBee"),
    "busyBee": MessageLookupByLibrary.simpleMessage("Busy Bee! 🐝"),
    "calendar": MessageLookupByLibrary.simpleMessage("Calendar"),
    "cancel": MessageLookupByLibrary.simpleMessage("Cancel"),
    "category": MessageLookupByLibrary.simpleMessage("Category"),
    "categoryTitle": MessageLookupByLibrary.simpleMessage("Category title"),
    "chooseCategory": MessageLookupByLibrary.simpleMessage("Choose category"),
    "clear": MessageLookupByLibrary.simpleMessage("Clear"),
    "clearAllData": MessageLookupByLibrary.simpleMessage("Clear All Data"),
    "completed": MessageLookupByLibrary.simpleMessage("Completed"),
    "completedTasks": m0,
    "confirm": MessageLookupByLibrary.simpleMessage("Confirm"),
    "createNewCategory": MessageLookupByLibrary.simpleMessage(
      "Add New Category",
    ),
    "custom": MessageLookupByLibrary.simpleMessage("Custom"),
    "dailyRate": MessageLookupByLibrary.simpleMessage("Daily completion rate"),
    "dataManagement": MessageLookupByLibrary.simpleMessage("Data Management"),
    "dayFri": MessageLookupByLibrary.simpleMessage("Fr"),
    "dayMon": MessageLookupByLibrary.simpleMessage("Mo"),
    "daySat": MessageLookupByLibrary.simpleMessage("Sa"),
    "daySun": MessageLookupByLibrary.simpleMessage("Su"),
    "dayThu": MessageLookupByLibrary.simpleMessage("Th"),
    "dayTue": MessageLookupByLibrary.simpleMessage("Tu"),
    "dayWed": MessageLookupByLibrary.simpleMessage("We"),
    "deadline": MessageLookupByLibrary.simpleMessage("Deadline"),
    "description": MessageLookupByLibrary.simpleMessage("Description"),
    "done": MessageLookupByLibrary.simpleMessage("Done"),
    "edit": MessageLookupByLibrary.simpleMessage("Edit"),
    "editTask": MessageLookupByLibrary.simpleMessage("Edit Task"),
    "filterCompleted": MessageLookupByLibrary.simpleMessage("Completed"),
    "filterInProgress": MessageLookupByLibrary.simpleMessage("In Progress"),
    "filterMissed": MessageLookupByLibrary.simpleMessage("Missed"),
    "filterPlanned": MessageLookupByLibrary.simpleMessage("Planned"),
    "finance": MessageLookupByLibrary.simpleMessage("Finance"),
    "focusTimer": MessageLookupByLibrary.simpleMessage("Focus Timer"),
    "freeDay": MessageLookupByLibrary.simpleMessage("Free day! 🐝"),
    "general": MessageLookupByLibrary.simpleMessage("General"),
    "goldenBeeHour": MessageLookupByLibrary.simpleMessage("Golden Bee Hour"),
    "health": MessageLookupByLibrary.simpleMessage("Health"),
    "high": MessageLookupByLibrary.simpleMessage("High"),
    "highPriority": MessageLookupByLibrary.simpleMessage("High priority"),
    "home": MessageLookupByLibrary.simpleMessage("Home"),
    "language": MessageLookupByLibrary.simpleMessage("Language"),
    "list": MessageLookupByLibrary.simpleMessage("List"),
    "low": MessageLookupByLibrary.simpleMessage("Low"),
    "markAsCompleted": MessageLookupByLibrary.simpleMessage(
      "Mark as completed",
    ),
    "minutesShort": m1,
    "minutesUnit": MessageLookupByLibrary.simpleMessage("mins"),
    "monthApr": MessageLookupByLibrary.simpleMessage("Apr"),
    "monthAug": MessageLookupByLibrary.simpleMessage("Aug"),
    "monthDec": MessageLookupByLibrary.simpleMessage("Dec"),
    "monthFeb": MessageLookupByLibrary.simpleMessage("Feb"),
    "monthJan": MessageLookupByLibrary.simpleMessage("Jan"),
    "monthJul": MessageLookupByLibrary.simpleMessage("Jul"),
    "monthJun": MessageLookupByLibrary.simpleMessage("Jun"),
    "monthMar": MessageLookupByLibrary.simpleMessage("Mar"),
    "monthMay": MessageLookupByLibrary.simpleMessage("May"),
    "monthNov": MessageLookupByLibrary.simpleMessage("Nov"),
    "monthOct": MessageLookupByLibrary.simpleMessage("Oct"),
    "monthSep": MessageLookupByLibrary.simpleMessage("Sep"),
    "monthlyConsistency": MessageLookupByLibrary.simpleMessage(
      "Monthly consistency",
    ),
    "newTask": MessageLookupByLibrary.simpleMessage("New Task"),
    "noCategory": MessageLookupByLibrary.simpleMessage("No Category"),
    "noDescriptionProvided": MessageLookupByLibrary.simpleMessage(
      "No description provided",
    ),
    "noTasksFound": MessageLookupByLibrary.simpleMessage("No tasks found 🐝"),
    "overview": MessageLookupByLibrary.simpleMessage("Overview"),
    "pauseFocus": MessageLookupByLibrary.simpleMessage("Pause Focus"),
    "personal": MessageLookupByLibrary.simpleMessage("Personal"),
    "plusOneHour": MessageLookupByLibrary.simpleMessage("+1 Hour"),
    "progressByCategory": MessageLookupByLibrary.simpleMessage(
      "Progress by category",
    ),
    "remaining": MessageLookupByLibrary.simpleMessage("Remaining"),
    "resumeTimer": MessageLookupByLibrary.simpleMessage("Resume Timer"),
    "save": MessageLookupByLibrary.simpleMessage("Save"),
    "selectIcon": MessageLookupByLibrary.simpleMessage("Select icon"),
    "setDate": MessageLookupByLibrary.simpleMessage("Set Date"),
    "setTime": MessageLookupByLibrary.simpleMessage("Set Time"),
    "settings": MessageLookupByLibrary.simpleMessage("Settings"),
    "sortAlphabet": MessageLookupByLibrary.simpleMessage("Alphabet (A-Z)"),
    "sortHighPriority": MessageLookupByLibrary.simpleMessage("High Priority"),
    "sortNewest": MessageLookupByLibrary.simpleMessage("Newest First"),
    "sortOldest": MessageLookupByLibrary.simpleMessage("Oldest First"),
    "sortTasks": MessageLookupByLibrary.simpleMessage("Sort Tasks"),
    "startFocus": MessageLookupByLibrary.simpleMessage("Start Focus"),
    "statistics": MessageLookupByLibrary.simpleMessage("Statistics"),
    "status": MessageLookupByLibrary.simpleMessage("Status"),
    "statusCompleted": MessageLookupByLibrary.simpleMessage("Completed"),
    "statusInProgress": MessageLookupByLibrary.simpleMessage("In Progress"),
    "statusMissed": MessageLookupByLibrary.simpleMessage("Missed"),
    "statusPlanned": MessageLookupByLibrary.simpleMessage("Planned"),
    "stopFocus": MessageLookupByLibrary.simpleMessage("Stop Focus"),
    "study": MessageLookupByLibrary.simpleMessage("Study"),
    "taskCompleted": MessageLookupByLibrary.simpleMessage("Task Completed"),
    "taskDetails": MessageLookupByLibrary.simpleMessage("Task Details"),
    "taskTitle": MessageLookupByLibrary.simpleMessage("Task title..."),
    "tasksCreated": MessageLookupByLibrary.simpleMessage("Tasks created"),
    "timeEvening": MessageLookupByLibrary.simpleMessage("Evening (7 PM)"),
    "timeMorning": MessageLookupByLibrary.simpleMessage("Morning (9 AM)"),
    "timeUpGreatFocus": MessageLookupByLibrary.simpleMessage(
      "Time\'s up. Great focus session!",
    ),
    "timerIsRunning": m2,
    "toDo": MessageLookupByLibrary.simpleMessage("To do"),
    "today": MessageLookupByLibrary.simpleMessage("Today"),
    "todaysPlan": MessageLookupByLibrary.simpleMessage("Today\'s plan"),
    "tomorrow": MessageLookupByLibrary.simpleMessage("Tomorrow"),
    "update": MessageLookupByLibrary.simpleMessage("Update"),
    "weekly": MessageLookupByLibrary.simpleMessage("Weekly"),
    "work": MessageLookupByLibrary.simpleMessage("Work"),
    "yearly": MessageLookupByLibrary.simpleMessage("Yearly"),
    "yesterday": MessageLookupByLibrary.simpleMessage("Yesterday"),
    "yesterdaySuccess": MessageLookupByLibrary.simpleMessage(
      "YESTERDAY SUCCESS",
    ),
  };
}
