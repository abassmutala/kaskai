import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:kaskai/constants/ui_constants.dart';
import 'package:kaskai/widgets/typewriter_text.dart';
import 'package:lucide_icons/lucide_icons.dart';

class ChatMessage extends StatelessWidget {
  const ChatMessage({super.key, required this.sender, required this.message, required this.isNewMessage});
  final String sender;
  final Map<String, dynamic> message;
  final bool isNewMessage;

  @override
  Widget build(BuildContext context) {
    var desktop = ScreenSize.width >= 1024;
    final ThemeData theme = Theme.of(context);

    var userMessage = sender == "user";
    final alignment =
        userMessage ? Alignment.centerRight : Alignment.center;
    final margin = userMessage
        ? EdgeInsets.only(left: desktop ? 56.0 : Sizes.xl)
        : EdgeInsets.zero;
    final bgColor =
        userMessage ? theme.colorScheme.primary : Colors.transparent;
    final color = userMessage ? Colors.white : Colors.black;

    return Container(
      margin: margin,
      alignment: alignment,
      child: Container(
        padding:
            EdgeInsets.symmetric(vertical: Sizes.med, horizontal: Sizes.base),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: Corners.medBorder,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            
            isNewMessage ? TypewriterText(
                text: message["message"]!,
                textStyle: theme.textTheme.bodyMedium!.copyWith(
                  color: color,
                ),
                duration: const Duration(milliseconds: 50),
              ): MarkdownBody(
              data: message["message"]!,
              selectable: true,
              styleSheet: MarkdownStyleSheet(
                code: const TextStyle(fontFamily: "Lilex"),
                p: theme.textTheme.bodyMedium!.copyWith(
                  color: color,
                ),
              ),
            ),
            if (!userMessage)
              Column(
                children: [
                  Spacing.verticalSpacingMed,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(
                        onPressed: () {
                          Clipboard.setData(
                            ClipboardData(text: message["message"]),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Copied to clipboard"),
                            ),
                          );
                        },
                        tooltip: "Copy",
                        icon: Icon(
                          LucideIcons.copy,
                          size: Sizes.med,
                        ),
                      )
                    ],
                  ),
                ],
              )
          ],
        ),
      ),
    );
  }
}
