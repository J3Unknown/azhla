
class AppConstants {

  //static const String MAIN_URL = "https://etmaaen.com/azhalha/api/"; // 'http://127.0.0.1:8000/api/'; // For Real Devices => run in terminal -> adb reverse tcp:8000 tcp:8000
  //static const String MAIN_URL = "https://ezhalhakw.com/ezhalha/api/"; // 'http://127.0.0.1:8000/api/'; // For Real Devices => run in terminal -> adb reverse tcp:8000 tcp:8000
  static const String MAIN_URL = "https://ezhalhakw.com/mogeeb/api/"; // 'http://127.0.0.1:8000/api/'; // For Real Devices => run in terminal -> adb reverse tcp:8000 tcp:8000
  static const String MAIN_URL_IMAGE = "https://ezhalhakw.com/mogeeb/";
  //static const String MAIN_URL = ''; // For Emulator

  static const String GET_ALL_ADS = 'https://omar.tqnia.me/onstore2/';
  static const String POST_AD = '/api/v2/seller/auth/login';
  static const String LOGIN = MAIN_URL + 'login';
  static const String REGISTER = MAIN_URL + 'register';
  static const String SHOW_CATEGORIES = MAIN_URL + 'categories';

  static const String SPECIAL_REQUEST = '${MAIN_URL}special_request';
  static const String ADD_SPECIAL_REQUEST = '${MAIN_URL}save_special_request';
  static const String DELETE_SPECIAL_REQUEST = '${MAIN_URL}special_request_changeStatus/';
  static const String SAVE_SPECIAL_REQUEST_DETAILS = '${MAIN_URL}save_special_request_details';

  static const double FILTER_MAX_PRICE = 10000000; // 10 000 000
  static const double FILTER_MIN_PRICE = 0; // 0
  static const int FILTER_PRICE_DIVISIONS = 50;
  static const int FILTER_PRICE_DIVISIONS_rent = 500;


  static const String Car_Model = '/api/carModels';
  static const String Car_Type = '/api/carTypes';
  static const String Governance = '/api/cities';
  static const String USER_EARNINGS_URI = '/api/v2/seller/monthly-earning';
  static const String SELLER_AND_BANK_UPDATE = '/api/v2/seller/seller-update';
  static const String SHOP_URI = '/api/v2/seller/shop-info';
  static const String SHOP_UPDATE = '/api/v2/seller/shop-update';
  static const String MESSAGE_URI = '/api/v2/seller/messages/list';
  static const String SEND_MESSAGE_URI = '/api/v2/seller/messages/send';
  static const String ORDER_LIST_URI = '/api/v2/seller/orders/list';
  static const String ORDER_DETAILS = '/api/v2/seller/orders/';
  static const String UPDATE_ORDER_STATUS = '/api/v2/seller/orders/order-detail-status/';
  static const String BALANCE_WITHDRAW = '/api/v2/seller/balance-withdraw';
  static const String CANCEL_BALANCE_REQUEST = '/api/v2/seller/close-withdraw-request';
  static const String TRANSACTIONS_URI = '/api/v2/seller/transactions';


  static const String PENDING = 'pending';
  static const String CONFIRMED = 'confirmed';
  static const String PROCESSING = 'processing';
  static const String PROCESSED = 'processed';
  static const String DELIVERED = 'delivered';
  static const String FAILED = 'failed';
  static const String RETURNED = 'returned';
  static const String CANCELLED = 'cancelled';

  static const String THEME = 'theme';
  static const String CURRENCY = 'currency';
  static const String TOKEN = 'token';
  static const String AUTORIZATION = 'Authorization';
  static const String COUNTRY_CODE = 'country_code';
  static const String LANGUAGE_CODE = 'language_code';
  static const String CART_LIST = 'cart_list';
  static const String USER_ADDRESS = 'user_address';
  static const String USER_PASSWORD = 'user_password';
  static const String USER_NUMBER = 'user_number';
  static const String SEARCH_ADDRESS = 'search_address';
  static const String TOPIC = 'notify';
  static const String USER_EMAIL = 'user_email';

}

class StringsManager{
  static const String dash = '-';
  static const String underScore = '_';
  static const String space = ' ';
  static const String colon = ':';
}

class KeysManager{
  static const String ar = 'ar';
  static const String en = 'en';
  static const String all = 'all';
  static const String allAr = 'الكل';
  static const String dailyEvents = 'Daily Events';
  static const String orderDate = 'OrderDate';
  static const String specialRequest = 'Special Request';
  static const String forMen = 'For Men';
  static const String forWomen = 'For Women';
  static const String female = 'female';
  static const String male = 'male';
  static const String eventReminder = 'Event Reminder';
  static const String confirm = 'Confirm';
  static const String cancel = 'Cancel';
  static const String close = 'close';
  static const String categories = 'Categories';
  static const String events = 'Events';
  static const String addEvent = 'Add Event';
  static const String next = 'Next';
  static const String date = 'Date';
  static const String time = 'Time';
  static const String location = 'Location';
  static const String governance = 'Governance';
  static const String selectDateMessage = 'Please Select desired date and Location';
  static const String requiredFieldMessage = 'This field is required';
  static const String title = 'Title';
  static const String familyName = 'Family Name';
  static const String allFamilies = 'All Families';
  static const String selectedFamily = 'selectedFamily';
  static const String selectedCityPref = 'selectedCity';
  static const String area = 'Area';
  static const String allAreas = 'All Areas';
  static const String selectedArea = 'SelectedArea';
  static const String description = 'Description';
  static const String showImage = 'show image';
  static const String fileDownload = 'FileDownload.pdf';
  static const String typeHere = 'Type Here';
  static const String expectedBudget = 'Expected Budget / QR';
}
