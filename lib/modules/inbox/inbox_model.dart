class FbInboxUserModel {
  final String id;
  final String image;
  final String name;
  final List<String> group;

  FbInboxUserModel(this.id, this.image, this.name, this.group);

  factory FbInboxUserModel.fromJson(Map<String, dynamic> map) {
    return FbInboxUserModel(map['id'], map['image'], map['name'],
        (map['groups'] as List).cast<String>());
  }
}

class FbInboxGroupModel {
  final String id;
  final String image;
  final String lastMessage;
  final String lastUser;
  final String time;
  final List<String> reader;

  FbInboxGroupModel(this.id, this.image, this.lastMessage, this.lastUser,
      this.time, this.reader);

  factory FbInboxGroupModel.fromJson(Map<String, dynamic> map, String id) {
    return FbInboxGroupModel(id, map['image'], map['lastMessage'],
        map["lastUser"], map['time'], map['reader'] ?? []);
  }
}
