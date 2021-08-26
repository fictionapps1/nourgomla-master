class SurveyModel {
  int id;
  String question;
  String answer1;
  String answer2;
  String answer3;
  String answer4;
  String answer5;
  int imageId;
  int status;
  int type;
  int points;
  String endDate;
  String imagesPath;
  String selectedChoice;

  SurveyModel(
      {this.id,
      this.question,
      this.answer1,
      this.answer2,
      this.answer3,
      this.answer4,
      this.answer5,
      this.imageId,
      this.status,
      this.type,
      this.points,
      this.endDate,
      this.selectedChoice,
      this.imagesPath});

  SurveyModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    question = json['question'];
    answer1 = json['answer_1'];
    answer2 = json['answer_2'];
    answer3 = json['answer_3'];
    answer4 = json['answer_4'];
    answer5 = json['answer_5'];
    imageId = json['image_id'];
    status = json['status'];
    type = json['type'];
    points = json['points'];
    endDate = json['end_date'];
    imagesPath = json['images_path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['question'] = this.question;
    data['answer_1'] = this.answer1;
    data['answer_2'] = this.answer2;
    data['answer_3'] = this.answer3;
    data['answer_4'] = this.answer4;
    data['answer_5'] = this.answer5;
    data['image_id'] = this.imageId;
    data['status'] = this.status;
    data['type'] = this.type;
    data['points'] = this.points;
    data['end_date'] = this.endDate;
    data['images_path'] = this.imagesPath;
    return data;
  }
}
