import 'package:flutter/material.dart';
import '../../../common_widgets/custom_text.dart';
import '../../../responsive_setup/responsive_builder.dart';

class BonusWidget extends StatefulWidget {
  final String title;
  final String buttonText;
  final String pointsInfo;
  final String hint;
  final Function(String) onButtonTapped;

  BonusWidget(
      {this.title,
      this.buttonText,
      this.hint,
      this.onButtonTapped,
      this.pointsInfo});

  @override
  _BonusWidgetState createState() => _BonusWidgetState();
}

class _BonusWidgetState extends State<BonusWidget> {
  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(builder: (context, sizingInfo) {
      return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), color: Colors.grey[200]),
        child: Column(
          children: [
            Container(
              height: 40,
              width: sizingInfo.screenWidth,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      topLeft: Radius.circular(20)),
                  color: Colors.grey[400]),
              child: Center(
                child: CustomText(
                  text: widget.title,
                  weight: FontWeight.w500,
                  size: 18,
                ),
              ),
            ),
            if (widget.pointsInfo != null)
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, top: 20),
                child: CustomText(
                  text: widget.pointsInfo,
                  weight: FontWeight.w400,
                  size: 16,
                ),
              ),
            widget.pointsInfo != null
                ? Padding(
                    padding: const EdgeInsets.only(
                        left: 10, right: 10, top: 20, bottom: 20),
                    child: CustomText(
                      text: widget.hint,
                      weight: FontWeight.w400,
                      color: Colors.green[500],
                      size: 16,
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 20),
                    child: TextField(
                      controller: _textController,

                      decoration: InputDecoration(
                        hintText: widget.hint,
                        contentPadding: EdgeInsets.only(left: 10, top: 12,right: 10),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                            width: 1,
                            color: Colors.greenAccent,
                            style: BorderStyle.none,
                          ),
                        ),
                      ),
                    ),
                  ),
            InkWell(
              onTap: () {
                widget.onButtonTapped(_textController.text);
              },
              child: Container(
                height: 40,
                width: sizingInfo.screenWidth,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(20),
                        bottomLeft: Radius.circular(20)),
                    color: Colors.green[200]),
                child: Center(
                  child: CustomText(
                    text: widget.buttonText,
                    weight: FontWeight.w500,
                    size: 18,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}

class NotesWidget extends StatelessWidget {
  final String title;
  final TextEditingController textController;
  final String hint;

  NotesWidget({
    this.title,
    this.hint,
    this.textController,
  });

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(builder: (context, sizingInfo) {
      return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), color: Colors.grey[200]),
        child: Column(
          children: [
            Container(
              height: 40,
              width: sizingInfo.screenWidth,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      topLeft: Radius.circular(20)),
                  color: Colors.grey[400]),
              child: Center(
                child: CustomText(
                  text: title,
                  weight: FontWeight.w500,
                  size: 18,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: TextField(
                controller: textController,
                decoration: InputDecoration(
                  hintText: hint,
                  contentPadding: EdgeInsets.only(left: 10, top: 12,right: 10),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      width: 1,
                      color: Colors.greenAccent,
                      style: BorderStyle.none,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
