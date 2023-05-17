import 'dart:async';
import 'package:audio_visual_text/colors.dart';
import 'package:audio_visual_text/widgets/custom_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:text_to_speech/text_to_speech.dart';

class TextToSpeechPage extends StatefulWidget {
  const TextToSpeechPage({super.key});

  @override
  State<TextToSpeechPage> createState() => _TextToSpeechPageState();
}

class _TextToSpeechPageState extends State<TextToSpeechPage> {
  final TextToSpeech _tts = TextToSpeech();
  final TextEditingController _controller = TextEditingController();
  final ValueNotifier<bool> _isSpeak = ValueNotifier<bool>(false);
  late Timer _timer;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: beautifulGreen,
          systemOverlayStyle: SystemUiOverlayStyle.light
              .copyWith(statusBarColor: Colors.transparent),
          title: const Text('Text to speech'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  cursorColor: beautifulGreen,
                  controller: _controller,
                  minLines: 5,
                  maxLines: 20,
                  decoration: InputDecoration(
                    suffixIcon: ValueListenableBuilder(
                      valueListenable: _isSpeak,
                      builder: (context, value, child) => IconButton(
                        onPressed: () async {
                          if (_isSpeak.value) {
                            _tts.stop();
                            _timer.cancel();
                            _isSpeak.value = false;
                          } else {
                            _isSpeak.value = true;
                            await _tts.speak(_controller.text);
                            //I calculate the time by divide the number of words
                            //on the average words per minute which equal 150
                            //then i multiple the result in 60 so i get the speechTime
                            int speechTime =
                                ((_controller.text.split(' ').length / 150) *
                                        60)
                                    .round();
                            _timer = Timer(
                                Duration(
                                    seconds: (speechTime > 1) ? speechTime : 1),
                                () {
                              _isSpeak.value = false;
                            });
                          }
                        },
                        icon: Icon(
                          Icons.volume_up_rounded,
                          color: value ? beautifulGreen : Colors.grey,
                        ),
                      ),
                    ),
                    focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: beautifulGreen)),
                    border: const OutlineInputBorder(),
                    hintText: 'Enter some text here',
                  ),
                ),
                const SizedBox(height: 20),
                CustomSlider(
                    title: 'Volume',
                    max: 1,
                    min: 0,
                    onChanged: (double value) {
                      _tts.setVolume(value);
                    }),
                const SizedBox(height: 20),
                CustomSlider(
                  title: 'Rate',
                  max: 2,
                  min: 0,
                  onChanged: (double value) {
                    _tts.setRate(value);
                  },
                ),
                const SizedBox(height: 20),
                CustomSlider(
                    title: 'Pitch',
                    max: 2,
                    min: 0,
                    onChanged: (double value) {
                      _tts.setPitch(value);
                    }),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
