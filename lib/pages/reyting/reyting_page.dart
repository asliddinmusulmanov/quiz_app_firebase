import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:app_quiz/core/widgets/app_style.dart';
import 'package:app_quiz/pages/profile/profile_edit_page.dart';
import 'package:app_quiz/pages/reyting/ctr_reyting.dart';
import 'package:app_quiz/setup.dart';

class ReytingPage extends StatefulWidget {
  const ReytingPage({super.key});

  @override
  State<ReytingPage> createState() => _ReytingPageState();
}

class _ReytingPageState extends State<ReytingPage> {
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
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200.0,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: const Text(
                'Flutter',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              background: Image.asset(
                'assets/images/img_4.png',
                cacheWidth: 100,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: ListTile(
              leading: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '${1}  ',
                    style: AppStyle.userreyting,
                  ),
                  CircleAvatar(
                    radius: 20,
                    backgroundImage: profileImage(file: file) ?? profileImage(),
                    backgroundColor: Colors.white,
                  ),
                ],
              ),
              title: Text(displayText, style: AppStyle.userreyting),
              trailing: Text('⭐️ ${box.get('ball') ?? 0}',
                  style: AppStyle.userreyting),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                var item = ReytingController.reytinglist[index];
                return Column(
                  children: [
                    ListTile(
                      leading: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            '${index + 1}  ',
                            style: AppStyle.userreyting,
                          ),
                          CircleAvatar(
                            radius: 20,
                            backgroundImage: NetworkImage(item.image),
                            backgroundColor: Colors.black12,
                          ),
                        ],
                      ),
                      title: Text(item.name, style: AppStyle.userreyting),
                      trailing:
                          Text('⭐️ ${item.ball}', style: AppStyle.userreyting),
                    ),
                  ],
                );
              },
              childCount: ReytingController.reytinglist.length,
            ),
          ),
        ],
      ),
    );
  }
}

List<String> usersList = [
  'assets/images/img_12.png',
  'assets/images/img_13.png',
  'assets/images/img_14.png',
  'assets/images/img_15.png',
  'assets/images/img_16.png',
  'assets/images/img_17.png',
  'assets/images/img_18.png',
  'assets/images/img_19.png',
  'assets/images/img_20.png',
  'assets/images/img_21.png',
];
