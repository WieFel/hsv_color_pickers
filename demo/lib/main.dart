import 'package:demo/data/use_case.dart';
import 'package:demo/use_cases/hue_picker/hue_picker_use_case.dart';
import 'package:flutter/material.dart';
import 'package:gallerize/gallerize.dart';
import 'package:gallerize/themes/gallerize_theme_data.dart';

void main() => runApp(const DemoApp());

/// Demo app that provides a show-case of different backdrop use cases.
class DemoApp extends StatelessWidget {
  const DemoApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "HSV Color Pickers - Gallery",
      theme: GallerizeThemeData.darkThemeData,
      home: const HomePage(),
    );
  }
}

/// The home page of the demo app showing a selection of use cases.
class HomePage extends StatelessWidget {
  final List<UseCase> _useCases = const [
    HuePickerUseCase(),
  ];

  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("HSV Color Pickers - Gallery"),
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(16.0),
            child: const Text(
                "This app shows the basic usages of the different widgets "
                "that are offered by the hsv_color_pickers package. "
                "Open any one to show information about it, preview it and "
                "look at its code."),
          ),
          ListView.separated(
            itemCount: _useCases.length,
            itemBuilder: (BuildContext context, int index) => ListTile(
              title: Text(_useCases[index].name),
              onTap: () => _openDemoPage(context, _useCases[index]),
            ),
            shrinkWrap: true,
            separatorBuilder: (context, index) => const Divider(),
          ),
        ],
      ),
    );
  }

  _openDemoPage(BuildContext context, UseCase useCase) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GallerizePage(
          name: useCase.name,
          description: useCase.description,
          preview: useCase.preview,
          codeFile: useCase.codeFile,
        ),
      ),
    );
  }
}
