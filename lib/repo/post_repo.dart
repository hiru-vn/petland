import 'package:petland/model/post.dart';
import 'package:petland/services/post_srv.dart';

class PostRepo {
  Future getAll({String userId}) async {
    final res = await PostSrv().getList(filter: '{userId: "$userId"}');
    return res;
  }

  Future update({PostModel pet}) async {
    
  }

  Future create({PostModel pet}) async {
    
  }

  Future delete({String petId}) async {
    final res = await PostSrv().delete(petId);
    return res;
  }
}