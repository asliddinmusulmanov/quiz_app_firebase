import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:app_quiz/core/routes/approutesname.dart';
import 'package:app_quiz/setup.dart';

class SplashPages extends StatefulWidget {
  const SplashPages({super.key});

  @override
  State<SplashPages> createState() => _SplashPagesState();
}

class _SplashPagesState extends State<SplashPages>
    with TickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    );
    _animation = Tween(end: 0.80, begin: 0.1).animate(_controller);
    _controller.forward();
    stack();
    super.initState();
  }

  Future<void> stack() async {
    return await Future.delayed(
      const Duration(seconds: 3),
      () async {
        await box.get('email') == null
            ? context.go(AppRouteName.login)
            : context.go(AppRouteName.menu);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Stack(
            children: [
              // FadeTransition(
              //   opacity: _animation,
              //   child: SlideTransition(
              //     position: _animationIcons,
              //     child: Padding(
              //       padding: const EdgeInsets.only(top: 10),
              //       child: Image.asset(
              //         "assets/images/img_2.png",
              //         width: 300,
              //       ),
              //     ),
              //   ),
              // ),
              FadeTransition(
                opacity: _animation,
                child: Image.asset(
                  "assets/images/img.png",
                  width: 350,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
