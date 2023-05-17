import 'package:audio_visual_text/colors.dart';
import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    super.key,
    this.title,
    required this.icon,
    required this.onPressed,
  });

  final String? title;
  final IconData icon;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          onPressed();
        },
        style: ButtonStyle(
          shape: MaterialStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          padding:
              const MaterialStatePropertyAll(EdgeInsets.symmetric(vertical: 5)),
          backgroundColor: const MaterialStatePropertyAll(Colors.white),
          side: const MaterialStatePropertyAll(
            BorderSide(color: beautifulGreen),
          ),
        ),
        child: Column(
          children: [
            Icon(icon, color: beautifulGreen),
            (title != null)
                ? Text(
                    title!,
                    style: const TextStyle(color: beautifulGreen),
                  )
                : const SizedBox(),
          ],
        ));
  }
}
