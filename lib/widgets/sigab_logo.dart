import 'package:flutter/material.dart';

class SigabLogo extends StatelessWidget {
  final double size;

  const SigabLogo({
    Key? key,
    this.size = 120,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: size,
          height: size,
          child: Image.asset(
            'assets/img/sigab_logo.png',
            fit: BoxFit.contain,
          ),
        ),
      ],
    );
  }
} 