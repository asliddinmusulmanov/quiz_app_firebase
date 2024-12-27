import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:app_quiz/core/routes/approutesname.dart';
import 'package:app_quiz/core/widgets/app_colors.dart';
import 'package:app_quiz/core/widgets/app_style.dart';
import 'package:app_quiz/pages/departments/ctr_departments.dart';

class Departments extends StatefulWidget {
  final String languagename;
  final String languageimage;
  const Departments({
    super.key,
    required this.languagename,
    required this.languageimage,
  });

  @override
  State<Departments> createState() => _DepartmentsState();
}

class _DepartmentsState extends State<Departments> {
  int currentIndex = 0;
  late String collectionpath;
  int modul = 1;
  int dars = 1;

  @override
  void initState() {
    super.initState();
    collectionpath =
        widget.languagename[0].toLowerCase() + widget.languagename.substring(1);
    SavollarController.getModulesAndLessons(setState,
        collectionpath: collectionpath);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            expandedHeight: 200.0,
            leadingWidth: 100,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                widget.languagename,
                style: AppStyle.flutterSliverAppBar,
              ),
              background: Image.asset(
                widget.languageimage,
                // fit: BoxFit.cover,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              color: Colors.white,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children:
                      List.generate(SavollarController.list.length, (indexx) {
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 5.0),
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: MaterialButton(
                          elevation: 0,
                          color: currentIndex == indexx
                              ? AppColors.c_00B533
                              : AppColors.c_F5F5F5,
                          onPressed: () async {
                            currentIndex = indexx;
                            modul = indexx + 1;
                            debugPrint('$modul =>$dars');

                            await SavollarController.getModulesAndLessons(
                              setState,
                              collectionpath: collectionpath,
                            );
                            setState(() {});
                          },
                          child: Text('${indexx + 1}-modul'),
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Card(
                    elevation: 0,
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    color: AppColors.c_F5F5F5,
                    child: ListTile(
                      leading: Text(
                        '${index + 1}.',
                        style: AppStyle.lessonsName,
                      ),
                      title: Text(
                        'Flutter',
                        style: AppStyle.lessonsName,
                      ),
                      trailing: IconButton(
                        icon: const Icon(
                          Icons.add,
                          color: AppColors.c_000000,
                        ),
                        onPressed: () async {
                          dars = index + 1;
                          debugPrint('$modul =>$dars');
                          //                   context.go(AppRouteName.savollar, extra: {
                          //   'collectionpath': collectionpath,
                          //   'modul': modul,
                          //   'dars':dars,
                          //   'level':'easy',
                          // });
                          // context.go("${AppRouteName.menu}/${AppRouteName.department}/${AppRouteName.darajalar}");
                          if (!context.mounted) return;
                          context.push(
                            "${AppRouteName.menu}/${AppRouteName.department}/${AppRouteName.darajalar}",
                            extra: {
                              'collectionpath': collectionpath,
                              'modul': modul,
                              'dars': dars,
                            },
                          );
                        },
                      ),
                    ),
                  ),
                );
              },
              childCount: SavollarController.list.isNotEmpty
                  ? SavollarController.darslar
                  : 0,
            ),
          ),
        ],
      ),
    );
  }
}
