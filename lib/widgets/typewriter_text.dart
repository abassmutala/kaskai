import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class TypewriterText extends StatefulWidget {
  final String text;
  final TextStyle? textStyle;
  final Duration duration;
  const TypewriterText({
    super.key,
    required this.text,
    this.textStyle,
    this.duration = const Duration(milliseconds: 100),
  });

  @override
  State<TypewriterText> createState() => _TypewriterTextState();
}

class _TypewriterTextState extends State<TypewriterText>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<int> _charCount;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(
          milliseconds: widget.text.length * widget.duration.inMilliseconds),
      vsync: this,
    );

    _charCount =
        StepTween(begin: 0, end: widget.text.length).animate(_controller)
          ..addListener(() {
            setState(() {});
          });

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    String currentText = widget.text.substring(0, _charCount.value.clamp(0, widget.text.length));
    return MarkdownBody(
      data: currentText,
      selectable: true,
      styleSheet: MarkdownStyleSheet(
        code: const TextStyle(fontFamily: "Lilex"),
        p: theme.textTheme.bodyMedium!.copyWith(
          color: widget.textStyle?.color,
        ),
      ),
    );
    // return Text(currentText, style: widget.textStyle);
  }
}
