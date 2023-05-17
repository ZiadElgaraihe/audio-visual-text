import 'package:audio_visual_text/colors.dart';
import 'package:audio_visual_text/pages/image_text_page.dart';
import 'package:audio_visual_text/pages/speech_to_text_page.dart';
import 'package:audio_visual_text/pages/text_to_speech_page.dart';
import 'package:flutter/material.dart';

class NavBarDesign extends StatefulWidget {
  const NavBarDesign({super.key});

  @override
  State<NavBarDesign> createState() => _NavBarDesignState();
}

class _NavBarDesignState extends State<NavBarDesign> {
  final ValueNotifier<int> _currentIndex = ValueNotifier<int>(0);
  List<Widget> listOfPages = [
    const TextToSpeechPage(),
    const SpeechToTextPage(),
    const ImageTextPage(),
  ];
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _currentIndex,
      builder: (context, value, child) => Scaffold(
        bottomNavigationBar: SizedBox(
          height: 100,
          child: BottomNavigationBar(
              onTap: (value) => _currentIndex.value = value,
              currentIndex: value,
              selectedItemColor: beautifulGreen,
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(Icons.volume_up_rounded), label: ''),
                BottomNavigationBarItem(
                    icon: Icon(Icons.mic_rounded), label: ''),
                BottomNavigationBarItem(
                    icon: Icon(Icons.image_rounded), label: ''),
              ]),
        ),
        body: listOfPages.elementAt(value),
      ),
    );
  }
}
