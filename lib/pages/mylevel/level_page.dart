import 'package:app_quiz/core/routes/approutesname.dart';
import 'package:flutter/material.dart';
import 'package:app_quiz/pages/mylevel/ctr_level.dart';
import 'package:app_quiz/pages/reyting/reyting_page.dart';
import 'package:app_quiz/core/widgets/app_colors.dart';
import 'package:app_quiz/core/widgets/app_style.dart';
import 'package:go_router/go_router.dart';

class LevelPage extends StatefulWidget {
  const LevelPage({super.key});

  @override
  State<LevelPage> createState() => _LevelPageState();
}

class _LevelPageState extends State<LevelPage> {
  @override
  void initState() {
    MyLevelController.getAllData(setState);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Text(
            'My Level',
            style: AppStyle.natija,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: CircleAvatar(
              radius: 35,
              backgroundColor: const Color(0xff00B533),
              child: Image.asset(
                'assets/images/4e79c0324e16a6e05cb4555a0dd25e28.png',
              ),
            ),
          ),
        ],
      ),
      body: MyLevelController.isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: ListView.builder(
                itemCount: MyLevelController.reytinglist.length,
                itemBuilder: (context, index) {
                  var item = MyLevelController.reytinglist[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Card(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      elevation: 0,
                      color: const Color(0xffF5F5F5),
                      child: ListTile(
                        onTap: () {
                          context.go(
                              "${AppRouteName.level}/${AppRouteName.reyting}");
                        },
                        title: Text(
                          item.keys.first,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        leading: Image.asset(
                          iconsList[index],
                          cacheWidth: 50,
                          height: 40,
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text(
                              '9/',
                              style: TextStyle(fontSize: 16),
                            ),
                            Text(
                              item.values.first.toString(),
                              style: TextStyle(
                                fontSize: 16,
                                color: item.values.first <= 3
                                    ? AppColors.c_FF0000
                                    : AppColors.c_00B533,
                              ),
                            ),
                            const Icon(Icons.navigate_next),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }
}

List<String> iconsList = [
  'assets/images/img_4.png',
  'assets/images/img_5.png',
  'assets/images/img_7.png',
  'assets/images/img_6.png',
  'assets/images/img_9.png',
  'assets/images/img_8.png',
  'assets/images/img_10.png',
  'assets/images/img_11.png',
];
