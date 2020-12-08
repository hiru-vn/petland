import 'package:flutter/material.dart';
import 'package:petland/share/widgets/spacing_box.dart';

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            SpacingBox(h: 5),
          ],
        ),
      ),
    );
  }
}
