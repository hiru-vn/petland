import 'package:petland/modules/inbox/inbox_model.dart';
import 'package:petland/share/import.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class InboxBloc extends ChangeNotifier {
  InboxBloc._privateConstructor();
  static final InboxBloc instance = InboxBloc._privateConstructor();

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  DocumentReference getGroup(String id) {
    return firestore.collection('group').doc(id);
  }

  final userCollection = 'user';
  final groupCollection = 'group';

  Future<void> createGroup(String lastUser, DateTime time, String lastMessage,
      String image, List<String> users) async {
    await firestore.collection(groupCollection).add({
      'lastUser': lastUser,
      'time': time.toIso8601String(),
      'lastMessage': lastMessage,
      'image': image,
      'users': users,
    });
  }

  Future<void> updateGroupOnMessage(String groupid, String lastUser,
      DateTime time, String lastMessage, String image) async {
    final snapShot =
        await firestore.collection(groupCollection).doc(groupid).get();
    if (snapShot.exists) {
      await getGroup(groupid).update({
        'lastUser': lastUser,
        'time': time.toIso8601String(),
        'lastMessage': lastMessage,
        'image': image,
      });
    }
  }

  Future<void> addMessage(String groupId, String text, DateTime time,
      String uid, String fullName, String avatar) {
    return getGroup(groupId).collection("messages").add({
      'text': text,
      'date': time.toIso8601String(),
      'uid': uid,
      'fullName': fullName,
      'avatar': avatar,
    });
  }

  Future<List<FbInboxMessageModel>> get20Messages(String groupId) async {
    final query = getGroup(groupId)
        .collection("messages")
        .orderBy('date', descending: false)
        .limit(20);
    final snapshot = await query.get();
    final res = snapshot.docs.map((e) => FbInboxMessageModel.fromJson(e.data(), e.id)).toList();
    return res;
  }

  Future<void> createUser(String id, String name, String image) async {
    final snapShot = await firestore.collection(userCollection).doc(id).get();
    if (snapShot.exists) {
      await firestore
          .collection(userCollection)
          .doc(id)
          .update({'name': name, 'id': id, 'image': image});
    } else {
      await firestore.collection(userCollection).add({
        'name': name,
        'id': id,
        'image': image,
      });
    }
    return;
  }

  Future<List<String>> get20UserGroupInboxList(String idUser) async {
    final snapShot =
        await firestore.collection(userCollection).doc(idUser).get();
    return FbInboxUserModel.fromJson(snapShot.data()).group;
  }

  Future<List<FbInboxGroupModel>> getGroupInboxList(
      List<String> idGroups) async {
    var list = <FbInboxGroupModel>[];
    // idGroups.forEach((id) async {
    //    final snapShot =
    //       await firestore.collection(groupCollection).doc(id).get();
    //   list.add(FbInboxGroupModel.fromJson(snapShot.data(), id));
    // });
    for (int i = 0; i < idGroups.length; i++) {
      final item =
          await firestore.collection(groupCollection).doc(idGroups[i]).get();
      list.add(FbInboxGroupModel.fromJson(item.data(), item.id));
    }
    return list;
  }

  Future<List<FbInboxGroupModel>> getList20Inbox(String idUser) async {
    final groups = await get20UserGroupInboxList(idUser);
    final inboxes = await getGroupInboxList(groups);
    return inboxes;
  }

  Future<String> getImage({id}) async {
    final snapShot = await firestore.collection(userCollection).doc(id).get();
    return snapShot.data()['image'];
  }

  Future<String> getName({id}) async {
    final snapShot = await firestore.collection(userCollection).doc(id).get();
    return snapShot.data()['name'];
  }

  Future<void> getDetails({id}) async {
    var doc = firestore.collection(userCollection).doc();
    var checkData = await doc.get();
    if (checkData == null) return;
    await SPref.instance.set('id', checkData.data()['id']);
    await SPref.instance.set('name', checkData.data()['name']);
    await SPref.instance.set('image', checkData.data()['image']);
  }
}
