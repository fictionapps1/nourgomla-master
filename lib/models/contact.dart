class Contact {
  String id;
  String name;
  String phone;

  Contact.fromJson(Map json) {
    this.id = json['id'];
    this.name = json['name'];
    this.phone = json['phone'];
  }
}
