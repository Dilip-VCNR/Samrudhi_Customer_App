class UrlConstant {
  static const String googleApiKey = "AIzaSyC6O2CG9zBAksJH4SCgCZlbx3XRWVwzY1E";

  static const String websiteBaseUrl = "http://santhuofficial123.pythonanywhere.com/";
  static const String imageBaseUrl = "http://103.120.63.7:8020";
  static const String apiBaseUrl = "http://103.120.63.7:8020/api/";
  static const String userDetails = "${apiBaseUrl}customer/getCustomerById";
  static const String registerUser = "${apiBaseUrl}customer/registerCustomer";
  static const String userHomePage = "${apiBaseUrl}customer/customerHomepage";
  static const String getStoreData = "${apiBaseUrl}store/getCategoryAndProductOnStore";
  static const String addNewAddress = "${apiBaseUrl}customer/addCustomerAddress";
  static const String deleteAddress = "${apiBaseUrl}customer/deleteCustomerAddress";
  static const String searchApiUrl = "${apiBaseUrl}store/searchApi";
  static const String reviewCart = "${apiBaseUrl}order/reviewCart";
  static const String placeOrder = "${apiBaseUrl}order/placeOrder";
  static const String getWallet = "${apiBaseUrl}customerPoint/getCustomerPoints";

  static const String getUserProfile = "${apiBaseUrl}get_user_profile";
  static const String privacyPolicy = "${websiteBaseUrl}p/privacy-policy";
  static const String termsOfUse = "${websiteBaseUrl}p/t-c";
  static const String faq = "${websiteBaseUrl}p/t-c";
  static const String about = "${websiteBaseUrl}p/t-c";
}
