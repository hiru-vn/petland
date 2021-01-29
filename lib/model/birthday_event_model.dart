class BirthdayEventModel {
  String id;
  String petId;
  List<String> images;
  List<String> videos;
  String date;
  bool publicity;
  String content;
  String createdAt;
  String updatedAt;

  BirthdayEventModel(
      {this.id,
      this.petId,
      this.images,
      this.videos,
      this.date,
      this.publicity,
      this.content,
      this.createdAt,
      this.updatedAt});

  BirthdayEventModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    petId = json['petId'];
    images = json['images'].cast<String>();
    videos = json['videos'].cast<String>();
    date = json['date'];
    publicity = json['publicity'];
    content = json['content'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['petId'] = this.petId;
    data['images'] = this.images;
    data['videos'] = this.videos;
    data['date'] = this.date;
    data['publicity'] = this.publicity;
    data['content'] = this.content;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}