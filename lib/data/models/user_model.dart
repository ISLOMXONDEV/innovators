class UserModel {
  String? uid;
  String? email;
  String? firstName;
  String? secondName;
  String? userMode;
  String? status;

  UserModel(
      {this.uid,
      this.email,
      this.firstName,
      this.secondName,
      this.userMode,
      this.status});

  factory UserModel.fromMap(map) {
    return UserModel(
        uid: map['uid'],
        email: map['email'],
        firstName: map['firstName'],
        secondName: map['secondName'],
        userMode: map['userMode'],
        status: map['status']);
  }
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'firstName': firstName,
      'secondName': secondName,
      'status': status,
      'userMode': userMode
    };
  }
}

class Post {
  String? author;
  String? content;
  String? category;
  String? time;

  Post({this.author, this.content, this.category, this.time});

  factory Post.fromMap(map) {
    return Post(
      author: map['author'],
      content: map['content'],
      category: map['category'],
      time: map['time'],
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'author': author,
      'content': content,
      'category': category,
      'time': time,
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
  String? tgAccount;
  String? about;
  String? specialization;

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
    this.tgAccount,
    this.about,
    this.specialization,
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
      tgAccount: map['tgAccount'],
      about: map['about'],
      specialization: map['specialization'],
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
      'tgAccount': tgAccount,
      'about': about,
      'specialization': specialization,
    };
  }
}
