import 'package:audio_visual_text/widgets/nav_bar_design.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const AudioVisualText());
}

class AudioVisualText extends StatelessWidget {
  const AudioVisualText({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Audio Visual Text',
      debugShowCheckedModeBanner: false,
      home: NavBarDesign(),
    );
  }
}
