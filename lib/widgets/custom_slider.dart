import 'package:audio_visual_text/colors.dart';
import 'package:flutter/material.dart';

class CustomSlider extends StatefulWidget {
  const CustomSlider({
    super.key,
    required this.title,
    required this.max,
    required this.min,
    required this.onChanged,
  });

  final String title;
  final double max, min;
  final Function onChanged;

  @override
  State<CustomSlider> createState() => _CustomSliderState();
}

class _CustomSliderState extends State<CustomSlider> {
  final ValueNotifier<double> _valueNotifier = ValueNotifier<double>(0.5);

  @override
  void initState() {
    super.initState();
    _valueNotifier.value = widget.max / 2;
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _valueNotifier,
      builder: (context, value, child) => Row(
        children: [
          SizedBox(
            width: 55,
            child: Text(
              widget.title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16),
            ),
          ),
          Expanded(
            child: Slider(
              activeColor: beautifulGreen,
              inactiveColor: const Color.fromARGB(255, 168, 221, 209),
              max: widget.max,
              min: widget.min,
              value: value,
              onChanged: (value) {
                _valueNotifier.value = value;
                widget.onChanged(value);
              },
            ),
          ),
          Text(
            value.toStringAsFixed(1),
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
