import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:innovators/data/models/projects_model.dart';
import 'package:innovators/data/models/service.dart';
import 'package:innovators/data/models/user_model.dart';

class ScreenIndexProvider extends ChangeNotifier {
  UserModel? loggedInUser;
  int? screenIndex = 0;
  int? selectedIndex = 0;
  UserResumeCard? userResumeCard;
  bool hasResume = false;
  bool hasProject = false;
  bool hasListOfVacancies = false;
  bool hasListOfService = false;
  bool hasListOfJobSeeker = false;
  bool hasPosts = false;
  bool hasMyService = false;
  var status = 'open for work';
  List<UserModel?>? projectsEmployee = [];

  ProjectsModel? project = ProjectsModel();
  List<Vacancy> docs = [];
  List<UserResumeCard> jobSeekers = [];
  List<Post> posts = [];

  List<Service> services = [];
  List<Service> myServices = [];

  // CollectionReference resumeGet = FirebaseFirestore.instance.collection('users').doc();

  FirebaseFirestore? firestore;

  initialise() {
    firestore = FirebaseFirestore.instance;
    // if (loggedInUser?.userMode == "employee") {
    //readVacancy();
    // }

    // projectsEmployee?.add(loggedInUser);
    // vacancies?.add(
    //   Vacancy(
    //     status: "is active",
    //     vacancyName: "Marketolog",
    //     contactEmail: "m@m.ru",
    //     contactNumber: "9989760606",
    //     requirements: "SWOT,Bloc, Project Managements",
    //     paymentInfo: "200\$ a month",
    //     details: "we have project we do it",
    //     type: "offline",
    //   ),
    // );
  }

  void updateScreen(int? value) {
    selectedIndex = value;
    notifyListeners();
  }

  void resumeDefine(UserResumeCard? userResume) {
    userResumeCard = userResume;
    notifyListeners();
  }

  void projectDefine(ProjectsModel? projectsModel) {
    project = projectsModel;
    print(project?.founder);
    notifyListeners();
  }

  void updateStatus(String? status) {
    if (status == "on") {
      addActiveSearchForJob(userResumeCard);
      notifyListeners();
    } else {
      disableSearchForJob();
      notifyListeners();
    }
  }

  Future<List<Vacancy>> readVacancy() async {
    QuerySnapshot querySnapshot;
    List<Vacancy> docss = [];
    try {
      querySnapshot =
          await FirebaseFirestore.instance.collection('vacancies').get();
      if (querySnapshot.docs.isNotEmpty) {
        for (var doc in querySnapshot.docs.toList()) {
          Vacancy a = Vacancy.fromMap(doc.data());
          print(a.positionName);
          docss.add(a);
        }

        hasListOfVacancies = true;
        notifyListeners();
        docs = docss;
        return docss;
      } else {
        return docss;
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "$e");
      throw ('$e');
    }
  }

  Future<List<Post>> readPosts() async {
    QuerySnapshot querySnapshot;
    List<Post> postss = [];
    try {
      querySnapshot =
          await FirebaseFirestore.instance.collection('posts').get();
      if (querySnapshot.docs.isNotEmpty) {
        for (var doc in querySnapshot.docs.toList()) {
          Post a = Post.fromMap(doc.data());
          postss.add(a);
          print(a.author);
        }

        hasPosts = true;
        notifyListeners();
        posts = postss;
        return posts;
      } else {
        return posts;
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "$e");
      throw ('$e');
    }
  }

  Future<List<Service>> readServices() async {
    QuerySnapshot querySnapshot;
    List<Service> servicess = [];
    myServices.clear();
    try {
      querySnapshot =
          await FirebaseFirestore.instance.collection('services').get();
      if (querySnapshot.docs.isNotEmpty) {
        for (var doc in querySnapshot.docs.toList()) {
          Service a = Service.fromMap(doc.data());
          if (a.serviceProviderID == loggedInUser?.uid) {
            myServices.add(a);
          }
          servicess.add(a);
          print(a.serviceName);
        }

        hasListOfService = true;
        services = servicess;
        notifyListeners();

        return services;
      } else {
        return services;
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "$e");
      throw ('$e');
    }
  }

  Future<List<UserResumeCard>> readJobSeekers() async {
    QuerySnapshot querySnapshot;
    List<UserResumeCard> jobSeekerss = [];
    try {
      querySnapshot =
          await FirebaseFirestore.instance.collection('jobSeekers').get();
      if (querySnapshot.docs.isNotEmpty) {
        for (var doc in querySnapshot.docs.toList()) {
          UserResumeCard a = UserResumeCard.fromMap(doc.data());
          jobSeekerss.add(a);
        }

        hasListOfService = true;
        jobSeekers = jobSeekerss;
        notifyListeners();

        return jobSeekers;
      } else {
        return jobSeekers;
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "$e");
      throw ('$e');
    }
  }

  Future<void> readProject() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(loggedInUser!.uid)
        .collection("project")
        .doc(loggedInUser!.uid)
        .get()
        .then((value) {
      print(value.data());

      var projectInitial = ProjectsModel.fromMap(value.data());
      var projectName = projectInitial.projectsName;
      if (projectName != null) {
        projectDefine(projectInitial);
        hasProject = true;
        notifyListeners();
      }
    });
  }

  Future<void> readUser() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(loggedInUser!.uid)
        .collection("resume")
        .doc(loggedInUser!.uid)
        .get()
        .then((value) {
      print(value.data());

      var resumeInitial = UserResumeCard.fromMap(value.data());
      var resumeName = resumeInitial.positionName;
      if (resumeName != null) {
        resumeDefine(resumeInitial);
        hasResume = true;
        notifyListeners();
      }
    });
  }

  Future<void> addActiveSearchForJob(UserResumeCard? userResumeCard) async {
    await FirebaseFirestore.instance
        .collection('jobSeekers')
        .doc(loggedInUser!.uid)
        .set(userResumeCard!.toMap())
        .then((value) {
      Fluttertoast.showToast(msg: "Account edited successfully");
    }).catchError((e) {
      Fluttertoast.showToast(msg: e.message);
    });
  }

  Future<void> postVacancy(Vacancy? vacancy) async {
    await FirebaseFirestore.instance
        .collection('vacancies')
        .doc()
        .set(vacancy!.toMap())
        .then((value) {
      Fluttertoast.showToast(msg: "Vacancy added successfully");
    }).catchError((e) {
      Fluttertoast.showToast(msg: e.message);
    });
  }

  Future<void> addPost(Post? post) async {
    await FirebaseFirestore.instance
        .collection('posts')
        .doc()
        .set(post!.toMap())
        .then((value) {
      Fluttertoast.showToast(msg: "Post added successfully");
    }).catchError((e) {
      Fluttertoast.showToast(msg: e.message);
    });
  }

  Future<void> disableSearchForJob() async {
    await FirebaseFirestore.instance
        .collection('jobSeekers')
        .doc(loggedInUser!.uid)
        .delete()
        .then((value) {
      Fluttertoast.showToast(msg: "Account Deleted from search successfully");
    }).catchError((e) {
      Fluttertoast.showToast(msg: e.message);
    });
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
