import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:app_quiz/core/routes/approutesname.dart';

class Primary extends StatefulWidget {
  final Widget child;
  const Primary(this.child, {super.key});

  @override
  State<Primary> createState() => PrimaryState();
}

class PrimaryState extends State<Primary> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    context.go(
      index == 0
          ? AppRouteName.menu
          : index == 1
              ? AppRouteName.level
              : AppRouteName.profile,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: widget.child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/svg/home2.svg'),
            activeIcon: SvgPicture.asset('assets/svg/home.svg'),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/svg/reyting.svg'),
            activeIcon: SvgPicture.asset('assets/svg/reyting2.svg'),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/svg/profile.svg'),
            activeIcon: SvgPicture.asset('assets/svg/profile2.svg'),
            label: '',
          ),
        ],
      ),
    );
  }
}
