// import 'package:flutter/material.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('RichText with onTap Example'),
//         ),
//         body: Center(
//           child: RichText(
//             text: TextSpan(
//               style: TextStyle(
//                 fontSize: 20.0,
//                 color: Colors.black,
//               ),
//               children: <TextSpan>[
//                 TextSpan(
//                   text: 'Hello ',
//                   style: TextStyle(fontWeight: FontWeight.bold),
//                 ),
//                 TextSpan(
//                   text: 'Flutter!',
//                   style: TextStyle(fontStyle: FontStyle.italic),
//                   recognizer: TapGestureRecognizer()
//                     ..onTap = () {
//                       // This function will be called when the 'Flutter!' text is tapped.
//                       print('Flutter! tapped!');
//                     },
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
