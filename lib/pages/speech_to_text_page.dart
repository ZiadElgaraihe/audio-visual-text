import 'package:audio_visual_text/colors.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:speech_to_text/speech_to_text.dart';

class SpeechToTextPage extends StatefulWidget {
  const SpeechToTextPage({super.key});

  @override
  State<SpeechToTextPage> createState() => _SpeechToTextPageState();
}

class _SpeechToTextPageState extends State<SpeechToTextPage> {
  bool _isListening = false;
  String _text = 'Hold the button and start speaking';
  final SpeechToText _speechToText = SpeechToText();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: beautifulGreen,
        systemOverlayStyle: SystemUiOverlayStyle.light
            .copyWith(statusBarColor: Colors.transparent),
        title: const Text('Speech to text'),
        centerTitle: true,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: AvatarGlow(
        endRadius: 75,
        animate: _isListening,
        duration: const Duration(milliseconds: 2000),
        repeat: true,
        repeatPauseDuration: const Duration(milliseconds: 100),
        showTwoGlows: true,
        glowColor: beautifulGreen,
        child: GestureDetector(
          onTapDown: (details) async {
            if (!_isListening) {
              var avaliable = await _speechToText.initialize();
              if (avaliable) {
                setState(() {
                  _isListening = true;
                });
                _speechToText.listen(
                  onResult: (result) {
                    setState(() {
                      _text = result.recognizedWords;
                    });
                  },
                  localeId: 'en_US',
                );
              }
            }
          },
          onTapUp: (details) async {
            setState(() {
              _isListening = false;
            });
            await _speechToText.stop();
          },
          child: CircleAvatar(
            radius: 40,
            backgroundColor: beautifulGreen,
            child: Icon(
              _isListening ? Icons.mic_rounded : Icons.mic_none_rounded,
              size: 35,
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        margin: const EdgeInsets.only(bottom: 150),
        height: MediaQuery.of(context).size.height * 0.7,
        width: MediaQuery.of(context).size.width,
        child: Text(_text,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w600)),
      ),
    );
  }
}
