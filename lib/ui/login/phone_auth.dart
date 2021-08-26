import 'dart:async';
import 'package:flutter/material.dart';
import '../../common_widgets/common_button.dart';
import '../../common_widgets/corners.dart';
import '../../common_widgets/custom_text.dart';
import '../../services/api_calls/phone_auth_services.dart';

class PhoneAuthScreen extends StatefulWidget {
  static const String id = 'phone_auth';
  final String verId;
  final String phone;

  PhoneAuthScreen({this.verId, this.phone});

  @override
  _PhoneAuthScreenState createState() => _PhoneAuthScreenState();
}

class _PhoneAuthScreenState extends State<PhoneAuthScreen> {
  TextEditingController smsOTPController = TextEditingController();
  PhoneAuthServices _auth = PhoneAuthServices.instance;
  String verId;

  Timer _timer;
  bool isTimeUp = false;
  bool timerStarted = false;
  int secCounter = 20;

  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        timerStarted = true;
        secCounter--;
        if (secCounter <= 0) {
          timerStarted = false;
          secCounter = 20;
          _timer.cancel();
        }
      });
    });
  }

  @override
  void initState() {
    startTimer();
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    smsOTPController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          centerTitle: true,
          title: CustomText(
            text: "Phone Verification",
            size: 20,
            color: Colors.black,
          ),
          backgroundColor: Colors.white,
        ),
        backgroundColor: Colors.white,
        body: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            SizedBox(height: 15),
            Text(
              "Verify Your Phone Number",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),
            SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.only(left: 12, right: 12, bottom: 12),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.black, width: 0.2),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        offset: Offset(2, 1),
                        blurRadius: 2,
                      )
                    ]),
                child: Padding(
                  padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                  child: TextField(
                    keyboardType: TextInputType.number,
                    controller: smsOTPController,
                    obscureText: true,
                    decoration: InputDecoration(
                      icon: Icon(Icons.security),
                      hintText: "Enter code",
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 18),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Center(
              child: CommonButton(
                containerColor: Colors.indigoAccent,
                height: 45,
                width: 300,
                text: "Verify SMS",
                onTap: () {
                  print(
                      'vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv=>${widget.verId}');
                  print(
                      'text                       =>${smsOTPController.text}');
                  _auth.signInWithPhone(
                      smsOTP: smsOTPController.text,
                      verId: verId!=null?verId: widget.verId,
                    phone: widget.phone,
                  );
                },
                corners: Corners(30, 30, 30, 30),
              ),
            ),
            SizedBox(height: 10),
            CommonButton(
              containerColor: Colors.blueAccent,
              height: 45,
              width: 300,
              text: !timerStarted
                  ? "Resend Code "
                  : "Resend after :  $secCounter",
              onTap: !timerStarted
                  ? () async {
                      startTimer();
                      final _verId = await _auth.verifyPhoneNumber(
                        number: widget.phone,
                      );

                      setState(() {
                        verId = _verId;
                      });
                    }
                  : () {},
              corners: Corners(30, 30, 30, 30),
            ),
          ],
        ),
      ),
    );
  }
}
