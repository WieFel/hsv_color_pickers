import 'package:flutter/material.dart';
import 'package:hsv_color_pickers/hsv_color_pickers.dart';

class HuePickerPage extends StatefulWidget {
  @override
  _HuePickerPageState createState() => _HuePickerPageState();
}

class _HuePickerPageState extends State<HuePickerPage> {
  Color _color = Colors.green;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        CircleAvatar(
          radius: 32,
          backgroundColor: _color,
        ),
        // first HuePicker, with default settings
        HuePicker(
          initialColor: HSVColor.fromColor(_color),
          onChanged: (color) {
            setState(() {
              _color = color.toColor();
            });
          },
        ),
        // second HuePicker, with custom height
        HuePicker(
          initialColor: HSVColor.fromColor(_color),
          trackHeight: 32,
          onChanged: (color) {
            setState(() {
              _color = color.toColor();
            });
          },
          thumbShape: HueSliderThumbShape(
            radius: 16,
          ),
        ),
        // third uePicker, with custom height and custom thumb settings
        HuePicker(
          initialColor: HSVColor.fromColor(_color),
          trackHeight: 50,
          onChanged: (color) {
            setState(() {
              _color = color.toColor();
            });
          },
          thumbOverlayColor: Colors.orange.withOpacity(0.3),
          thumbShape: HueSliderThumbShape(
            radius: 25,
            filled: false,
            color: Colors.orange,
            showBorder: true,
            borderColor: Colors.black,
          ),
        ),
      ],
    );
  }
}
