import 'package:flutter/material.dart';
import 'package:kaskai/constants/ui_constants.dart';

class FeatureTile extends StatelessWidget {
  final String icon, title, subtitle;
  const FeatureTile({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        borderRadius: Corners.medBorder,
        border: Border.all(color: theme.colorScheme.outline),
      ),
      padding: EdgeInsets.all(Sizes.sm),
      child: Column(
        children: [
          Row(
            children: [
              Text(icon),
              Spacing.horizontalSpacingSm,
              Text(
                title,
                style: theme.textTheme.titleLarge,
              )
            ],
          ),
          Spacing.verticalSpacingSm,
          Text(
            subtitle,
            style: theme.textTheme.bodyLarge!.copyWith(
              color: theme.colorScheme.outline,
              fontWeight: FontWeight.w400,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          )
        ],
      ),
    );
  }
}
