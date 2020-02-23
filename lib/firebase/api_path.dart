class APIPath {
  static String employeeDetails(String uid) => 'employees/$uid';
  static String employeesList() => 'employees';
  static String itemEntry(String itemID) => 'items_entry/$itemID';
  static String notification(String notificationID) => 'notifications/$notificationID';
  static String itemEntriesList() => 'items_entry/';
}