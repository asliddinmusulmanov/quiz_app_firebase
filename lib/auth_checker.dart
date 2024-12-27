// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:quiz_app/core/routes/approutesname.dart';
//
// class AuthChecker extends StatelessWidget {
//   const AuthChecker({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<User?>(
//       stream: FirebaseAuth.instance.authStateChanges(),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const Scaffold(
//             backgroundColor: Colors.white,
//             body: Center(
//               child: CircularProgressIndicator(
//                 color: Colors.white,
//               ),
//             ),
//           );
//         } else {
//           WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
//             if (snapshot.hasData) {
//               if ((snapshot.data?.displayName ?? "").isEmpty) {
//                 context.go(AppRouteName.splash);
//               } else {
//                 context.go(AppRouteName.primary);
//               }
//             } else {
//               context.go(AppRouteName.register);
//             }
//           });
//         }
//
//         return const Scaffold(
//           backgroundColor: Colors.white,
//           body: Center(
//             child: CircularProgressIndicator(
//               color: Colors.black,
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
//
