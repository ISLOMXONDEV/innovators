import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:innovators/data/models/user_model.dart';

class ScreenIndexProvider extends ChangeNotifier {
  UserModel? loggedInUser;
  int? screenIndex = 0;
  UserResumeCard? userResumeCard;
  bool hasResume = false;
  var status = 'open to work';

  // CollectionReference resumeGet = FirebaseFirestore.instance.collection('users').doc();

  FirebaseFirestore? firestore;

  initialise() {
    firestore = FirebaseFirestore.instance;
  }

  Future<void> resumeDefine(UserResumeCard? userResume) async {
    userResumeCard = userResume;
  }

  // void userResumeUpdate(UserResumeCard? userResumeCard) async {
  //   UserResumeCard? resume;
  //
  //   try {
  //     var responce = await firestore
  //         ?.collection('users')
  //         .doc(loggedInUser?.uid)
  //         .collection("resume")
  //         .doc(loggedInUser?.uid)
  //         .get()
  //         .then((value) {
  //       print(value);
  //       resume = UserResumeCard.fromMap(value.data());
  //
  //       if (resume?.positionName != "null") {
  //         userResumeCard = resume;
  //         notifyListeners();
  //       } else {
  //         userResumeCard = null;
  //         notifyListeners();
  //       }
  //     });
  //   } catch (e) {
  //     print(e);
  //   }
  // }
  // UserResumeCard? userResumeCard = UserResumeCard(
  //   positionName: "Flutter developer",
  //   skills:
  //       "Mobile dev ,Web Technologies,Data Structure,Algorithms,Java,Python",
  //   experience: "0-1 year",
  //   dateOfBirth: "23 years old",
  //   universityName: "Bangor UK",
  //   resumeLink: "blabla.ru",
  //   tellNumber: '+99897777777',
  //   email: "innovator@gmail.com",
  //   social: "instgrm: @innovator_youth",
  //   imageLink:
  //       "https://instagram.ftas3-1.fna.fbcdn.net/v/t51.2885-19/177219615_1728341124004802_3178671336629535217_n.jpg?stp=dst-jpg_s320x320&_nc_ht=instagram.ftas3-1.fna.fbcdn.net&_nc_cat=1&_nc_ohc=2I_NCNib37gAX--Pin0&edm=ABfd0MgBAAAA&ccb=7-4&oh=00_AT8qhONMJG0O6wguTxUrpRkX65P8fUHRqC-8Kc9dQqzUIA&oe=624933C7&_nc_sid=7bff83",
  // );

  Future<void> updateUser(UserModel? userModel) async {
    loggedInUser = userModel;
    notifyListeners();
  }

  void updateIndex(int? number) {
    screenIndex = number;
    notifyListeners();
  }
}
