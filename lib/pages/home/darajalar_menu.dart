import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:app_quiz/core/routes/approutesname.dart';
import 'package:app_quiz/pages/departments/ctr_departments.dart';
import 'package:app_quiz/core/widgets/app_colors.dart';
import 'package:app_quiz/core/widgets/app_style.dart';

class DarajalarMenu extends StatefulWidget {
  final String collectionpath;
  final int modul;
  final int dars;
  const DarajalarMenu(
      {super.key,
      required this.collectionpath,
      required this.modul,
      required this.dars});

  @override
  State<DarajalarMenu> createState() => _DarajalarMenuState();
}

class _DarajalarMenuState extends State<DarajalarMenu> {
  void oninit() async {
    await SavollarController.getLessonDetails(
      setState,
      '${widget.modul}modul',
      '${widget.dars}dars',
      collectionpath: widget.collectionpath,
    );
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    oninit();
  }

  Future<void> _navigateToSavollarPage(String level) async {
    await SavollarController.getQuestions(
      setState,
      widget.collectionpath,
      '${widget.modul}modul',
      '${widget.dars}dars',
      level,
    );

    // void _goToNextPage() {
    //   context.go(AppRouteName.savollar, extra: {
    //     'collectionpath': widget.collectionpath,
    //     'modul': widget.modul,
    //     'dars': widget.dars,
    //     'level': 'easy',
    //   });
    // }
  }

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
      body: Column(
        children: [
          const SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Container(
              height: 162,
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.c_00B533,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Column(
                  children: [
                    Text('Welcome to I.Q', style: AppStyle.welcomeTo),
                    const SizedBox(height: 10),
                    Text(
                      '''Lorem ipsum dolor sit amet,''',
                      style: AppStyle.loremTexts,
                    ),
                    Text(
                      'consectetur adipiscing elit. Quisque',
                      style: AppStyle.loremTexts,
                    ),
                    Text(
                      'sit amet velit malesuada, scelerisque',
                      style: AppStyle.loremTexts,
                    ),
                    Text(
                      'orci nec, ultrices justo. ',
                      style: AppStyle.loremTexts,
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 57),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: Column(
              children: [
                Text(
                  'Choose one of the',
                  style: AppStyle.chooseOne,
                ),
                Text(
                  'steps...',
                  style: AppStyle.chooseOne,
                ),
                const SizedBox(height: 25),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.c_00B533,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    fixedSize: const Size(double.maxFinite, 60),
                  ),
                  onPressed: () async {
                    await _navigateToSavollarPage('easy');
                    context.go(
                        "${AppRouteName.menu}/${AppRouteName.department}/${AppRouteName.darajalar}/${AppRouteName.savollar}",
                        extra: {"questionLevel": 'easy'});
                  },
                  child: Text(
                    'Easy',
                    style: AppStyle.textDarajaStyle,
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.c_00B533,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    fixedSize: const Size(double.maxFinite, 60),
                  ),
                  onPressed: () async {
                    await _navigateToSavollarPage('medium');
                    context.go(
                        "${AppRouteName.menu}/${AppRouteName.department}/${AppRouteName.darajalar}/${AppRouteName.savollar}",
                        extra: {"questionLevel": 'medium'});
                  },
                  child: Text(
                    'Medium',
                    style: AppStyle.textDarajaStyle,
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.c_00B533,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    fixedSize: const Size(double.maxFinite, 60),
                  ),
                  onPressed: () async {
                    await _navigateToSavollarPage('hard');
                    context.go(
                        "${AppRouteName.menu}/${AppRouteName.department}/${AppRouteName.darajalar}/${AppRouteName.savollar}",
                        extra: {"questionLevel": 'hard'});
                  },
                  child: Text(
                    'Hard',
                    style: AppStyle.textDarajaStyle,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
