import 'base_graphql.dart';

class PetSrv extends BaseService {
  PetSrv() : super(module: 'Pet', fragment: '''
id: String
name: String
raceId: ID
birthday: DateTime
gender: String
character: [String]
userId: ID
avatar: String
coverImage: String
race {
  id
  image
  name
  type
}
images
videos
createdAt: DateTime
updatedAt: DateTime
''');
}

class RaceSrv extends BaseService {
  RaceSrv() : super(module: 'Race', fragment: '''
id: String
name: String
image: String
type: String
createdAt: DateTime
updatedAt: DateTime
''');
}
