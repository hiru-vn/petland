import 'user.dart';

class PostModel {
  String id;
  String content;
  List<String> images;
  List<String> videos;
  List<String> commentIds;
  int like;
  List<String> tags;
  List<String> petTags;
  int share;
  UserModel user;
  String userId;
  String createdAt;
  String updatedAt;
  bool makePublic;

  PostModel(
      {this.id,
      this.content,
      this.images,
      this.videos,
      this.commentIds,
      this.like,
      this.tags,
      this.petTags,
      this.share,
      this.user,
      this.userId,
      this.createdAt,
      this.updatedAt,
      this.makePublic});

  PostModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    content = json['content'];
    images = json['images'].cast<String>();
    videos = json['videos'].cast<String>();
    commentIds = json['commentIds'].cast<String>();
    like = json['like'];
    tags = json['tags'].cast<String>();
    petTags = json['petTags'].cast<String>();
    share = json['share'];
    user = json['user'] != null ? UserModel.fromJson(json['user']) : null;
    userId = json['userId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    makePublic = json['makePublic'] ?? true;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['content'] = this.content;
    data['images'] = this.images;
    data['videos'] = this.videos;
    data['commentIds'] = this.commentIds;
    data['like'] = this.like;
    data['tags'] = this.tags;
    data['petTags'] = this.petTags;
    data['share'] = this.share;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    data['userId'] = this.userId;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['makePublic'] = this.makePublic;
    return data;
  }
}
