import 'package:petland/model/post.dart';
import 'package:petland/services/comment_srv.dart';
import 'package:petland/services/graphql_helper.dart';
import 'package:petland/services/post_srv.dart';

class PostRepo {
  Future getList() async {
    final res = await PostSrv().getList(limit: 10, order: '{createdAt: -1}');
    return res;
  }

  Future update({PostModel post}) async {}

  Future create({PostModel post}) async {
    final res = await PostSrv().add('''
    content : "${post.content}"
    images : ${GraphqlHelper.listStringToGraphqlString(post.images)}
    videos: ${GraphqlHelper.listStringToGraphqlString(post.videos)}
    commentId: []
    like: 0
    share: 0
    tags: ${GraphqlHelper.listStringToGraphqlString(post.tags)}
  	makePublic: ${post.makePublic}
    petTags: ${GraphqlHelper.listStringToGraphqlString(post.petTags)}
    ''');
    return res;
  }

  Future increaseLikePost({String postId}) async {
    final res = await PostSrv().mutate(
      'increaseLikePost',
      'postId: "$postId"',
      fragment: 'id'
    );
    return res;
  }

  Future decreaseLikePost({String postId}) async {
    final res = await PostSrv().mutate(
      'decreaseLikePost',
      'postId: "$postId"',
      fragment: 'id'
    );
    return res;
  }

  Future getAllComment({String postId}) async {
    final res = await CommentSrv().getList(limit: 20);
    return res;
  }

  Future deletePost({String postId}) async {
    final res = await PostSrv().delete(postId);
    return res;
  }
}
