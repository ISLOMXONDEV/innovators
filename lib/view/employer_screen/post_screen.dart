import 'package:flutter/material.dart';
import 'package:innovators/data/provider_values.dart';
import 'package:provider/provider.dart';

class PostsScreen extends StatefulWidget {
  const PostsScreen({Key? key}) : super(key: key);

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ScreenIndexProvider>(
      builder: (context, provider, child) {
        return RefreshIndicator(
          onRefresh: () => provider.readPosts(),
          child: provider.hasPosts == true
              ? Padding(
                  padding: const EdgeInsets.only(top: 18.0),
                  child: ListView.builder(
                    itemCount: provider.posts.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.only(
                            left: 10.0, right: 10, top: 4),
                        child: Container(
                          height: 250,
                          child: Card(
                            color: Colors.white,
                            child: ListTile(
                              minLeadingWidth: 30,
                              title: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            color: Colors.amber,
                                          ),
                                          width: 80,
                                          height: 40,
                                          child: Center(
                                            child: Text(
                                              '${provider.posts[index].category}',
                                              style: const TextStyle(
                                                  color: Colors.black),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Text(
                                      '${provider.posts[index].content}',
                                      style: const TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                              ),
                              trailing: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                      width: 120,
                                      height: 26,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.green,
                                      ),
                                      child: Center(
                                        child: Text(
                                          provider.posts[index].time.toString(),
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 12),
                                        ),
                                      )),
                                  Container(
                                      width: 120,
                                      height: 25,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.grey[300]),
                                      child: Center(
                                        child: Text(
                                          provider.posts[index].author
                                              .toString(),
                                          style: const TextStyle(
                                              fontSize: 12,
                                              color: Colors.black),
                                        ),
                                      )),
                                ],
                              ),
                            ),
                          ),
                          decoration: BoxDecoration(boxShadow: [
                            BoxShadow(
                                blurRadius: 20,
                                offset: const Offset(0, 12),
                                color: Colors.black.withOpacity(.6),
                                spreadRadius: -9)
                          ]),
                        ),
                      );
                    },
                  ),
                )
              : Center(
                  child: OutlinedButton(
                    onPressed: () => provider.readPosts(),
                    child: const Text('Refresh'),
                  ),
                ),
        );
      },
    );
  }
}
