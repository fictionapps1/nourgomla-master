import 'package:flutter/material.dart';

class AccountWidget extends StatelessWidget {
  final double cardElevation;
  final String accountItemImageUrl;
  final String accountItemText;
  final Function onPressed;
  final IconData icon;

  const AccountWidget(
      {this.cardElevation = 1,
      this.accountItemImageUrl,
      this.accountItemText,
      this.onPressed, this.icon});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: 50,
        child: Card(
          elevation: cardElevation,
          child: Row(
            children: [
              const SizedBox(width: 10),
              Icon(icon??Icons.info_outline,size: 28,),
              const SizedBox(width: 20),
              Text(accountItemText),
            ],
          ),
        ),
      ),
      // ),
    );
  }
}
