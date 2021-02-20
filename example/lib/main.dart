import 'package:flutter/material.dart';
import 'package:hsv_color_pickers/hsv_color_pickers.dart';

void main() {
  runApp(ExampleApp());
}

class ExampleApp extends StatefulWidget {
  @override
  _ExampleAppState createState() => _ExampleAppState();
}

class _ExampleAppState extends State<ExampleApp> {
  Color color = Colors.green;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text("HSV Colors Pickers"),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              height: 50,
              width: 50,
              color: color,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: HuePicker(
                initialColor: HSVColor.fromColor(color),
                onChanged: (color) {
                  setState(() {
                    this.color = color.toColor();
                  });
                },
                thumbShape: HueSliderThumbShape(
                  color: Colors.white,
                  borderColor: Colors.black,
                  filled: false,
                  showBorder: true,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
