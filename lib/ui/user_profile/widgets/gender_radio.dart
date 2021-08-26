import 'package:flutter/material.dart';
class RadioButtonModel {
  String name;
  int genderNum;
  IconData icon;
  bool isSelected;

  RadioButtonModel(this.name, this.icon, this.isSelected,this.genderNum);
}

class RadioButtonWithIcon extends StatelessWidget {
  final RadioButtonModel _gender;

  RadioButtonWithIcon(this._gender);

  @override
  Widget build(BuildContext context) {
    return Card(
        color: _gender.isSelected ? Color(0xFF3B4257) : Colors.white,
        child: Container(
          height: 80,
          width: 80,
          alignment: Alignment.center,
          margin: EdgeInsets.all(5.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Icon(
                _gender.icon,
                color: _gender.isSelected ? Colors.white : Colors.grey,
                size: 32,
              ),
              SizedBox(height: 5),
              Text(
                _gender.name,
                style: TextStyle(
                    color: _gender.isSelected ? Colors.white : Colors.grey),
              )
            ],
          ),
        ));
  }
}
