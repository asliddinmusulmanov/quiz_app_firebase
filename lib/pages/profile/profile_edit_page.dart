import 'dart:io';
import 'package:app_quiz/core/routes/approutesname.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:app_quiz/core/widgets/app_colors.dart';
import 'package:app_quiz/core/widgets/app_style.dart';
import 'package:app_quiz/setup.dart'; // Ensure this imports your Hive setup and other necessary setups

class ProfileEditPage extends StatefulWidget {
  const ProfileEditPage({super.key});

  @override
  State<ProfileEditPage> createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<ProfileEditPage> {
  File? file;
  bool isImageSelected = false;
  bool isLoading = false;
  bool isCamera = false;
  final firstname = TextEditingController();
  final lastname = TextEditingController();

  Future<void> getImage() async {
    final ImagePicker picker = ImagePicker();
    XFile? xFile = await picker.pickImage(
        source: isCamera ? ImageSource.camera : ImageSource.gallery);
    if (xFile != null) {
      file = File(xFile.path);
      final directory = await getApplicationDocumentsDirectory();
      await file!.copy("${directory.path}/image.png");
      isImageSelected = true;
      setState(() {});
    }
  }

  Future<void> read() async {
    final directory = await getApplicationDocumentsDirectory();
    await for (var event in directory.list()) {
      if (event.path.contains('image.png')) {
        file = File(event.path);
        isImageSelected = true;
      }
    }
    setState(() {
      isLoading = true;
    });
  }

  Future<void> logout() async {
    await box.clear(); // Clear
    context.go(AppRouteName.splash);
  }

  @override
  void initState() {
    super.initState();
    read();
    firstname.text = box.get('name', defaultValue: '');
    lastname.text = ''; // Set the initial value for lastname
  }

  @override
  Widget build(BuildContext context) {
    bool isLogin = box.get('register') == 'login';
    String displayText = isLogin
        ? box
            .get('email')
            .toString()
            .substring(0, box.get('email').toString().length - 10)
        : box.get('name') ?? '';

    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: PopupMenuButton<int>(
              icon: const Icon(Icons.more_vert),
              onSelected: (value) {
                if (value == 0) {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return Container(
                        height: 120,
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(20),
                              topLeft: Radius.circular(20)),
                        ),
                        child: Column(
                          children: [
                            MaterialButton(
                              minWidth: double.infinity,
                              onPressed: () async {
                                isCamera = false;
                                Navigator.pop(
                                    context); // Close the bottom sheet
                                await getImage();
                              },
                              child: const Text("Gallery"),
                            ),
                            MaterialButton(
                              minWidth: double.infinity,
                              onPressed: () async {
                                isCamera = true;
                                Navigator.pop(
                                    context); // Close the bottom sheet
                                await getImage();
                              },
                              child: const Text("Camera"),
                            )
                          ],
                        ),
                      );
                    },
                  );
                } else if (value == 1) {
                  logout(); // Handle logout
                }
              },
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: 0,
                  child: ListTile(
                    leading: Icon(Icons.camera_alt),
                    title: Text("Set Profile Photo"),
                  ),
                ),
                const PopupMenuItem(
                  value: 1,
                  child: ListTile(
                    leading: Icon(Icons.logout),
                    title: Text("Log out"),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              CircleAvatar(
                radius: 60,
                backgroundColor: Colors.transparent,
                backgroundImage: profileImage(file: file),
              ),
              const SizedBox(height: 10),
              const Text('User Name'),
              Text(
                displayText,
                style: AppStyle.natija,
              ),
              const SizedBox(height: 15),
              const Text('Email'),
              Text('${box.get('email')}', style: AppStyle.natija),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 15),
                    const Divider(),
                    const Text('Enter your information\nto make changes'),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: firstname,
                      decoration: const InputDecoration(
                        counterStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                        label: Text(
                          " First Name",
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                        hintText: 'Enter First Name',
                        hintStyle: TextStyle(
                          color: Color(0xffC1C1C1),
                          fontWeight: FontWeight.w400,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xff00B533)),
                          borderRadius: BorderRadius.all(
                            Radius.circular(14),
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xffC1C1C1)),
                          borderRadius: BorderRadius.all(
                            Radius.circular(14),
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(14),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: lastname,
                      decoration: const InputDecoration(
                        counterStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                        label: Text(
                          " Last Name",
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                        hintText: 'Enter Last Name',
                        hintStyle: TextStyle(
                          color: Color(0xffC1C1C1),
                          fontWeight: FontWeight.w400,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xff00B533)),
                          borderRadius: BorderRadius.all(
                            Radius.circular(14),
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xffC1C1C1)),
                          borderRadius: BorderRadius.all(
                            Radius.circular(14),
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(14),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      decoration: const InputDecoration(
                        counterStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                        label: Text(
                          " Password",
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                        hintText: 'Enter Password',
                        hintStyle: TextStyle(
                          color: Color(0xffC1C1C1),
                          fontWeight: FontWeight.w400,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xff00B533)),
                          borderRadius: BorderRadius.all(
                            Radius.circular(14),
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xffC1C1C1)),
                          borderRadius: BorderRadius.all(
                            Radius.circular(14),
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(14),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      decoration: const InputDecoration(
                        counterStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                        label: Text(
                          " Confirm Password",
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                        hintText: 'Retype Confirm Password',
                        hintStyle: TextStyle(
                          color: Color(0xffC1C1C1),
                          fontWeight: FontWeight.w400,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xff00B533)),
                          borderRadius: BorderRadius.all(
                            Radius.circular(14),
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xffC1C1C1)),
                          borderRadius: BorderRadius.all(
                            Radius.circular(14),
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(14),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.c_00B533,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        fixedSize: const Size(double.maxFinite, 55),
                      ),
                      onPressed: () async {
                        await box.put('name', firstname.text);
                        setState(() {});
                      },
                      child: Text("Save", style: AppStyle.signIn),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

ImageProvider<Object>? profileImage({File? file}) {
  return file != null
      ? Image.file(file).image
      : const AssetImage("assets/images/img_22.png");
}
