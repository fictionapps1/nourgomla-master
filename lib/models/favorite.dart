class Favorite {
  int itemsPerPage;
  int startIndex;
  int userRoleId;
  int languageId;
  String sortBy;
  int userId;

  Favorite(
      {this.itemsPerPage,
      this.startIndex,
      this.userRoleId,
      this.languageId,
      this.sortBy,
      this.userId});

  Favorite.fromJson(Map<String, dynamic> json) {
    itemsPerPage = json['itemsPerPage'];
    startIndex = json['startIndex'];
    userRoleId = json['user_role_id'];
    languageId = json['language_id'];
    sortBy = json['sort_by'];
    userId = json['user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['itemsPerPage'] = this.itemsPerPage;
    data['startIndex'] = this.startIndex;
    data['user_role_id'] = this.userRoleId;
    data['language_id'] = this.languageId;
    data['sort_by'] = this.sortBy;
    data['user_id'] = this.userId;
    return data;
  }
}
