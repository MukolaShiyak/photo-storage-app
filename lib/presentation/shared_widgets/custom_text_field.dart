import 'package:flutter/material.dart';

typedef ValidationCallback = String? Function(String?)?;

class CustomTextField extends StatefulWidget {
  final ValidationCallback validator;
  final String? label;
  final TextInputAction? fieldAction;
  final TextEditingController? controller;
  final TextInputType? textInputType;
  final bool? obscureText;
  final int? maxLines;
  const CustomTextField({
    Key? key,
    this.validator,
    this.label,
    this.fieldAction,
    this.controller,
    this.textInputType,
    this.obscureText,
    this.maxLines,
  }) : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  var _isObscure = false;
  @override
  void initState() {
    super.initState();
    if (widget.obscureText != null) {
      _isObscure = widget.obscureText!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      textInputAction: widget.fieldAction,
      keyboardType: widget.textInputType,
      validator: widget.validator,
      decoration: InputDecoration(
        labelText: widget.label,
        suffixIcon: widget.obscureText != null
            ? GestureDetector(
                onTap: () {
                  setState(() => _isObscure = !_isObscure);
                },
                child: Padding(
                  padding: const EdgeInsets.only(
                    right: 20,
                    left: 10,
                    top: 13,
                  ),
                  child: Image.asset(
                    !_isObscure
                        ? 'assets/icons/eye.png'
                        : 'assets/icons/eye-off.png',
                    height: 12,
                  ),
                ),
              )
            : null,
      ),
      maxLines: widget.maxLines,
      obscureText: _isObscure,
    );
  }
}
