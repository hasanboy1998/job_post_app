import 'package:flutter/foundation.dart' show kIsWeb;

import 'package:flutter/material.dart';

class ResponsiveWrapper extends StatelessWidget {
  final Widget child;
  final double maxWidth;
  final bool withPadding;

  const ResponsiveWrapper({
    super.key,
    required this.child,
    this.maxWidth = 1200,
    this.withPadding = true,
  });

  @override
  Widget build(BuildContext context) {
    if (!kIsWeb) {
      return child;
    }

    return Center(
      child: Container(
        constraints: BoxConstraints(maxWidth: maxWidth),
        padding: withPadding
            ? const EdgeInsets.symmetric(horizontal: 24)
            : null,
        child: child,
      ),
    );
  }
}

class Responsive {
  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 768;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width >= 768 &&
      MediaQuery.of(context).size.width < 1024;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 768;
}
