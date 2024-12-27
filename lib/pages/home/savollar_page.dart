import 'package:app_quiz/core/widgets/timer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:app_quiz/core/routes/approutesname.dart';
import 'package:app_quiz/pages/departments/ctr_departments.dart';
import 'package:app_quiz/setup.dart';
import '../../core/widgets/app_colors.dart';
import '../../core/widgets/app_style.dart';
import 'package:go_router/go_router.dart';

class SavollarPage extends StatefulWidget {
  final String questionLevel;

  const SavollarPage({super.key, required this.questionLevel});

  @override
  State<SavollarPage> createState() => _SavollarPageState();
}

class _SavollarPageState extends State<SavollarPage> {
  int currentIndex = 0;
  bool? isCorrect;
  int correctAnswers = 0;
  int incorrectAnswers = 0;

  final PageController _pageController = PageController();

  void _onAnswerSelected(bool correct) {
    setState(() {
      isCorrect = correct;
      if (correct) {
        correctAnswers++;
      } else {
        incorrectAnswers++;
      }
    });

    Future.delayed(const Duration(seconds: 1), () {
      if (currentIndex + 1 == SavollarController.savollarlisti.length) {
        _showResults();
      } else {
        setState(() {
          isCorrect = null;
          currentIndex =
              (currentIndex + 1) % SavollarController.savollarlisti.length;
        });
        _nextPage();
      }
    });
  }

  void _nextPage() {
    if (_pageController.hasClients) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    }
  }

  void _showResults() async {
    int ball =
        box.get('ball') ?? 0; // Provide a default value of 0 if 'ball' is null
    await box.put('ball',
        correctAnswers + ball); // Store the updated score directly as an int
    context.go(
      "${AppRouteName.menu}/${AppRouteName.department}/${AppRouteName.darajalar}/${AppRouteName.savollar}/${AppRouteName.natija}",
      extra: {
        'correctAnswers': correctAnswers,
        'incorrectAnswers': incorrectAnswers,
      },
    );
  }

  void _onTimerEnd() {
    if (isCorrect == null) {
      _onAnswerSelected(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final question = SavollarController.savollarlisti[currentIndex];
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            GoRouter.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back),
        ),
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
      body: PageView.builder(
        physics: const NeverScrollableScrollPhysics(),
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        itemCount: SavollarController.savollarlisti.length,
        itemBuilder: (context, index) {
          final question = SavollarController.savollarlisti[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              children: [
                const SizedBox(height: 46),
                Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.055),
                      padding: const EdgeInsets.all(16),
                      width: MediaQuery.of(context).size.width * 1,
                      decoration: BoxDecoration(
                        color: AppColors.c_00B533,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        question.savol ?? '',
                        style: AppStyle.loremTexts,
                      ),
                    ),
                    Positioned(
                      top: MediaQuery.of(context).size.height * -0.01,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 9),
                        child: CircleAvatar(
                          radius: 33,
                          backgroundColor: AppColors.c_00B533,
                          child: CircleAvatar(
                            radius: 30,
                            backgroundColor: Colors.white,
                            child: CircleAvatar(
                              radius: 25,
                              backgroundColor: AppColors.c_00B533,
                              child: TimerPage(onTimerEnd: _onTimerEnd),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 80),
                ...question.variant.asMap().entries.map((entry) {
                  int idx = entry.key;
                  var variant = entry.value;
                  Color bgColor;
                  if (isCorrect == null) {
                    bgColor = Colors.transparent;
                  } else if (isCorrect == true && variant.javob) {
                    bgColor = Colors.green;
                  } else if (isCorrect == false && variant.javob) {
                    bgColor = Colors.green;
                  } else if (isCorrect == false && !variant.javob) {
                    bgColor = Colors.red;
                  } else {
                    bgColor = Colors.transparent;
                  }
                  return Column(
                    children: [
                      OutlinedButton(
                        onPressed: isCorrect == null
                            ? () {
                                _onAnswerSelected(variant.javob);
                              }
                            : null,
                        style: OutlinedButton.styleFrom(
                          fixedSize: const Size(double.infinity, 54),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          side: const BorderSide(
                            color: AppColors.c_00B533,
                          ),
                          splashFactory: NoSplash.splashFactory,
                          backgroundColor: bgColor,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text("${String.fromCharCode(65 + idx)}. ",
                                style: AppStyle.variant),
                            Text(variant.text ?? '',
                                style: AppStyle.textSavolStyle),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  );
                }).toList(),
              ],
            ),
          );
        },
      ),
    );
  }
}
