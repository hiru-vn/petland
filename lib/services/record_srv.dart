import 'base_graphql.dart';

class VaccineSrv extends BaseService {
  VaccineSrv() : super(module: 'Vaccine', fragment: ''' 
id: String
petId: String
type: String
raceId: String
images: [String]
videos: [String]
date: DateTime
publicity: Boolean
remider: Boolean
pet {
  id
}
race {
  id
}
createdAt: DateTime
updatedAt: DateTime
  ''');
}


class BirthdaySrv extends BaseService {
  BirthdaySrv() : super(module: 'Birthday', fragment: ''' 
id: String
petId: String
images: [String]
videos: [String]
date: DateTime
publicity: Boolean
pet {
  id
}
createdAt: DateTime
updatedAt: DateTime
  ''');
}

class VaccineTypeSrv extends BaseService {
  VaccineTypeSrv() : super(module: 'VaccineType', fragment: ''' 
id: String
name: String
raceId: String
race: Race
createdAt: DateTime
updatedAt: DateTime
  ''');
}