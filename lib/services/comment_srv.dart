
import 'base_graphql.dart';

class CommentSrv extends BaseService {
  CommentSrv()  : super(module: 'Comment', fragment: ''' 
id: String
content: String
userId: ID
postId: ID
like: Int
user {
id: String
uid: String
name: String
avatar: String
}
createdAt: DateTime
updatedAt: DateTime
  ''');
}