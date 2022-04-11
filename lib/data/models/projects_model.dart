import 'package:innovators/data/models/user_model.dart';

class ProjectsModel {
  String? projectsName;
  String? foundData;
  String? avatarImage;
  String? founder;
  String? segment;
  // List<Vacancy?>? availableVacancies;
  String? details;
  String? emailsOfStaff;
  String? phoneNumber;
  String? address;
  String? tgAccount;

  ProjectsModel({
    this.projectsName,
    this.foundData,
    this.avatarImage,
    this.founder,
    this.segment,
    // this.availableVacancies,
    this.details,
    this.emailsOfStaff,
    this.phoneNumber,
    this.address,
    this.tgAccount,
  });

  factory ProjectsModel.fromMap(map) {
    return ProjectsModel(
      projectsName: map['projectsName'],
      foundData: map['foundData'],
      avatarImage: map['avatarImage'],
      founder: map['founder'],
      segment: map['segment'],
      // availableVacancies: map['availableVacancies'],
      details: map['details'],
      emailsOfStaff: map['emailsOfStaff'],
      phoneNumber: map['phoneNumber'],
      address: map['address'],
      tgAccount: map['tgAccount'],
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'projectsName': projectsName,
      'foundData': foundData,
      'avatarImage': avatarImage,
      'founder': founder,
      'segment': segment,
      'details': details,
      'emailsOfStaff': emailsOfStaff,
      'phoneNumber': phoneNumber,
      'address': address,
      'tgAccount': tgAccount,
    };
  }
}

class Vacancy {
  String? status;
  String? positionName;
  String? companyName;
  String? contactNumber;
  String? contactEmail;
  String? telegramChatLink;
  String? requirements;
  String? paymentInfo;
  String? details;
  String? type;
  String? uidCompany;
  String? location;

  Vacancy({
    this.status,
    this.positionName,
    this.contactNumber,
    this.contactEmail,
    this.companyName,
    this.telegramChatLink,
    this.requirements,
    this.paymentInfo,
    this.details,
    this.type,
    this.uidCompany,
    this.location,
  });

  factory Vacancy.fromMap(map) {
    return Vacancy(
        status: map['status'],
        positionName: map['positionName'],
        contactNumber: map['contactNumber'],
        companyName: map['companyName'],
        contactEmail: map['contactEmail'],
        telegramChatLink: map['telegramChatLink'],
        requirements: map['requirements'],
        paymentInfo: map['paymentInfo'],
        details: map['details'],
        type: map['type'],
        uidCompany: map['uidCompany'],
        location: map['location']);
  }
  Map<String, dynamic> toMap() {
    return {
      'status': status,
      'positionName': positionName,
      'contactNumber': contactNumber,
      'contactEmail': contactEmail,
      'companyName': companyName,
      'telegramChatLink': telegramChatLink,
      'requirements': requirements,
      'paymentInfo': paymentInfo,
      'details': details,
      'type': type,
      'uidCompany': uidCompany,
      'location': location,
    };
  }
}
