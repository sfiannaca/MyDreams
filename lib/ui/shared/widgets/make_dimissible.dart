import 'package:flutter/material.dart';

class MakeDimissible extends StatelessWidget {
  const MakeDimissible({
    super.key,
    required this.context,
    required this.child,
  });

  final BuildContext context;
  final Widget child;

  @override
  Widget build(BuildContext context) => GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => Navigator.of(context).pop(),
        child: GestureDetector(
          onTap: (() {}),
          child: child,
        ),
      );
}
