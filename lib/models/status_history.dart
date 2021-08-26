class StatusHistory {
  int id;
  int orderId;
  int ordersStatusId;
  String nameAr;
  String nameEn;
  String color;
  String comment;
  int createdBy;
  String createdAt;

  StatusHistory(
      {this.id,
        this.orderId,
        this.ordersStatusId,
        this.nameAr,
        this.nameEn,
        this.color,
        this.comment,
        this.createdBy,
        this.createdAt});

  StatusHistory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderId = json['order_id'];
    ordersStatusId = json['orders_status_id'];
    nameAr = json['name_ar'];
    nameEn = json['name_en'];
    color = json['color'];
    comment = json['comment'];
    createdBy = json['created_by'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['order_id'] = this.orderId;
    data['orders_status_id'] = this.ordersStatusId;
    data['name_ar'] = this.nameAr;
    data['name_en'] = this.nameEn;
    data['color'] = this.color;
    data['comment'] = this.comment;
    data['created_by'] = this.createdBy;
    data['created_at'] = this.createdAt;
    return data;
  }
}