import 'package:flutter/material.dart';
import 'package:kaskai/constants/ui_constants.dart';

class InputField extends StatefulWidget {
  const InputField({
    super.key,
    required this.controller,
    required this.hintText,
    this.focusNode,
    this.prefixIcon,
    this.suffixIcon,
    this.isLoading = false,
    this.onFieldSubmitted,
  });
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool? isLoading;
  final ValueChanged<String>? onFieldSubmitted;

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return TextFormField(
      enabled: !widget.isLoading!,
      controller: widget.controller,
      focusNode: widget.focusNode,
      style: theme.textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.normal,),
      decoration: InputDecoration(
        filled: true,
        isDense: true,
        // isCollapsed: true,
        // contentPadding: EdgeInsets.symmetric(),
        hintText: widget.hintText,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: Corners.medBorder,
        ),
        prefixIcon: widget.prefixIcon,
        suffixIcon: widget.suffixIcon,
        // constraints: BoxConstraints()
      ),
      // textInputAction: TextInputAction.newline,
      maxLines: null,
      keyboardType: TextInputType.text,
      onFieldSubmitted: widget.onFieldSubmitted,
    );
  }
}
