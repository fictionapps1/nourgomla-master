import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final String label;
  final bool autoFocus;
  final bool hasLabel;
  final bool isPassword;
  final String initVal;
  final Function(String val) onSaved;
  final Function(String val) onChanged;
  final Function(String val) validator;
  final TextInputType keyboardType;
  final int maxLines;
  final EdgeInsets contentPadding;

  const CustomTextField({
    @required this.label,
    this.autoFocus = false,
    this.initVal,
    this.isPassword = false,
    this.onSaved,
    this.validator,
    this.keyboardType,
    this.maxLines,
    this.hasLabel = true,
    this.contentPadding,
    this.onChanged,
  });

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool hidePassword = true;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        onSaved: widget.onSaved,
        onChanged: widget.onChanged,
        initialValue: widget.initVal,
        textAlign: TextAlign.center,
        textCapitalization: TextCapitalization.words,
        autofocus: widget.autoFocus,
        obscureText: hidePassword && widget.isPassword,
        validator: widget.validator,
        keyboardType: widget.keyboardType ?? TextInputType.text,
        maxLines: widget.maxLines ?? 1,
        decoration: InputDecoration(
            isDense: true,
            hintText: widget.label,
            labelText: widget.hasLabel ? widget.label : null,
            alignLabelWithHint: true,
            contentPadding: widget.contentPadding ?? EdgeInsets.all(15),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            icon: widget.isPassword
                ? IconButton(
                    padding: EdgeInsets.all(0),
                    icon: Icon(
                        hidePassword ? Icons.visibility_off : Icons.visibility),
                    onPressed: () {
                      setState(() {
                        hidePassword = !hidePassword;
                      });
                      print('Tapped');
                    },
                  )
                : null),
      ),
    );
  }
}
