class UserModel {
  String? uid;
  String? email;
  String? firstName;
  String? secondName;
  String? userMode;

  UserModel(
      {this.uid, this.email, this.firstName, this.secondName, this.userMode});

  factory UserModel.fromMap(map) {
    return UserModel(
        uid: map['uid'],
        email: map['email'],
        firstName: map['firstName'],
        secondName: map['secondName'],
        userMode: map['userMode']);
  }
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'firstName': firstName,
      'secondName': secondName,
      'userMode': userMode
    };
  }
}

class UserResumeCard {
  String? positionName;
  String? dateOfBirth;
  String? universityName;
  String? skills;
  String? experience;
  String? imageLink;
  String? resumeLink;
  String? tellNumber;
  String? email;
  String? social;

  UserResumeCard({
    this.positionName,
    this.tellNumber,
    this.email,
    this.social,
    this.skills,
    this.experience,
    this.imageLink,
    this.dateOfBirth,
    this.resumeLink,
    this.universityName,
  });

  factory UserResumeCard.fromMap(map) {
    return UserResumeCard(
      positionName: map['positionName'],
      skills: map['skills'],
      tellNumber: map['tellNumber'],
      email: map['email'],
      social: map['social'],
      experience: map['experience'],
      imageLink: map['imageLink'],
      dateOfBirth: map['dateOfBirth'],
      resumeLink: map['resumeLink'],
      universityName: map['universityName'],
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'positionName': positionName,
      'skills': skills,
      'experience': experience,
      'tellNumber': tellNumber,
      'email': email,
      'social': social,
      'imageLink': imageLink,
      'dateOfBirth': dateOfBirth,
      'resumeLink': resumeLink,
      'universityName': universityName,
    };
  }
}
