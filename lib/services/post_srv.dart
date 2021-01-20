import 'base_graphql.dart';

class PostSrv extends BaseService {
  PostSrv() : super(module: 'Post', fragment: ''' 
id
content
images
videos
commentIds
like
makePublic
tags
petTags
share
user {
id
uid
name
email
phone
avatar
description
nickName
backgroundimage
follows
}
userId
createdAt
updatedAt
  ''');
}
