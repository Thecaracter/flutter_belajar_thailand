// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api

import 'package:flutter/material.dart';

enum InputFieldType { text, email, password, number }

class EnhancedInputField extends StatefulWidget {
  final String hint;
  final InputFieldType type;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;

  const EnhancedInputField({
    Key? key,
    required this.hint,
    this.type = InputFieldType.text,
    this.controller,
    this.onChanged,
  }) : super(key: key);

  @override
  _EnhancedInputFieldState createState() => _EnhancedInputFieldState();
}

class _EnhancedInputFieldState extends State<EnhancedInputField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white.withOpacity(0.5)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextField(
        controller: widget.controller,
        obscureText: widget.type == InputFieldType.password && _obscureText,
        keyboardType: _getKeyboardType(),
        style: TextStyle(color: Colors.white),
        onChanged: widget.onChanged,
        decoration: InputDecoration(
          hintText: widget.hint,
          hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          suffixIcon: widget.type == InputFieldType.password
              ? IconButton(
                  icon: Icon(
                    _obscureText ? Icons.visibility_off : Icons.visibility,
                    color: Colors.white.withOpacity(0.5),
                  ),
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                )
              : null,
        ),
      ),
    );
  }

  TextInputType _getKeyboardType() {
    switch (widget.type) {
      case InputFieldType.email:
        return TextInputType.emailAddress;
      case InputFieldType.number:
        return TextInputType.number;
      case InputFieldType.password:
      case InputFieldType.text:
      default:
        return TextInputType.text;
    }
  }
}

// Usage example
Widget buildInputFields() {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  return Column(
    children: [
      EnhancedInputField(
        hint: 'Email',
        type: InputFieldType.email,
        controller: emailController,
        onChanged: (value) {},
      ),
      SizedBox(height: 16),
      EnhancedInputField(
        hint: 'Password',
        type: InputFieldType.password,
        controller: passwordController,
        onChanged: (value) {
          // Handle password input
        },
      ),
    ],
  );
}
