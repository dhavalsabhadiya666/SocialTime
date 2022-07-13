import 'package:flutter/material.dart';

class CustomButton extends StatefulWidget {
  Function()? onTap;
  double? height;
  double? width;
  Widget? image;
  bool? icon;
  String? text;
  Color? textColor;
  Color? color;
  EdgeInsets? padding;
  EdgeInsets? margin;
  String? fontFamily;
  double? fontSize;
  FontWeight? fontWeight;
  double? radius;
  Gradient? gradient;
  BoxBorder? border;

  CustomButton(
      {this.onTap,
      this.height,
      this.width,
      this.margin,
      this.text,
      this.padding,
      this.color,
      this.fontFamily,
      this.fontSize,
      this.fontWeight,
      this.icon,
      this.image,
      this.radius,
      this.textColor,
      this.gradient,
      this.border});

  @override
  _CustomButtonState createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: widget.onTap,
        child: Container(
          padding: widget.padding,
          margin: widget.margin,
          height: widget.height,
          width: widget.width,
          decoration: BoxDecoration(
              color: widget.color,
              borderRadius: BorderRadius.circular(widget.radius!),
              gradient: widget.gradient,
              border: widget.border),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              widget.icon == true ? widget.image! : Container(),
              const SizedBox(width: 10),
              Flexible(
                child: Text(
                  widget.text!,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: widget.textColor,
                      fontFamily: widget.fontFamily,
                      fontSize: widget.fontSize,
                      fontWeight: widget.fontWeight),
                ),
              )
            ],
          ),
        ));
  }
}
