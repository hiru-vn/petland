class Post {
  String ownerName;
  String petName;
  DateTime time;
  String content;
  List<String> images;

  Post({this.content, this.images, this.ownerName, this.time, this.petName});
}

var postData = [
  Post(
      content:
          'Me getting off the bed on Monday morning, realize im just a cat and aint do nothing',
      images: [
        'assets/image/cat1.png',
        'assets/image/cat2.png',
        'assets/image/cat3.png'
      ],
      petName: 'Fat man',
      ownerName: 'PetChoy'),
  Post(
      content:
          'Me getting off the bed on Monday morning, realize im just a cat and aint do nothing',
      images: [
        'assets/image/cat1.png',
        'assets/image/cat2.png',
        'assets/image/cat3.png'
      ],
      petName: 'Fat man',
      ownerName: 'PetChoy'),
  Post(
      content:
          'Me getting off the bed on Monday morning, realize im just a cat and aint do nothing',
      images: [
        'assets/image/cat1.png',
        'assets/image/cat2.png',
        'assets/image/cat3.png'
      ],
      petName: 'Fat man',
      ownerName: 'PetChoy'),
];

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
  User user;
  String userId;
  String createdAt;
  String updatedAt;

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
      this.updatedAt});

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
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    userId = json['userId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
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
    return data;
  }
}

class User {
  String id;
  String uid;
  String name;
  String email;
  String phone;
  String avatar;
  String description;
  String nickName;
  String backgroundimage;
  List<String> follows;

  User(
      {this.id,
      this.uid,
      this.name,
      this.email,
      this.phone,
      this.avatar,
      this.description,
      this.nickName,
      this.backgroundimage,
      this.follows});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uid = json['uid'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    avatar = json['avatar'];
    description = json['description'];
    nickName = json['nickName'];
    backgroundimage = json['backgroundimage'];
    follows = json['follows'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['uid'] = this.uid;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['avatar'] = this.avatar;
    data['description'] = this.description;
    data['nickName'] = this.nickName;
    data['backgroundimage'] = this.backgroundimage;
    data['follows'] = this.follows;
    return data;
  }
}