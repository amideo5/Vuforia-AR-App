// ignore_for_file: file_names

import 'package:flutter/material.dart';

// ignore: use_key_in_widget_constructors
class NaviLoginProf extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/login');
      },
      child: Container(
        margin: const EdgeInsets.only(top: 42.0),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 15.0),
                    child: SizedBox(
                      width: 80,
                      child: Image.asset('assets/logo.png'),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(right: 25.0),
                    child: Text(
                      "AMIDEO AR WORLD",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 255, 255, 255),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}



















// import 'package:flutter/material.dart';

// class NaviLoginProf extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         Navigator.pushNamed(context, '/login');
//       },
//       child: Container(
//         margin: EdgeInsets.only(top: 11.0),
//         child: Center(
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Container(
//                 // Padding:
//                 padding: const EdgeInsets.only(
//                     right: 2.0), // Adjust right padding as needed
//                 child: Container(
//                   width: 80,
//                   child: Image.asset(
//                       'assets/Logo.png'), // Replace with your image path
//                 ),
//               ),
//               Container(
//                 // Padding(
//                 padding: const EdgeInsets.only(
//                     right: 2.0), // Adjust right padding as needed
//                 child: Text(
//                   "AR MEDIA HUB",
//                   style: TextStyle(
//                     fontSize: 20,
//                     fontWeight: FontWeight.bold,
//                     color: Color.fromARGB(255, 255, 255, 255),
//                   ),
//                 ),
//                 // ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
