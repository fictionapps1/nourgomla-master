import 'package:flutter/material.dart';

class DismissibleWidget extends StatelessWidget {
  /// The string Key (id) of product to use dismissable
  final String dismissableKey;

  /// A function to be triggered when a card is pressed
  final Function onDismissedPressed;

  final Widget child;

  const DismissibleWidget({
    @required this.dismissableKey,
    @required this.onDismissedPressed,
    @required this.child,
  });
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(dismissableKey),
      confirmDismiss: onDismissedPressed,
      direction: DismissDirection.endToStart,
      background: Container(
        padding: EdgeInsets.all(8),
        alignment: Alignment.centerRight,
        color: Colors.red,
        child: Icon(Icons.delete_forever, color: Colors.white, size: 55),
      ),
      child: child,
    );
  }
}
