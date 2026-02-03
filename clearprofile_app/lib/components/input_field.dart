import 'package:flutter/material.dart';
import '../theme.dart';

class InputField extends StatefulWidget {
  final String hintText;
  final TextEditingController? controller;
  final bool isPassword;
  final IconData? suffixIcon;
  final bool animateSuffix;

  const InputField({
    super.key,
    required this.hintText,
    this.controller,
    this.isPassword = false,
    this.suffixIcon,
    this.animateSuffix = false,
  });

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      obscureText: widget.isPassword ? _obscureText : false,
      style: context.textStyles.bodyLarge,
      decoration: InputDecoration(
        hintText: widget.hintText,
        suffixIcon: widget.isPassword
            ? GestureDetector(
                onTap: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: !_obscureText
                          ? [
                              BoxShadow(
                                color: AppColors.accent.withOpacity(0.5),
                                blurRadius: 10,
                                spreadRadius: 2,
                              )
                            ]
                          : [],
                    ),
                    child: Icon(
                      Icons.fingerprint,
                      color: !_obscureText ? AppColors.accent : AppColors.onSurfaceVariant,
                    ),
                  ),
                ),
              )
            : widget.suffixIcon != null
                ? Icon(
                    widget.suffixIcon,
                    color: AppColors.onSurfaceVariant,
                  )
                : null,
      ),
    );
  }
}
