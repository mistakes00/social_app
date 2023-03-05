import 'dart:ffi';

import 'package:flutter/material.dart';

class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField({
    Key? key,
    this.onChanged,
    this.hintText,
    this.controller,
    this.validator,
    this.unVisibly,
  }) : super(key: key);
  final Function(String)? onChanged;
  final String? hintText;
  final TextEditingController? controller;
  final String? Function(String? value)? validator;
  final bool? unVisibly;

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  @override
  void initState() {
    if (widget.unVisibly == false) {
      setState(() {
        obscure = true;
      });
    }
    super.initState();
  }

  bool obscure = false;
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      TextFormField(
        style: const TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 15,
          color: Color(0xFF000000),
        ),
        onChanged: widget.onChanged,
        controller: widget.controller,
        validator: widget.validator,
        obscureText: obscure,
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: const TextStyle(
            color: Color(0xFFA1A1A1),
          ),

          // hintStyle: TextStyles.mainText.copyWith(fontSize: 14),
        ),
      ),
      widget.unVisibly != true
          ? Positioned(
              top: 5,
              right: 10,
              child: IconButton(
                onPressed: () {
                  setState(() {
                    obscure = !obscure;
                  });
                },
                icon: Icon(
                  obscure
                      ? Icons.remove_red_eye_outlined
                      : Icons.remove_red_eye,
                  color: Colors.black,
                ),
              ),
            )
          : const SizedBox(),
    ]);
  }
}
