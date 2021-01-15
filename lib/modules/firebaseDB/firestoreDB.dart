import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

class FireStoreClass {
  static final FirebaseFirestore _db = FirebaseFirestore.instance;
  static final userCollection = 'user';

  static void createUser({id, name, image}) async {
    final snapShot = await _db.collection(userCollection).doc(name).get();
    if (snapShot.exists) {
      await _db.collection(userCollection).doc(id).update(
          {'name': name, 'id': id, 'image': image});
    } else {
      await _db
          .collection(userCollection)
          .doc(name)
          .set({'name': name, 'channel': id, 'image': image});
    }
  }

  static Future<String> getImage({id}) async {
    final snapShot =
        await _db.collection(userCollection).doc(id).get();
    return snapShot.data()['image'];
  }

  static Future<String> getName({id}) async {
    final snapShot =
        await _db.collection(userCollection).doc(id).get();
    return snapShot.data()['name'];
  }

  static Future<void> getDetails({id}) async {
    var doc = _db.collection(userCollection).doc();
    var checkData = await doc.get();
    if (checkData == null) return;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('id', checkData.data()['id']);
    await prefs.setString('name', checkData.data()['name']);
    await prefs.setString('image', checkData.data()['image']);
  }
}
