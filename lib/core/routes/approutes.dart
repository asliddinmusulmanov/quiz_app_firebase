// import 'package:flutter/material.dart';
// import 'package:quiz_app/pages/home/darajalar_menu.dart';
// import 'package:quiz_app/pages/home/departments_page.dart';
// import 'package:quiz_app/pages/home/menu.dart';
// import 'package:quiz_app/pages/home/natija_page.dart';
// import 'package:quiz_app/pages/home/savollar_page.dart';
// import 'package:quiz_app/pages/menu/menu.dart';
// import 'package:quiz_app/pages/mylevel/level_page.dart';
// import 'package:quiz_app/pages/profile/profile_edit_page.dart';
// import 'package:quiz_app/pages/reyting/reyting_page.dart';

// import 'approutesname.dart';

// final class AppRoute<T extends Object?> {
//   const AppRoute();

//   Route<T> onGenerateRoute(RouteSettings settings) {
//     switch (settings.name) {
//       case AppRouteName.menu:
//         return MaterialPageRoute(
//           builder: (context) => const MenuPage(),
//         );
//       case AppRouteName.department:
//         return MaterialPageRoute(
//           builder: (context) => const Departments(),
//         );
//       case AppRouteName.darajalar:
//         return MaterialPageRoute(
//           builder: (context) => const DarajalarMenu(),
//         );
//       case AppRouteName.savollar:
//         return MaterialPageRoute(
//           builder: (context) => const SavollarPage(),
//         );
//       case AppRouteName.natija:
//         return MaterialPageRoute(
//           builder: (context) => const NatijaPage(),
//         );
//       case AppRouteName.level:
//         return MaterialPageRoute(
//           builder: (context) => const LevelPage(),
//         );
//       case AppRouteName.reyting:
//         return MaterialPageRoute(
//           builder: (context) => const ReytingPage(),
//         );
//       case AppRouteName.profile:
//         return MaterialPageRoute(
//           builder: (context) => const ProfileEditPage(),
//         );
//       default:
//         return _errorRoute();
//     }
//   }

//   Route<T> _errorRoute() => MaterialPageRoute<T>(
//         builder: (context) => Scaffold(
//           body: Center(
//             child: Text(
//               'Error Route',
//               style: Theme.of(context).textTheme.bodyLarge?.copyWith(
//                     color: Colors.black,
//                   ),
//             ),
//           ),
//         ),
//       );
// }
