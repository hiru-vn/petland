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
  List<String> image;
  List<String> video;
  List<String> commentIds;
  int like;
  int share;
  User user;
  String userId;
  String createdAt;
  String updatedAt;

  PostModel(
      {this.id,
      this.content,
      this.image,
      this.video,
      this.commentIds,
      this.like,
      this.share,
      this.user,
      this.userId,
      this.createdAt,
      this.updatedAt});

  PostModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    content = json['content'];
    image = json['image'].cast<String>();
    video = json['video'].cast<String>();
    commentIds = json['commentIds'].cast<String>();
    like = json['like'];
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
    data['image'] = this.image;
    data['video'] = this.video;
    data['commentIds'] = this.commentIds;
    data['like'] = this.like;
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
