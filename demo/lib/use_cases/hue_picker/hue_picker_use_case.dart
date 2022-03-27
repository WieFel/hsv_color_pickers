import 'package:demo/data/use_case.dart';
import 'package:demo/use_cases/hue_picker/hue_picker.dart';

/// HuePicker use case description.
class HuePickerUseCase extends UseCase {
  /// Creates a HuePicker use case instance
  const HuePickerUseCase()
      : super(
          name: "Hue Picker",
          description:
              "The HuePicker widget is meant for the user to choose the hue value of a "
              "HSVColor.",
          codeFile: "lib/use_cases/hue_picker/hue_picker.dart",
          preview: const HuePickerPage(),
        );
}
