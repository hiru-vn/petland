import 'package:petland/model/post.dart';
import 'package:petland/services/post_srv.dart';

class PostRepo {
  Future getList({String userId}) async {
    final res = await PostSrv().getList(limit: 10);
    return res;
  }

  Future update({PostModel post}) async {
    
  }

  Future create({PostModel post}) async {
    
  }

  Future delete({String postId}) async {
    final res = await PostSrv().delete(postId);
    return res;
  }
}