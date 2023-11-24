import 'package:flutter/material.dart';

import '../utils/color_theme.dart';

class MyTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final TextInputType? inputType;
  final Function(String)? onChange;
  final int? maxLength;
  final bool? isObscure;
  final Widget? preffix;
  final Widget? suffix;
  final int? maxLines;
  final bool readOnly;
  final double? radius;
  final double? verticalPadding;
  final bool autofocus;
  final Function()? onTap;
  final Color? fillColor;
  final bool? filled;
  const MyTextField(
      {Key? key,
      required this.controller,
      required this.hintText,
      this.onChange,
      this.maxLength,
      this.isObscure = false,
      this.inputType,
      this.maxLines,
      this.suffix,
      this.preffix,
      this.radius,
      this.verticalPadding,
      this.onTap,
      this.autofocus = false,
      this.readOnly = false,
      this.fillColor,
      this.filled})
      : super(key: key);

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  bool obscure = false;

  @override
  void initState() {
    setState(() {
      obscure = widget.isObscure!;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLength: widget.maxLength,
      controller: widget.controller,
      obscureText: obscure,
      keyboardType: widget.inputType,
      onChanged: widget.onChange,
      maxLines: widget.isObscure == true ? 1 : widget.maxLines,
      readOnly: widget.readOnly,
      autofocus: widget.autofocus,
      style: const TextStyle(
          fontSize: 18, color: Colors.black, fontWeight: FontWeight.w400),
      decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: TextStyle(
              fontSize: 15,
              color: ColorTheme.hintText,
              fontWeight: FontWeight.w400),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(widget.radius ?? 6)),
            borderSide: const BorderSide(color: Colors.white, width: 0.5),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(widget.radius ?? 6)),
            borderSide: const BorderSide(color: Colors.white, width: 0.5),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(widget.radius ?? 6)),
            borderSide: const BorderSide(color: Colors.white, width: 0.5),
          ),
          fillColor: widget.fillColor,
          filled: widget.filled,
          isDense: true,
          contentPadding: EdgeInsets.symmetric(
              vertical: widget.verticalPadding ?? 15, horizontal: 15),
          prefixIcon: widget.preffix,
          prefixIconConstraints: const BoxConstraints(maxHeight: 20),
          suffixIcon: widget.isObscure == true
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      obscure = !obscure;
                    });
                  },
                  splashColor: Colors.transparent,
                  icon: obscure == true
                      ? const Icon(
                          Icons.visibility_rounded,
                          color: Colors.black54,
                          size: 22,
                        )
                      : const Icon(
                          Icons.visibility_off_rounded,
                          color: Colors.black54,
                          size: 22,
                        ))
              : widget.suffix),
      cursorColor: Colors.black,
      onTap: widget.onTap,
      onTapOutside: (event) {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      onSaved: (newValue) => widget.controller.text = newValue!,
    );
  }
}
