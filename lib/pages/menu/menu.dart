import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:app_quiz/pages/admin_panel/adminpanel.dart';
import 'package:app_quiz/pages/departments/ctr_departments.dart';
import 'package:app_quiz/pages/departments/departments_page.dart';
import 'package:app_quiz/core/widgets/app_style.dart';
import 'package:path_provider/path_provider.dart';

import '../../setup.dart';
import '../reyting/ctr_reyting.dart';

class MenuPage extends StatefulWidget {
  final User? user;
  const MenuPage({super.key, this.user});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  File? file;

  Future<void> read() async {
    final directory = await getApplicationDocumentsDirectory();
    await for (var event in directory.list()) {
      if (event.path.contains('image.png')) {
        file = File(event.path);
      }
    }
    setState(() {});
  }

  @override
  void initState() {
    read();
    ReytingController.getAllData(setState);
    super.initState();
  }

  ImageProvider? profileImage({required File? file}) {
    if (file != null) {
      return FileImage(file);
    } else {
      return const AssetImage(
        'assets/images/4e79c0324e16a6e05cb4555a0dd25e28.png',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isLogin = box.get('register') == 'login';
    String displayText = isLogin
        ? box
            .get('email')
            .toString()
            .substring(0, box.get('email').toString().length - 10)
        : box.get('name');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Text('Hello ${displayText}', style: AppStyle.helloName),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 35),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AdminPanel(),
                  ),
                );
              },
              child: CircleAvatar(
                radius: 35,
                // backgroundColor: const Color(0xff00B533),
                backgroundImage: profileImage(file: file),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: GridView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: 8,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2),
          itemBuilder: (_, index) {
            var image = 'assets/images/img_${3 + index + 1}.png';
            return MaterialButton(
              splashColor: Colors.transparent,
              height: 142,
              minWidth: 142,
              onPressed: () {
                // Clear the lists before navigating
                SavollarController.list.clear();
                SavollarController.savollarlisti.clear();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Departments(
                      languagename: languagesName.elementAt(index),
                      languageimage: image,
                    ),
                  ),
                );
              },
              child: Container(
                height: 142,
                width: 142,
                decoration: const BoxDecoration(
                  color: Color(0xffF5F5F5),
                  borderRadius: BorderRadius.all(
                    Radius.circular(15),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      image,
                      width: 60.57,
                      height: 75,
                    ),
                    const SizedBox(height: 20),
                    Text(languagesName.elementAt(index),
                        style: AppStyle.languageStyle),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  List<String> languagesName = [
    'Flutter',
    'Python',
    'Frontend',
    'Java',
    'C++',
    'C#',
    'Android',
    'Ios',
  ];
}
