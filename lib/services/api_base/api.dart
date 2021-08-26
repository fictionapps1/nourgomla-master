import '../../config/api_links.dart';

enum Endpoints {
  registration,
  login,
  // Media Endpoints
  ImagesSelect,
  // Language Endpoints
  LabelsSelect,
  tabsSelect,
  likedProducts,
  selectedFavourites,
  searchProducts,
  // Category Endpoints
  CategoriesSelect,
  SelectCategoriesType,
  // Products Endpoints
  ProductsSelect,
  // Addresses Endpoints
  addressInsert,
  areaSelect,
  usersAddressSelect,
  usersAddressUpdate,
  usersAddressDelete,

  cartUpdate,
  couponSelect,
  orderInsert,
  ordersSelect,
  ordersProductsSelect,
  userUpdate,
  imagesSelect,
  home,
  userResetPassword,
  settingsSelect,
  areaInsert,
  surveySelect,
  surveyAnswerInsert,
  productDetailsSelect,
  contactUsInsert,
  productReviewInsert,
  productReviewSelect,
  productReviewUpdate,
  vendorsSelect,
  vendorsAreasSelect,
  vendorCategoriesSelect,
  allVendorsSelect,
}

class API {
  Uri endpointUri(Endpoints endpoint) =>
      Uri.parse('${ApiLinks.apiLink}${_paths[endpoint]}');

  static Map<Endpoints, String> _paths = {
    Endpoints.registration: 'registration',
    Endpoints.login: 'login',
    Endpoints.ImagesSelect: 'images_select',
    Endpoints.LabelsSelect: 'labels_select',
    Endpoints.CategoriesSelect: 'categories_select',
    Endpoints.SelectCategoriesType: 'categories_type_select',
    Endpoints.ProductsSelect: 'product_select_app',
    Endpoints.tabsSelect: 'categories_type_select',
    Endpoints.likedProducts: 'liked_products_add_delete?product_id',
    Endpoints.selectedFavourites: 'liked_products',
    Endpoints.searchProducts: 'product_search_app',
    Endpoints.addressInsert: 'users_address_insert',
    Endpoints.areaSelect: 'area_select',
    Endpoints.usersAddressSelect: 'users_address_select',
    Endpoints.usersAddressUpdate: 'users_address_update',
    Endpoints.usersAddressDelete: 'users_address_delete',
    Endpoints.cartUpdate: 'cart_update',
    Endpoints.couponSelect: 'coupon_select_app',
    Endpoints.orderInsert: 'order_insert',
    Endpoints.ordersSelect: 'orders_select',
    Endpoints.ordersProductsSelect: 'orders_products_select',
    Endpoints.userUpdate: 'user_update',
    Endpoints.imagesSelect: 'images_select',
    Endpoints.home: 'home_app',
    Endpoints.userResetPassword: 'user_reset_password',
    Endpoints.settingsSelect: 'settings_select',
    Endpoints.areaInsert: 'area_insert',
    Endpoints.surveySelect: 'survey_questions_select_app',
    Endpoints.surveyAnswerInsert: 'survey_results_insert',
    Endpoints.productDetailsSelect: 'product_page_select_app',
    Endpoints.contactUsInsert: 'connect_us_insert',
    Endpoints.productReviewInsert: 'product_review_insert',
    Endpoints.productReviewSelect: 'product_review_select',
    Endpoints.productReviewUpdate: 'product_review_update',
    Endpoints.vendorsSelect: 'vendors_select',
    Endpoints.vendorCategoriesSelect: 'vendors_categories_select',
    Endpoints.allVendorsSelect: 'categories_of_vendors_select',
    Endpoints.vendorsAreasSelect: 'vendors_area_select',
  };
}
