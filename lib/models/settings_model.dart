class Settings {
  String pointsEnabled;
  String loadingIconColor;
  String loadingIcon;
  String phoneAuthRequired;
  String uploadImageRequired;
  String activationRequired;
  String billProductWidget;
  String reviewEnabled;
  String multiVendor;
  String filter1Bar;
  String filter2Bar;
  String filter3Bar;
  String filter1Page;
  String filter2Page;
  String filter3Page;
  int availablePackaging;
  int version;
  String productBuilderType;
  String forceUpdate;
  String color1;
  String color2;
  String color3;
  String color4;
  String color5;
  String color6;
  String color7;
  String color8;
  String color9;
  String color10;

  Settings({
    this.uploadImageRequired,
    this.activationRequired,
    this.phoneAuthRequired,
    this.billProductWidget,
    this.pointsEnabled,
    this.availablePackaging,
    this.color1,
    this.color2,
    this.color3,
    this.color4,
    this.color5,
    this.color6,
    this.color7,
    this.color8,
    this.color9,
    this.color10,
    this.loadingIconColor,
    this.loadingIcon,
    this.productBuilderType,
    this.reviewEnabled,
    this.multiVendor,
    this.forceUpdate,
    this.version,
  });

  Settings.fromJson(Map json) {
    this.color1 = json['color_1'];
    this.color2 = json['color_2'];
    this.color3 = json['color_3'];
    this.color4 = json['color_4'];
    this.color5 = json['color_5'];
    this.color6 = json['color_6'];
    this.color7 = json['color_7'];
    this.color8 = json['color_8'];
    this.color9 = json['color_9'];
    this.color10 = json['color_10'];
    this.loadingIcon = json['loading_icon'];
    this.loadingIconColor = json['loading_icon_color'];
    this.pointsEnabled = json['if_points'];
    this.activationRequired = json['user_activation_required'];
    this.uploadImageRequired = json['user_upload_image'];
    this.phoneAuthRequired = json['phone_auth_required'];
    this.billProductWidget = json['bill_product_widget'];
    this.filter1Bar = json['filter_1_bar'];
    this.filter2Bar = json['filter_2_bar'];
    this.filter3Bar = json['filter_3_bar'];
    this.filter1Page = json['filter_1_page'];
    this.filter2Page = json['filter_2_page'];
    this.filter3Page = json['filter_3_page'];
    this.productBuilderType = json['products_template'];
    this.reviewEnabled = json['product_review'];
    this.multiVendor = json['multi_vendor'];
    this.forceUpdate = json['force_update'];
    this.availablePackaging = int.parse(json['package_products']);
    this.version = int.parse(json['version']);
  }
}
