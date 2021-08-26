import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SpinWidget extends StatefulWidget {
  final int value;
  final int min;
  final int max;
  final int stock;
  final int step;
  final double iconSize;
  final Icon subtractIcon;
  final Icon addIcon;
  final EdgeInsetsGeometry iconPadding;
  final TextStyle textStyle;
  final Color iconActiveColor;
  final Color iconDisabledColor;
  final bool enabled;
  final ValueChanged<int> onChanged;
  final String packageType;

  const SpinWidget({
    this.value,
    this.min = 1,
    this.max = 9999,
    this.step = 1,
    this.iconSize = 24.0,
    this.subtractIcon = const Icon(Icons.remove),
    this.addIcon = const Icon(Icons.add),
    this.iconPadding = const EdgeInsets.all(4.0),
    this.textStyle = const TextStyle(fontSize: 24),
    this.iconActiveColor,
    this.iconDisabledColor,
    this.enabled = true,
    @required this.onChanged,
    this.packageType = '',
    this.stock = 900,
  });

  @override
  _SpinWidgetState createState() => _SpinWidgetState();
}

class _SpinWidgetState extends State<SpinWidget> {
  num _value;
  int minValue = 0;

  bool get minusBtnDisabled =>
  _value<=widget.min||_value==1|| _value <= minValue || _value - widget.step < minValue || !widget.enabled;

  bool get addBtnDisabled =>
      _value >= widget.stock ||
      _value >= widget.max ||
      _value + widget.step > widget.max ||
      !widget.enabled;


  @override
  void initState() {
    super.initState();

    _value =  widget.value;
    print("MIN ${widget.min}");
    print("MAX ${widget.max}");
    print("STOCK ${widget.stock}");
    print("STEP ${widget.step}");
    print("=====================");

  }

  @override
  void didUpdateWidget(covariant SpinWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != oldWidget.value) {
      setState(() => _value = widget.value);
    }
  }

  Color _spinButtonColor(bool btnDisabled) => btnDisabled
      ? widget.iconDisabledColor ?? Theme.of(context).disabledColor
      : widget.iconActiveColor ?? Theme.of(context).textTheme.button?.color;

  void _adjustValue(num adjustment) {
    if (_value == 0) {
      setState(() {
        _value =widget.stock<widget.min?_value+widget.stock: _value + widget.min;
        minValue = widget.stock<widget.min?widget.stock:widget.min;
      });
    } else {
      setState(() {
        _value = _value + adjustment;
      });
    }
    widget.onChanged(_value);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,

      children: <Widget>[
        IconButton(
          padding: widget.iconPadding,
          iconSize: widget.iconSize,
          color: _spinButtonColor(minusBtnDisabled),
          icon: widget.subtractIcon,
          onPressed: () {
            if (!minusBtnDisabled) {
              _adjustValue(-widget.step);
            }
          },
        ),
        Text(
          _value.toString(),
          style: widget.textStyle,
        ),
        Text(
          widget.packageType,
          style: TextStyle(fontSize: 11),
        ),
        IconButton(
          padding: widget.iconPadding,
          iconSize: widget.iconSize,
          color: _spinButtonColor(addBtnDisabled),
          icon: widget.addIcon,
          onPressed: () {
            if (!addBtnDisabled) {
              _adjustValue(widget.step);
            }

          },
        ),
      ],
    );
  }
}
