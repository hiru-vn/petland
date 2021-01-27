import 'package:petland/model/type_wiki.dart';

class WikiCategoryModel {
  String id;
  TypeOfWikiModel typeOfwiki;
  String title;
  String image;
  int numberOfPost;
  String createdAt;
  String updatedAt;

  WikiCategoryModel(
      {this.id,
      this.typeOfwiki,
      this.title,
      this.image,
      this.numberOfPost,
      this.createdAt,
      this.updatedAt});

  WikiCategoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    typeOfwiki = json['typeOfwiki'] != null
        ? new TypeOfWikiModel.fromJson(json['typeOfwiki'])
        : null;
    title = json['title'];
    image = json['image'];
    numberOfPost = json['numberOfPost'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.typeOfwiki != null) {
      data['typeOfwiki'] = this.typeOfwiki.toJson();
    }
    data['title'] = this.title;
    data['image'] = this.image;
    data['numberOfPost'] = this.numberOfPost;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
