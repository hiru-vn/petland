import 'base_graphql.dart';

class VaccineSrv extends BaseService {
  VaccineSrv() : super(module: 'Vaccine', fragment: ''' 
vaccineTypeId: String
vaccineType {
  id: String
name: String
raceType: String
createdAt: DateTime
updatedAt: DateTime
}
petId: String
images: [String]
videos: [String]
date: DateTime
publicity: Boolean
remider: Boolean
content: String
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
raceType: String
createdAt: DateTime
updatedAt: DateTime
  ''');
}
