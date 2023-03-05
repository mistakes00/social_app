import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    required this.buttonText,
    this.textColor,
    this.buttonColor,
    required this.ontap,
    this.borderColor,
  }) : super(key: key);
  final String buttonText;
  final Color? textColor;
  final Color? buttonColor;
  final Color? borderColor;
  final Function() ontap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: borderColor ?? Colors.black, width: 2),
          color: buttonColor ?? Colors.white,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 19, bottom: 18),
          child: Center(
            child: Text(
              buttonText,
              style: TextStyle(
                color: textColor ?? Colors.black,
                fontSize: 13,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
