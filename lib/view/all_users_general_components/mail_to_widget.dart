//
//
//
// import 'package:flutter/material.dart';
// class MailTo extends StatelessWidget {
//   const MailTo({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return  Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: IconButton(
//         onPressed: () {
//           String? encodeQueryParameters(
//               Map<String, String> params) {
//             return params.entries
//                 .map((e) =>
//             '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
//                 .join('&');
//           }
//
//           final Uri emailLaunchUri = Uri(
//             scheme: 'mailto',
//             path: '${provider.project?.emailsOfStaff}',
//             query: encodeQueryParameters(<String, String>{
//               'subject':
//               'I am typing you with interest to join your team '
//             }),
//           );
//
//           launch(emailLaunchUri.toString());
//         },
//         icon: const Icon(
//           Icons.attach_email_outlined,
//           color: Colors.blueAccent,
//         ),
//       ),
//     ),;
//   }
// }
