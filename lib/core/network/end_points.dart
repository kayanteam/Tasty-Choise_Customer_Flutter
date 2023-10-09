// ignore_for_file: constant_identifier_names

class EndPoints {
  static const String BASE_URL = 'https://taqiemi.loofy92.com/api';
  // ! Auth
  static const String REGISTR = '/users/register';
  static const String LOGIN = '/users/login';
  static const String VERIFY_CODE = '/users/verify-code';
  static const String FORGET_PASSWORD = '/users/forget-password';
  static const String RESET_PASSWORD = '/users/reset-password';

  static const String LOGOUT = '/users/logout';
  static const String UPDATE_ACCOUNT_DATA = '/users/update-profile';
  static const String CHANGE_PASSWORD = '/users/change-password';
  static const String UPDATE_ACCOUNT_IMAGE = '/users/update-image';

  static const String APP_CONFIG = '/partners/app';
  static const String HOME = '/users/home';
  static const String PRODUCT = '/users/products';
  static const String MAKE_ORDER = '/users/make-order';

  static const String PRODUCT_UPDATED = '/partners/update-product';

  static const String ORDER = '/users/showOrders?status=';
  static const String ORDER_STATUS = '/users/updateOrder';

  static const String NOTIFICATIONS = '/users/notifications';
  static const String RESTAURANT = '/users/restaurants';

  static const String APP_SETTINGS = '/partners/settings';

  static const String WALLET = '/partners/wallet';
  static const String REQUEST_MONY = '/partners/request-money';

  static const String SUBSCRIBTION = '/partners/subscriptions';
}
