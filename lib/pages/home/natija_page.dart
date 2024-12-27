import 'package:app_quiz/core/routes/approutesname.dart';
import 'package:app_quiz/pages/home/darajalar_menu.dart';
import 'package:app_quiz/pages/menu/menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../core/widgets/app_colors.dart';
import '../../core/widgets/app_style.dart';

class NatijaPage extends StatefulWidget {
  final int correctAnswers;
  final int incorrectAnswers;
  const NatijaPage({
    super.key,
    required this.correctAnswers,
    required this.incorrectAnswers,
  });
  @override
  State<NatijaPage> createState() => _NatijaPageState();
}

class _NatijaPageState extends State<NatijaPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Lorem ipsum dolor sit amet c...",
          style: AppStyle.appBarLoremTextStyle,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: CircleAvatar(
              radius: 25,
              backgroundColor: AppColors.c_F5F5F5,
              child: SvgPicture.asset(
                'assets/svg/flutter.svg',
                width: 21,
                height: 26,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 199,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: AppColors.c_00B533,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        CircleAvatar(
                          radius: 55,
                          backgroundColor: Colors.white54.withOpacity(0.2),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: CircleAvatar(
                            radius: 45,
                            backgroundColor: Colors.white54.withOpacity(0.4),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: CircleAvatar(
                            radius: 35,
                            backgroundColor: Colors.white,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "Your",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 10,
                                    color: AppColors.c_00B533,
                                  ),
                                ),
                                const Text(
                                  "Result",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 10,
                                    color: AppColors.c_00B533,
                                  ),
                                ),
                                Text(
                                  "${widget.correctAnswers}",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18,
                                    color: AppColors.c_00B533,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 50),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 139),
                  child: Container(
                    height: 120,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: AppColors.c_FFFFFF,
                      boxShadow: const [
                        BoxShadow(
                          color: AppColors.c_D9D9D9,
                          offset: Offset(0, 3),
                          blurRadius: 3,
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ListTile(
                            leading: const CircleAvatar(
                              radius: 12,
                              backgroundColor: AppColors.c_00B533,
                            ),
                            title: Text(
                                '${widget.correctAnswers} correct answers'),
                          ),
                          ListTile(
                            leading: const CircleAvatar(
                              radius: 12,
                              backgroundColor: AppColors.c_FF0000,
                            ),
                            title: Text(
                                '${widget.incorrectAnswers} correct answers'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            OutlinedButton(
              onPressed: () {
                context.push(
                    "${AppRouteName.menu}/${AppRouteName.department}/${AppRouteName.darajalar}");
              },
              style: OutlinedButton.styleFrom(
                fixedSize: const Size(double.infinity, 54),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                side: const BorderSide(
                  color: AppColors.c_00B533,
                ),
                splashFactory: NoSplash.splashFactory,
                backgroundColor: Colors.transparent,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Restart the test", style: AppStyle.result),
                ],
              ),
            ),
            const SizedBox(height: 20),
            OutlinedButton(
              onPressed: () {
                context.go(AppRouteName.menu);
              },
              style: OutlinedButton.styleFrom(
                fixedSize: const Size(double.infinity, 54),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                side: const BorderSide(
                  color: AppColors.c_00B533,
                ),
                splashFactory: NoSplash.splashFactory,
                backgroundColor: Colors.transparent,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Return to main menu", style: AppStyle.result),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
