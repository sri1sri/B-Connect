class APIPath {
  static String employeeDetails(String uid) => 'employees/$uid';
  static String employeesList() => 'employees';

  static String goodsEntry(String itemID) => 'goods_entry/$itemID';
  static String goodsEntriesList() => 'goods_entry/';

  static String addItem(String itemID) => 'items/$itemID';
  static String viewItemsList() => 'items/';

  static String notification(String notificationID) => 'notifications/$notificationID';

  static String commonVariables() => 'common_variables/6r2stU44qAbxESqfPc2v';

  static String addCart(String CartID) => 'cart/$CartID';
  static String viewCart() => 'cart/';

  static String ordersEntry(String orderID) => 'orders/$orderID';
  static String viewOrders() => 'orders/';

}