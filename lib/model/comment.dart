import 'package:petland/model/user.dart';

class CommentModel {
  String id;
  String content;
  String userId;
  String postId;
  int like;
  UserModel user;
  String createdAt;
  String updatedAt;
  bool isLike = false;

  CommentModel(
      {this.id,
      this.content,
      this.userId,
      this.postId,
      this.like,
      this.user,
      this.createdAt,
      this.updatedAt});

  CommentModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    content = json['content'];
    userId = json['userId'];
    postId = json['postId'];
    like = json['like'];
    user = json['user'] != null ? UserModel.fromJson(json['user']) : null;
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['content'] = this.content;
    data['userId'] = this.userId;
    data['postId'] = this.postId;
    data['like'] = this.like;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
