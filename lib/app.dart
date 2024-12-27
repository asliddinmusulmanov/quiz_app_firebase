import 'package:flutter/material.dart';

import 'core/routes/go_route_system.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    // return const MaterialApp(
    //   home: ReytinPage2(),
    // );
    return MaterialApp.router(
      routerConfig: AppRouter.router,
      theme: ThemeData(
        useMaterial3: false,
        appBarTheme: const AppBarTheme(
            color: Colors.white, elevation: 0, foregroundColor: Colors.black),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
