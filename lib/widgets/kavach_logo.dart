import 'package:flutter/material.dart';

class KavachLogo extends StatelessWidget {
  final double size;
  final EdgeInsets padding;

  const KavachLogo({
    super.key,
    this.size = 200,
    this.padding = const EdgeInsets.all(16),
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Image.asset(
        'assets/images/kavach_logo.png',
        width: size,
        height: size,
        fit: BoxFit.contain,
      ),
    );
  }
}
