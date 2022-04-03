import 'package:innovators/data/models/user_model.dart';

class ProjectsModel {
  String? projectsName;
  String? foundData;
  String? avatarImage;
  List<UserModel?>? employers;
  String? segment;
  List<Vacancy?>? availableVacancies;
  String? details;
  List<String?>? emailsOfStaff;
  String? phoneNumber;
  String? address;
  List<String?>? imageLinks;
}

class Vacancy {
  String? status;
  String? vacancyName;
  String? contactNumber;
  String? contactEmail;
  String? requirements;
  String? paymentInfo;
  String? details;
}
