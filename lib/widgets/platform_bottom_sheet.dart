import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:kaskai/constants/ui_constants.dart';
import 'package:kaskai/widgets/platform_widget.dart';

class PlatformBottomSheet extends PlatformWidget {
  final List<Widget> content;

  const PlatformBottomSheet({
    super.key,
    required this.content,
  });
  // final bool? hasAppbar;

  Future show(BuildContext context) async {
    return Platform.isIOS
        ? await showCupertinoModalPopup(
            context: context,
            builder: (context) => this,
          )
        : await showModalBottomSheet(
            context: context,
            builder: (context) => this,
          );
  }

  @override
  Widget buildCupertinoWidget(BuildContext context) {
    return CupertinoPopupSurface(
      child: ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: content,
      ),
    );
  }

  @override
  Widget buildMaterialWidget(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
        borderRadius: Corners.lgBorder,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: EdgeInsets.symmetric(
                vertical: Sizes.sm, horizontal: Sizes.base),
            width: 70,
            height: 5,
            decoration: BoxDecoration(
                borderRadius: Corners.xlBorder,
                color: Theme.of(context).colorScheme.outline),
          ),
          ListView(
            shrinkWrap: true,
            children: content,
          ),
        ],
      ),
    );
  }
}

class PlatformBottomSheetAction extends PlatformWidget {
  const PlatformBottomSheetAction({
    super.key,
    required this.title,
    this.textStyle,
    required this.onPressed,
  });
  final String title;
  final TextStyle? textStyle;
  final VoidCallback onPressed;

  @override
  Widget buildCupertinoWidget(BuildContext context) {
    return CupertinoActionSheetAction(
      onPressed: onPressed,
      child: Text(
        title,
        style: textStyle,
      ),
    );
  }

  @override
  Widget buildMaterialWidget(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(
        title,
        style: textStyle,
      ),
    );
  }
}
