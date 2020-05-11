class APIPath {
  static String employeeDetails(String uid) => 'employees/$uid';
  static String employeesList() => 'employees';

  static String goodsEntry(String itemID) => 'goods_entry/$itemID';
  static String goodsEntriesList() => 'goods_entry/';

  static String addItem(String itemID) => 'items/$itemID';
  static String viewItemsList() => 'items/';

  static String notification(String notificationID) => 'notifications/$notificationID';

  static String commonVariables() => 'common_variables/6r2stU44qAbxESqfPc2v';

  static String addCart(String cartID) => 'cart/$cartID';
  static String viewCart() => 'cart/';

  static String addInventry(String inventryID) => 'inventry/$inventryID';
  static String viewInventry() => 'inventry/';

  static String ordersEntry(String orderID) => 'orders/$orderID';
  static String viewOrders() => 'orders/';

  static String attandanceEntry(String uid, String attendanceID) => 'employees/$uid/attendance/$attendanceID';
  static String viewAttandance(String uid) => 'employees/$uid/attendance';

}