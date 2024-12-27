import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:app_quiz/pages/menu/menu.dart';
import 'package:app_quiz/pages/reyting/reyting_page.dart';

import '../profile/profile_edit_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentIndex = 0;
  final List<Widget> _pages = const [
    MenuPage(),
    ReytingPage(),
    ProfileEditPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: [_pages[currentIndex]],
      ),
      bottomNavigationBar: Container(
        width: double.infinity,
        height: 71,
        decoration: const BoxDecoration(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            MaterialButton(
                onPressed: () {
                  currentIndex = 0;
                  setState(() {});
                },
                splashColor:
                    currentIndex == 0 ? Colors.green : Colors.transparent,
                child: SvgPicture.asset(
                  "assets/images/homeIcon1.svg",
                  color: currentIndex == 0 ? Colors.green : Colors.black,
                )),
            MaterialButton(
                onPressed: () {
                  currentIndex = 1;
                  setState(() {});
                },
                splashColor: Colors.transparent,
                child: SvgPicture.asset(
                  "assets/images/homeIcon2.svg",
                  color: currentIndex == 1 ? Colors.green : Colors.black,
                )),
            MaterialButton(
              onPressed: () {
                currentIndex = 2;
                setState(() {});
              },
              splashColor: Colors.transparent,
              child: SvgPicture.asset(
                "assets/images/homeIcon3.svg",
                color: currentIndex == 2 ? Colors.green : Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
