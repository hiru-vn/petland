class FbInboxUserModel {
  final String id;
  final String image;
  final String name;
  final List<String> group;

  FbInboxUserModel(this.id, this.image, this.name, this.group);

  factory FbInboxUserModel.fromJson(Map<String, dynamic> map) {
    return FbInboxUserModel(map['id'], map['image'], map['name'],
        map['groups'] == null ? [] : (map['groups'] as List).cast<String>());
  }
}

class FbInboxGroupModel {
  final String id;
  final String image;
  final String lastMessage;
  final String lastUser;
  final String time;
  final List<String> reader;
  final List<String> users;

  FbInboxGroupModel(this.id, this.image, this.lastMessage, this.lastUser,
      this.time, this.reader, this.users);

  factory FbInboxGroupModel.fromJson(Map<String, dynamic> map, String id) {
    return FbInboxGroupModel(
        id,
        map['image'],
        map['lastMessage'],
        map["lastUser"],
        map['time'],
        map['reader'] == null ? [] : (map['reader'] as List).cast<String>(),
        map['users'] == null ? [] : (map['users'] as List).cast<String>());
  }
}

class FbInboxMessageModel {
  final String id;
  final String avatar;
  final String date;
  final String fullName;
  final String text;
  final String uid; //userId
  final String filePath;

  FbInboxMessageModel(this.id, this.avatar, this.date, this.fullName, this.text,
      this.uid, this.filePath);

  factory FbInboxMessageModel.fromJson(Map<String, dynamic> map, String id) {
    return FbInboxMessageModel(
        id,
        map['avatar'],
        map['date'],
        map["fullName"],
        map['text'],
        map['uid'],
        map['filePath'] == '' ? null : map['filePath']);
  }
}
