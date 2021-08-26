import 'package:flutter/material.dart';
import '../common_widgets/custom_text.dart';

class NoConnectionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.wifi_off_rounded,
              size: 200,
              color: Colors.grey[300],
            ),
            SizedBox(height: 50),
            CustomText(
                text: 'لا يوجد اتصال بالانترنت',
                size: 22,
                color: Colors.grey,
                weight: FontWeight.bold),
            // SizedBox(height:15),
            // CustomText(
            //     color: Colors.grey,
            //     text: 'TRY TO RECONNECT', size: 20, weight: FontWeight.bold),
          ],
        ),
      ),
    );
  }
}
