import 'package:petland/share/import.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class InboxBloc extends ChangeNotifier {
  InboxBloc._privateConstructor();
  static final InboxBloc instance = InboxBloc._privateConstructor();

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  DocumentReference getGroup(String id) {
    return firestore.collection('Groups').doc(id);
  }

  final userCollection = 'user';

  Future<void> createUser(id, name, image) async {
    final snapShot = await firestore.collection(userCollection).doc(id).get();
    if (snapShot.exists) {
      await firestore
          .collection(userCollection)
          .doc(id)
          .update({'name': name, 'id': id, 'image': image});
    } else {
      await firestore
          .collection(userCollection)
          .doc(id)
          .set({'name': name, 'id': id, 'image': image, 'group': []});
    }
    return;
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
