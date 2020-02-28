class APIPath {
  static String employeeDetails(String uid) => 'employees/$uid';
  static String employeesList() => 'employees';

  static String goodsEntry(String itemID) => 'goods_entry/$itemID';
  static String goodsEntriesList() => 'goods_entry/';

//  static String addItem(String goodsID, String itemID) => 'goods_entry/$goodsID/items/$itemID';
  static String addItem(String itemID) => 'items/$itemID';
  static String viewItemsList(String goodsID) => 'items/';

  static String notification(String notificationID) => 'notifications/$notificationID';

  static String commonVariables() => 'common_variables/6r2stU44qAbxESqfPc2v';

}