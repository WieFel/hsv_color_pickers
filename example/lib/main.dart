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
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
          appBar: AppBar(
            title: Text("HSV Colors Pickers"),
          ),
          body: Column(
            children: [
              Expanded(
                child: InitialColorExample(),
              ),
              Divider(thickness: 2),
              Expanded(
                child: ControllerExample(),
              ),
            ],
          )),
    );
  }
}

class InitialColorExample extends StatefulWidget {
  const InitialColorExample({Key? key}) : super(key: key);

  @override
  State<InitialColorExample> createState() => _InitialColorExampleState();
}

class _InitialColorExampleState extends State<InitialColorExample> {
  Color _color = Colors.green;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(
          "Example using initialColor",
          style: Theme.of(context).textTheme.headline6,
        ),
        CircleAvatar(
          radius: 32,
          backgroundColor: _color,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: HuePicker(
            initialColor: HSVColor.fromColor(_color),
            onChanged: (color) {
              setState(() {
                this._color = color.toColor();
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
    );
  }
}

class ControllerExample extends StatefulWidget {
  const ControllerExample({Key? key}) : super(key: key);

  @override
  State<ControllerExample> createState() => _ControllerExampleState();
}

class _ControllerExampleState extends State<ControllerExample> {
  late HueController _controller;

  @override
  void initState() {
    super.initState();
    _controller = HueController(HSVColor.fromColor(Colors.green));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(
          "Example using controller",
          style: Theme.of(context).textTheme.headline6,
        ),
        CircleAvatar(
          radius: 32,
          backgroundColor: _controller.value.toColor(),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: HuePicker(
            controller: _controller,
            onChanged: (color) {
              setState(() {
                // Intentionally left empty, to trigger re-build of Widget
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
        ElevatedButton(
            onPressed: () {
              _controller.value = HSVColor.fromColor(Colors.blue);
            },
            child: Text("Reset to blue form outside"))
      ],
    );
  }
}
