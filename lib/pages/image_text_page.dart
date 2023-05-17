import 'dart:io';
import 'package:audio_visual_text/colors.dart';
import 'package:audio_visual_text/pages/camera_page.dart';
import 'package:audio_visual_text/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';
import 'package:text_to_speech/text_to_speech.dart';

class ImageTextPage extends StatefulWidget {
  const ImageTextPage({super.key});

  @override
  State<ImageTextPage> createState() => _ImageTextPageState();
}

class _ImageTextPageState extends State<ImageTextPage> {
  ValueNotifier<File?> imageFile = ValueNotifier<File?>(null);
  TextToSpeech tts = TextToSpeech();

  Future<void> getImage(ImageSource imageSource) async {
    try {
      ImagePicker picker = ImagePicker();
      XFile? image = await picker.pickImage(
          source: imageSource, maxWidth: 480, maxHeight: 600);
      if (image != null) {
        imageFile.value = File(image.path);
      }
    } catch (e) {
      debugPrint('$e');
    }
  }

  Future<void> textRecognition(File img) async {
    try {
      final textRecognizer =
          TextRecognizer(script: TextRecognitionScript.latin);
      final inputImage = InputImage.fromFilePath(img.path);
      final RecognizedText recognizedText =
          await textRecognizer.processImage(inputImage);
      await textRecognizer.close();
      await tts.setLanguage('en-US');
      await tts.speak(recognizedText.text.split('\n').join(' '));
      debugPrint(recognizedText.text.split('\n').join(' '));
      debugPrint('==========================================');
    } catch (e) {
      debugPrint('$e');
      debugPrint('==========================================');
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Some thing went wrong')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: beautifulGreen,
        systemOverlayStyle: SystemUiOverlayStyle.light
            .copyWith(statusBarColor: Colors.transparent),
        title: const Text('Image Text'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ValueListenableBuilder(
              valueListenable: imageFile,
              builder: (context, value, child) => Container(
                width: MediaQuery.of(context).size.width / 1.5,
                height: MediaQuery.of(context).size.height / 3,
                decoration: BoxDecoration(
                  image: value != null
                      ? DecorationImage(
                          image: FileImage(
                            value,
                          ),
                          fit: BoxFit.fill,
                        )
                      : null,
                  color: Colors.grey.shade400,
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height / 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomElevatedButton(
                  title: 'Gallery',
                  icon: Icons.image_rounded,
                  onPressed: () async {
                    await getImage(ImageSource.gallery);
                    if (imageFile.value != null) {
                      textRecognition(imageFile.value!);
                    }
                  },
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 8,
                ),
                CustomElevatedButton(
                  title: 'Camera',
                  icon: Icons.camera_rounded,
                  onPressed: () async {
                    imageFile.value = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CameraPage(),
                        ));
                    if (imageFile.value != null) {
                      await textRecognition(imageFile.value!);
                    }
                  },
                )
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height / 25),
            CustomElevatedButton(
                icon: Icons.volume_off_rounded,
                onPressed: () async {
                  await tts.stop();
                })
          ],
        ),
      ),
    );
  }
}
