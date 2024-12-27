import 'package:email_otp/email_otp.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:app_quiz/core/routes/approutesname.dart';
import 'package:app_quiz/core/widgets/app_style.dart';
import '../../core/services/utils_service.dart';
import '../../data/models/auth_model.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

TextEditingController regNameC = TextEditingController();
TextEditingController regEmailC = TextEditingController();
TextEditingController regPasswordC = TextEditingController();
EmailOTP myauth = EmailOTP();

bool check = false;
bool isnima = true;
bool isnimadir = true;

class _RegisterPageState extends State<RegisterPage> {
  bool isLoading = false;

  final GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            child: Form(
              key: globalKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Create an account', style: AppStyle.createAnAccount),
                  Text(
                    'Let’s help you set up your account,\nit won’t take long.',
                    style: AppStyle.letsHelp,
                  ),
                  const SizedBox(height: 30),
                  TextFormField(
                    controller: regNameC,
                    decoration: const InputDecoration(
                      counterStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                      label: Text(
                        " Name",
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      hintText: 'Enter Name',
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
                    validator: (value) {
                      if (value != null && value.isNotEmpty) {
                        return null;
                      } else {
                        return 'Please enter your name';
                      }
                    },
                  ),
                  const SizedBox(height: 30),
                  TextFormField(
                    controller: regEmailC,
                    decoration: const InputDecoration(
                      counterStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                      label: Text(
                        " Email",
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      hintText: 'Enter Your Email',
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
                    validator: (value) {
                      if (value != null && value.contains("@gmail.com")) {
                        return null;
                      } else {
                        return 'Please enter your email address\nExample => (example@gmail.com)';
                      }
                    },
                  ),
                  const SizedBox(height: 30),
                  TextFormField(
                    controller: regPasswordC,
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
                      hintText: 'Enter Your Password',
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
                    validator: (value) {
                      RegExp regex = RegExp(r'^(?=.*?[a-z])(?=.*?[0-9]).{8,}$');
                      if (value != null && regex.hasMatch(value)) {
                        return null;
                      } else {
                        return 'Must be 8 or more characters  and contain at least 1\nnumber or special character';
                      }
                    },
                  ),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      Checkbox(
                        side: const BorderSide(
                          color: Color(0xffD9D9D9),
                          width: 1,
                          strokeAlign: 3,
                        ),
                        splashRadius: 10,
                        value: check,
                        onChanged: (bool? newValue) {
                          setState(() {
                            check = newValue!;
                          });
                        },
                        activeColor: const Color(0xff00B533),
                      ),
                      Expanded(
                        child: check
                            ? Text(
                                'Accept terms & Condition',
                                style: AppStyle.acceptTermsActive,
                              )
                            : Text(
                                'Accept terms & Condition',
                                style: AppStyle.acceptTerms,
                              ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff00B533),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      fixedSize: const Size(double.maxFinite, 60),
                    ),
                    onPressed: () async {
                      debugPrint("Salommmmmmmmm");
                      if (!globalKey.currentState!.validate()) return;
                      if (!check) {
                        Utils.fireSnackBar(
                            "You must agree to the terms and conditions",
                            context);
                        return;
                      }
                      isLoading = true;
                      setState(() {});
                      AuthModel authModel = AuthModel(
                        name: regNameC.text,
                        email: regEmailC.text,
                        password: regPasswordC.text,
                        id: 'id',
                      );
                      myauth.setConfig(
                        appEmail: authModel.email,
                        userEmail: authModel.email,
                        otpLength: 4,
                        otpType: OTPType.digitsOnly,
                        appName: "Email OTP",
                      );
                      if (await myauth.sendOTP() == true) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("OTP has been sent")));
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text("Oops, OTP send failed")));
                      }
                      if (!context.mounted) return;
                      context.go(
                          '${AppRouteName.login}/${AppRouteName.register}/${AppRouteName.otp}',
                          extra: authModel);
                    },
                    child: !isLoading
                        ? Text(
                            "Sign Up",
                            style: AppStyle.signIn,
                          )
                        : const Center(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeCap: StrokeCap.round,
                            ),
                          ),
                  ),
                  const SizedBox(height: 40),
                  Padding(
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.23),
                    child: Image.asset(
                      'assets/images/img_3.png',
                      width: MediaQuery.of(context).size.width * 0.4,
                    ),
                  ),
                  const SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Don’t have an account?', style: AppStyle.sendAgain),
                      TextButton(
                        onPressed: () {
                          context.go(AppRouteName.login);
                        },
                        child: Text('Sign in', style: AppStyle.second),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
