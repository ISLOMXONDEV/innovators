import 'package:flutter/material.dart';
import 'package:innovators/data/models/user_model.dart';
import 'package:provider/provider.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../../data/provider_values.dart';

class AddPost extends StatefulWidget {
  const AddPost({Key? key}) : super(key: key);

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  final authorController = TextEditingController();
  final contentNameController = TextEditingController();
  String? category;

  @override
  Widget build(BuildContext context) {
    return Consumer<ScreenIndexProvider>(builder: (context, provider, child) {
      return SingleChildScrollView(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(28.0),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  "Create a post",
                  style: TextStyle(
                      color: Colors.blueAccent,
                      fontSize: 30,
                      fontFamily: 'Arial'),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: userInput(contentNameController, "What do you think? ",
                  keyboardType: TextInputType.name),
            ),
            ToggleSwitch(
              initialLabelIndex: 0,
              totalSwitches: 5,
              labels: const [
                '#Fun',
                '#Opinion',
                '#Study',
                "#Advice",
                "#Question",
              ],
              onToggle: (index) {
                switch (index) {
                  case 0:
                    category = "#Fun";
                    break;
                  case 1:
                    category = "#Opinion";
                    break;
                  case 2:
                    category = "#Study";
                    break;
                  case 3:
                    category = "#Advice";
                    break;
                  default:
                    category = "#Question";
                }
              },
            ),
            ElevatedButton(
              onPressed: () {
                post(provider.loggedInUser);
              },
              child: const Text("Submit"),
            ),
          ],
        ),
      );
    });
  }

  void post(UserModel? user) async {
    Post post = Post();
    post.author = "${user?.firstName} ${user?.secondName}";
    post.content = contentNameController.text;
    post.category = category;
    post.time = DateTime.now().toString();

    await Provider.of<ScreenIndexProvider>(context, listen: false)
        .addPost(post);
    authorController.clear();
    contentNameController.clear();
  }

  Widget userInput(
    TextEditingController userInput,
    String hintTitle, {
    TextInputType? keyboardType,
    var widthSize,
  }) {
    return Container(
      width: widthSize ?? MediaQuery.of(context).size.width - 30,
      decoration: BoxDecoration(
          color: Colors.blue[100], borderRadius: BorderRadius.circular(40)),
      child: Padding(
        padding: const EdgeInsets.only(
          left: 25.0,
          right: 25,
          top: 10,
        ),
        child: TextFormField(
          validator: (value) {
            if (value!.isEmpty) {
              return ("Please enter your $hintTitle");
            }
          },
          controller: userInput,
          decoration: InputDecoration(
            hintText: hintTitle,
            hintStyle: const TextStyle(
              fontSize: 18,
              color: Colors.black,
              fontStyle: FontStyle.italic,
            ),
          ),
          keyboardType: keyboardType,
        ),
      ),
    );
  }
}
