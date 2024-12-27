import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:app_quiz/core/routes/approutesname.dart';
import 'package:app_quiz/core/services/auth_ser.dart';
import 'package:app_quiz/core/widgets/app_colors.dart';
import 'package:app_quiz/core/widgets/app_style.dart';
import 'package:app_quiz/data/models/auth_model.dart';
import 'package:app_quiz/pages/sign/register_page.dart';
import 'package:app_quiz/setup.dart';

class VerifyAccount extends StatefulWidget {
  final AuthModel authModel;
  const VerifyAccount({super.key, required this.authModel});

  @override
  State<VerifyAccount> createState() => _VerifyAccountState();
}

class _VerifyAccountState extends State<VerifyAccount> {
  TextEditingController otp = TextEditingController();
  bool isSnackBarShown = false;
  bool isDialogShown = false;

  final List<String> buttons = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '←',
    '0',
    '✖️'
  ];

  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        Future.delayed(const Duration(microseconds: 1), () {
          _focusNode.unfocus();
        });
      }
    });
  }

  @override
  void dispose() {
    otp.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void onButtonPressed(String buttonText) {
    setState(() {
      if (buttonText == '←') {
        if (otp.text.isNotEmpty) {
          otp.text = otp.text.substring(0, otp.text.length - 1);
        }
      } else if (buttonText == '✖️') {
        otp.clear();
      } else if (otp.text.length < 4) {
        otp.text += buttonText;
      }
    });
    print('Button pressed: $buttonText');
  }

  Future<void> verifyOTPAndRegister(String otpValue) async {
    bool isOTPCorrect = await myauth.verifyOTP(otp: otpValue);
    if (isOTPCorrect) {
      User? user = await AuthService.registerUser(context, widget.authModel);
      if (user != null) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("OTP is verified")));
        if (!context.mounted) return;
        context.go('${AppRouteName.menu}');
        await box.put('email', widget.authModel.email);
        await box.put('register', 'register');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("User registration failed")));
      }
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Invalid OTP")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 85),
            child: Image.asset(
              'assets/images/img.png',
              width: 205,
              height: 65,
            ),
          ),
          const SizedBox(height: 60),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 55),
            child: PinCodeTextField(
              focusNode: _focusNode,
              controller: otp,
              obscureText: true,
              keyboardType: TextInputType.none,
              appContext: context,
              length: 4,
              cursorHeight: 90,
              textStyle: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.normal,
              ),
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              pinTheme: PinTheme(
                activeColor: Colors.green,
                shape: PinCodeFieldShape.box,
                borderWidth: 10,
                fieldWidth: 53,
                fieldHeight: 70,
                inactiveColor: AppColors.c_D9D9D9,
                borderRadius: BorderRadius.circular(12),
              ),
              onChanged: (value) async {
                if (value.length == 4) {
                  await verifyOTPAndRegister(value);
                }
              },
            ),
          ),
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 99),
            child: Row(
              children: [
                Text(
                  'Send again after',
                  style: AppStyle.sendAgain,
                ),
                Text(
                  '( 59 seconds )',
                  style: AppStyle.second,
                ),
              ],
            ),
          ),
          const SizedBox(height: 124),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.4,
            width: MediaQuery.of(context).size.width * 0.85,
            child: GridView.builder(
              itemCount: buttons.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: MediaQuery.of(context).size.width /
                    (MediaQuery.of(context).size.height / 4),
                crossAxisCount: 3,
                crossAxisSpacing: 18,
                mainAxisSpacing: 20,
              ),
              itemBuilder: (context, index) {
                return ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.c_D9D9D9,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    onButtonPressed(buttons[index]);
                  },
                  child: Text(
                    buttons[index],
                    style: AppStyle.numberCall,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
