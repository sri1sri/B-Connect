class APIPath {
  static String employeeDetails(String uid) => 'employees/$uid';
  static String employeesList() => 'employees';
  static String goodsEntry(String itemID) => 'goods_entry/$itemID';
  static String notification(String notificationID) => 'notifications/$notificationID';
  static String goodsEntriesList() => 'goods_entry/';
  static String addItem(String goodsID, String itemID) => 'goods_entry/$goodsID/items/$itemID';
}