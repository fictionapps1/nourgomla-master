class Rate {
  int id;
  String userName;
  double rate;
  String comment;
  String productNameAr;
  String productNameEn;


  Rate({this.id, this.userName, this.rate, this.comment, this.productNameAr,
      this.productNameEn});

  Rate.fromJson(Map json) {
    this.id = json['id'];
    this.userName = json['user_name'];
    this.comment = json['comment'];
    this.rate = double.parse(json['rate'].toString());
    this.productNameAr = json['name_ar'];
    this.productNameEn = json['name_en'];
  }
}
