import 'package:flutter/material.dart';

class ProductInfoTile extends StatelessWidget {
  final String title;
  final String info;
  final Color color;

  const ProductInfoTile({
    @required this.title,
    @required this.info,
    this.color = Colors.grey,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListTile(
        title: Text(title),
        trailing: Text(info, style: TextStyle(color: color)),
      ),
    );
  }
}
