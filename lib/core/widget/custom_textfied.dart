import 'package:flutter/material.dart';
import '../app/app_colors.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  final String? hintText;
  final IconData icon;
  final bool obscureText;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final double? margin;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.labelText,
    this.hintText,
    required this.icon,
    this.obscureText = false,
    this.keyboardType,
    this.validator,
    this.margin,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool hide;

  @override
  void initState() {
    super.initState();
    hide = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: widget.margin ?? 5,
        left: widget.margin ?? 10,
        right: widget.margin ?? 10,
      ),
      child: TextFormField(
        controller: widget.controller,
        obscureText: hide,
        keyboardType: widget.keyboardType ?? TextInputType.text,
        validator: widget.validator,
        maxLines: hide ? 1 : null,
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: TextStyle(color: AppColor.primary.withValues(alpha: 0.5)),
          labelText: widget.labelText,
          labelStyle:TextStyle(color: AppColor.primary.withValues(alpha: 0.5)),
          prefixIcon: Icon(widget.icon, color: Colors.blueAccent),

          suffixIcon: widget.obscureText
              ? IconButton(
                  icon: Icon(
                    hide ? Icons.visibility_off : Icons.visibility,
                    color: AppColor.primary.withValues(alpha: 0.5),
                  ),
                  onPressed: () {
                    setState(() {
                      hide = !hide;
                    });
                  },
                )
              : null,

          filled: true,
          fillColor: const Color(0xFF0A1B3F),

          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Color.fromARGB(255, 9, 52, 145),
            ),
          ),

          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: AppColor.secondary,
              width: 2,
            ),
          ),
        ),
      ),
    );
  }
}