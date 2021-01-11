import 'package:petland/share/import.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class InboxBloc extends ChangeNotifier {
  InboxBloc._privateConstructor();
  static final InboxBloc instance = InboxBloc._privateConstructor();

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  DocumentReference getGroup(String id){
    return firestore.collection('Groups').doc(id);
  }

  
}
