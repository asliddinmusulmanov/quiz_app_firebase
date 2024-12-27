import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:app_quiz/core/routes/approutesname.dart';
import 'package:app_quiz/core/widgets/app_colors.dart';
import 'package:app_quiz/core/widgets/app_style.dart';
import 'package:app_quiz/setup.dart';

import '../../core/db/shared_preferens.dart';
import '../../core/services/auth_ser.dart';
import '../../core/services/utils_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

TextEditingController loginEmailC = TextEditingController();
TextEditingController loginPasswordC = TextEditingController();

bool isVisibility = true;
bool errorText = true;

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> globalKey = GlobalKey<FormState>();

  // Added FocusNode instances
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Form(
            key: globalKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 104, left: 85),
                  child: Image.asset(
                    'assets/images/img.png',
                    width: 205,
                    height: 65,
                  ),
                ),
                const SizedBox(height: 70),
                Text('Hello,', style: AppStyle.hello),
                Text('Your are welcome', style: AppStyle.yourAreWelcome),
                const SizedBox(height: 40),
                TextFormField(
                  controller: loginEmailC,
                  // Associated FocusNode instance with the email field
                  focusNode: emailFocusNode,
                  textInputAction:
                      TextInputAction.next, // Set text input action to 'next'
                  decoration: const InputDecoration(
                    counterStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                    label: Text(
                      " Email",
                      style: TextStyle(
                        color: AppColors.c_C1C1C1,
                      ),
                    ),
                    hintStyle: TextStyle(
                      color: Color(0xff454B60),
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
                      borderSide: BorderSide(color: Color(0xffD9D9D9)),
                      borderRadius: BorderRadius.all(
                        Radius.circular(14),
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value != null && value.isNotEmpty) {
                      return null;
                    } else {
                      return "Please enter your email address";
                    }
                  },
                  onChanged: (value) {
                    if (globalKey.currentState!.validate()) {
                      setState(() {});
                    }
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  obscureText: isVisibility,
                  controller: loginPasswordC,
                  // Associated FocusNode instance with the password field
                  focusNode: passwordFocusNode,
                  textInputAction:
                      TextInputAction.done, // Set text input action to 'done'
                  decoration: InputDecoration(
                    counterStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                    suffixIcon: IconButton(
                      splashColor: Colors.white,
                      // splashRadius: 0,
                      style: const ButtonStyle(
                        surfaceTintColor:
                            MaterialStatePropertyAll(Colors.transparent),
                        foregroundColor:
                            MaterialStatePropertyAll(Colors.transparent),
                      ),
                      onPressed: () {
                        isVisibility = !isVisibility;
                        setState(() {});
                      },
                      icon: isVisibility
                          ? const Icon(
                              Icons.visibility_off,
                              color: AppColors.c_C1C1C1,
                            )
                          : const Icon(
                              Icons.visibility,
                              color: AppColors.c_C1C1C1,
                            ),
                    ),
                    label: const Text(
                      " Password",
                      style: TextStyle(
                        color: AppColors.c_C1C1C1,
                      ),
                    ),
                    hintStyle: const TextStyle(
                      color: Color(0xff454B60),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xff00B533)),
                      borderRadius: BorderRadius.all(
                        Radius.circular(14),
                      ),
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xffC1C1C1)),
                      borderRadius: BorderRadius.all(
                        Radius.circular(14),
                      ),
                    ),
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(14),
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value != null && value.isNotEmpty) {
                      return null;
                    } else {
                      return "Please enter your password";
                    }
                  },
                  onChanged: (value) {
                    if (globalKey.currentState!.validate()) {
                      setState(() {});
                    }
                  },
                ),
                const SizedBox(height: 40),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.c_00B533,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    fixedSize: const Size(double.maxFinite, 60),
                  ),
                  onPressed: () async {
                    User? user1 = await AuthService.loginUser(context,
                        email: loginEmailC.text, password: loginPasswordC.text);
                    if (user1 != null) {
                      await setLoginState(true);
                      await box.put('register', 'login');
                      await box.put('email', loginEmailC.text);
                      Utils.fireSnackBar("Successfully", context);
                      context.go("${AppRouteName.menu}");
                    } else {
                      setState(() {});
                      errorText = false;
                    }
                  },
                  child: Text("Sign In", style: AppStyle.signIn),
                ),
                const SizedBox(height: 30),
                Padding(
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.18),
                  child: Image.asset(
                    'assets/images/img_3.png',
                    width: MediaQuery.of(context).size.width * 0.5,
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        elevation: 10,
                        backgroundColor: AppColors.c_FFFFFF,
                        fixedSize: const Size(34, 54),
                      ),
                      onPressed: () {},
                      child: SvgPicture.asset(
                        'assets/svg/google2.svg',
                        height: 24,
                        width: 24,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Don’t have an account?', style: AppStyle.sendAgain),
                    TextButton(
                      onPressed: () {
                        context.go(
                            "${AppRouteName.login}/${AppRouteName.register}");
                      },
                      style: const ButtonStyle(
                          splashFactory: NoSplash.splashFactory,
                          surfaceTintColor:
                              MaterialStatePropertyAll(Colors.green)),
                      child: Text('Sign up', style: AppStyle.second),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
