import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'inbox_model.dart';

class InboxBloc extends ChangeNotifier {
  InboxBloc._privateConstructor();
  static final InboxBloc instance = InboxBloc._privateConstructor();

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  DocumentReference getGroup(String id) {
    return firestore.collection('group').doc(id);
  }

  final userCollection = 'user';
  final groupCollection = 'group';
  final messageCollection = 'messages';

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

  Future<List<FbInboxUserModel>> getUsers(List<String> users) async {
    final List<DocumentSnapshot> snapShots = await Future.wait(
        users.map((e) => firestore.collection(userCollection).doc(e).get()));
    final listUser =
        snapShots.map((e) => FbInboxUserModel.fromJson(e.data())).toList();
    return listUser;
  }

  Future<void> addMessage(String groupId, String text, DateTime time,
      String uid, String fullName, String avatar,
      {String filePath}) {
    print('upload: ' + filePath.toString());
    return getGroup(groupId).collection(messageCollection).add({
      'text': text,
      'date': time.toIso8601String(),
      'uid': uid,
      'fullName': fullName,
      'avatar': avatar,
      'filePath':
          filePath == null ? null : (filePath.isNotEmpty ? filePath : null)
    });
  }

  Future<Stream<QuerySnapshot>> getStreamIncomingMessages(
      String groupId, String latestFetchedMessageId) async {
    final latestFetchedMessageDoc = await getGroup(groupId)
        .collection(messageCollection)
        .doc(latestFetchedMessageId)
        .get();
    return getGroup(groupId)
        .collection(messageCollection)
        .orderBy('date', descending: false)
        .startAfterDocument(latestFetchedMessageDoc)
        .snapshots();
  }

  Future<List<FbInboxMessageModel>> get20Messages(String groupId,
      {String lastMessageId}) async {
    List<FbInboxMessageModel> res;
    if (lastMessageId == null) {
      final query = getGroup(groupId)
          .collection(messageCollection)
          .orderBy('date', descending: false)
          .limitToLast(20);
      final snapshot = await query.get();
      res = snapshot.docs
          .map((e) => FbInboxMessageModel.fromJson(e.data(), e.id))
          .toList();
    } else {
      final lastMessageDoc = await getGroup(groupId)
          .collection(messageCollection)
          .doc(lastMessageId)
          .get();
      final query = getGroup(groupId)
          .collection(messageCollection)
          .orderBy('date', descending: false)
          .endBeforeDocument(lastMessageDoc)
          .limitToLast(20);
      final snapshot = await query.get();
      res = snapshot.docs
          .map((e) => FbInboxMessageModel.fromJson(e.data(), e.id))
          .toList();
    }
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
      await firestore.collection(userCollection).doc(id).set({
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
    list.sort((a, b) =>
        DateTime.tryParse(b.time).compareTo(DateTime.tryParse(a.time)));
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
}
