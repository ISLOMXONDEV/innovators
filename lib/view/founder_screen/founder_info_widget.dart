import 'package:flutter/material.dart';
import 'package:innovators/data/provider_values.dart';
import 'package:provider/provider.dart';

class FounderInfoWidget extends StatefulWidget {
  const FounderInfoWidget({Key? key}) : super(key: key);

  @override
  State<FounderInfoWidget> createState() => _FounderInfoWidgetState();
}

class _FounderInfoWidgetState extends State<FounderInfoWidget> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ScreenIndexProvider>(builder: (context, provider, child) {
      return Container();
      //     Scaffold(
      //   body: Stack(
      //     children: [
      //       Positioned.fill(
      //         child: Column(
      //           children: [
      //             Expanded(
      //               child: Container(
      //                 color: Colors.blueGrey[200],
      //                 // : Colors.orangeAccent[200],
      //                 child: Align(
      //                   alignment: Alignment.center,
      //                     child: Image.asset(provider.,
      //                   ),
      //                 ),
      //               ),
      //             ),
      //             Expanded(
      //               child: Container(
      //                 color: Colors.white,
      //                 child: Container(
      //                   margin: const EdgeInsets.fromLTRB(10, 80, 10, 120),
      //                   child: Column(
      //                     mainAxisAlignment: MainAxisAlignment.start,
      //                     crossAxisAlignment: CrossAxisAlignment.start,
      //                     children: [
      //                       Row(
      //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                         crossAxisAlignment: CrossAxisAlignment.center,
      //                         children: [
      //                           Expanded(
      //                             child: ListTile(
      //                               leading: const CircleAvatar(
      //                                 backgroundImage: NetworkImage(),
      //                               ),
      //                               title: Text(
      //                                 'Maya Berkovskaya',
      //                                 style: TextStyle(
      //                                     fontWeight: FontWeight.bold,
      //                                     color: Colors.grey[700]),
      //                               ),
      //                               subtitle: Text(
      //                                 'Owner',
      //                                 style: TextStyle(
      //                                     fontWeight: FontWeight.bold,
      //                                     color: Colors.grey[400]),
      //                               ),
      //                             ),
      //                           ),
      //                           Text(
      //                             'May 25, 2019',
      //                             style: TextStyle(
      //                                 fontWeight: FontWeight.bold,
      //                                 color: Colors.grey[400]),
      //                           ),
      //                         ],
      //                       ),
      //                       Padding(
      //                         padding: const EdgeInsets.all(10.0),
      //                         child: Text(
      //                           details,
      //                           textAlign: TextAlign.justify,
      //                           style: TextStyle(
      //                             fontWeight: FontWeight.bold,
      //                             color: Colors.grey[500],
      //                             letterSpacing: 0.7,
      //                           ),
      //                         ),
      //                       )
      //                     ],
      //                   ),
      //                 ),
      //               ),
      //             )
      //           ],
      //         ),
      //       ),
      //       Container(
      //         margin: const EdgeInsets.only(top: 30),
      //         child: Align(
      //           alignment: Alignment.topCenter,
      //           child: Row(
      //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //             children: [
      //               IconButton(
      //                 onPressed: () {
      //                   Navigator.pop(context);
      //                 },
      //                 icon: const Icon(
      //                   Icons.arrow_back_ios_rounded,
      //                   color: Colors.white,
      //                 ),
      //               ),
      //               IconButton(
      //                 onPressed: () {
      //                   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      //                     content: Text("Sharing Pet File"),
      //                   ));
      //                 },
      //                 icon: const Icon(
      //                   Icons.ios_share,
      //                   color: Colors.white,
      //                 ),
      //               ),
      //             ],
      //           ),
      //         ),
      //       ),
      //       Align(
      //         alignment: Alignment.center,
      //         child: Container(
      //           height: 140,
      //           margin: const EdgeInsets.symmetric(horizontal: 20),
      //           decoration: BoxDecoration(
      //             boxShadow: shadowList,
      //             borderRadius: BorderRadius.circular(20),
      //             color: Colors.white,
      //           ),
      //           child: Padding(
      //             padding: const EdgeInsets.all(20.0),
      //             child: Column(
      //               mainAxisAlignment: MainAxisAlignment.spaceAround,
      //               children: [
      //                 Row(
      //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                   children: [
      //                     Text(
      //                       widget.catDetailsMap['name'],
      //                       style: TextStyle(
      //                         fontWeight: FontWeight.bold,
      //                         fontSize: 21.0,
      //                         color: Colors.grey[600],
      //                       ),
      //                     ),
      //                     (widget.catDetailsMap['sex'] == 'male')
      //                         ? Icon(
      //                             Icons.male_rounded,
      //                             color: Colors.grey[500],
      //                             size: 30,
      //                           )
      //                         : Icon(
      //                             Icons.female_rounded,
      //                             color: Colors.grey[500],
      //                             size: 30,
      //                           ),
      //                   ],
      //                 ),
      //                 Row(
      //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                   children: [
      //                     Text(
      //                       widget.catDetailsMap['Species'],
      //                       style: TextStyle(
      //                         fontWeight: FontWeight.bold,
      //                         color: Colors.grey[500],
      //                         letterSpacing: 0.7,
      //                       ),
      //                     ),
      //                     Text(
      //                       widget.catDetailsMap['year'] + ' years old',
      //                       style: TextStyle(
      //                         fontWeight: FontWeight.bold,
      //                         color: Colors.grey[500],
      //                         letterSpacing: 0.7,
      //                       ),
      //                     ),
      //                   ],
      //                 ),
      //                 const SizedBox(height: 2),
      //                 Row(
      //                   mainAxisAlignment: MainAxisAlignment.start,
      //                   crossAxisAlignment: CrossAxisAlignment.center,
      //                   children: [
      //                     Icon(
      //                       Icons.location_on,
      //                       color: primaryColor,
      //                       size: 18,
      //                     ),
      //                     const SizedBox(
      //                       width: 3,
      //                     ),
      //                     Text(
      //                       widget.catDetailsMap['location'],
      //                       style: TextStyle(
      //                         fontWeight: FontWeight.bold,
      //                         color: Colors.grey[400],
      //                         letterSpacing: 0.8,
      //                       ),
      //                     ),
      //                   ],
      //                 ),
      //               ],
      //             ),
      //           ),
      //         ),
      //       ),
      //       Align(
      //         alignment: Alignment.bottomCenter,
      //         child: Container(
      //           height: 120,
      //           decoration: BoxDecoration(
      //             color: Colors.grey[200],
      //             borderRadius: const BorderRadius.only(
      //                 topLeft: Radius.circular(20),
      //                 topRight: const Radius.circular(20)),
      //           ),
      //           child: Padding(
      //             padding: const EdgeInsets.symmetric(horizontal: 25),
      //             child: Row(
      //               children: [
      //                 GestureDetector(
      //                   onTap: () {
      //                     setState(() {
      //                       if (isFavorite) {
      //                         isFavorite = false;
      //                       } else {
      //                         isFavorite = true;
      //                       }
      //                     });
      //                   },
      //                   child: Container(
      //                     height: 50,
      //                     width: 50,
      //                     child: isFavorite
      //                         ? const Icon(
      //                             Icons.favorite_rounded,
      //                             color: Colors.redAccent,
      //                           )
      //                         : const Icon(
      //                             Icons.favorite_border_rounded,
      //                             color: Colors.white,
      //                           ),
      //                     decoration: BoxDecoration(
      //                       color: primaryColor,
      //                       borderRadius: BorderRadius.circular(10),
      //                       boxShadow: shadowList,
      //                     ),
      //                   ),
      //                 ),
      //                 const SizedBox(
      //                   width: 30,
      //                 ),
      //                 Expanded(
      //                   child: Container(
      //                     height: 50,
      //                     width: 50,
      //                     child: const Center(
      //                       child: const Text(
      //                         'Adoption',
      //                         style: TextStyle(
      //                           fontSize: 18,
      //                           fontWeight: FontWeight.bold,
      //                           color: Colors.white,
      //                         ),
      //                       ),
      //                     ),
      //                     decoration: BoxDecoration(
      //                       color: primaryColor,
      //                       borderRadius: BorderRadius.circular(10),
      //                       boxShadow: shadowList,
      //                     ),
      //                   ),
      //                 )
      //               ],
      //             ),
      //           ),
      //         ),
      //       ),
      //     ],
      //   ),
      // );
    });
  }
}
