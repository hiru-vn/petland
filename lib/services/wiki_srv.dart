import 'base_graphql.dart';

class TypeWikiSrv extends BaseService {
  TypeWikiSrv() : super(module: 'TypeOfWiki', fragment: ''' 
id: String
name: String
createdAt: DateTime
updatedAt: DateTime
  ''');
}

class WikiCategorySrv extends BaseService {
  WikiCategorySrv() : super(module: 'WikiCategory', fragment: ''' 
id
      typeOfwiki {
        id
      	name
      	createdAt
      	updatedAt
      }
      title
      image
      numberOfPost
      createdAt
      updatedAt
  ''');
}

class WikiPostSrv extends BaseService {
  WikiPostSrv() : super(module: 'PostCategory', fragment: ''' 
id
title
content
like
seen
share
link
wikiCategoryId
avatarWritter
nameWritter
image
createdAt
updatedAt
  ''');
}
