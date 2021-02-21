# hsv_color_pickers

[![gallerize](https://img.shields.io/badge/gallerize-check%20demo-purple?logo=flutter&logoColor=blue)](https://wiefel.github.io/hsv_color_pickers/#/)
[![pub.dev](https://img.shields.io/pub/v/hsv_color_pickers?logo=dart)](https://pub.dev/packages/hsv_color_pickers)
[![analysis](https://github.com/WieFel/gallerize/workflows/analysis/badge.svg)](https://github.com/WieFel/gallerize/actions?query=workflow%3Aanalysis)

Flutter package for creating customisable Color pickers for HSV Colors.

## Hue Picker
The `HuePicker` is used to let the user pick the hue of a `HSVColor` by selecting it on the slider.

<img src="https://github.com/WieFel/hsv_color_pickers/raw/main/.github/images/hue_picker_1.png"  width=50% alt="Hue Slider 1"/>


The height of the slider is customizable.
<img src="https://github.com/WieFel/hsv_color_pickers/raw/main/.github/images/hue_picker_2.png"  width=50% alt="Hue Slider 2"/>


The slider thumb is as well completely customizable.
<img src="https://github.com/WieFel/hsv_color_pickers/raw/main/.github/images/hue_picker_3.png"  width=50% alt="Hue Slider 3"/>

### Usage
```dart
HuePicker(
  initialColor: HSVColor.fromColor(Colors.green),
  onChanged: (HSVColor color) {
      // do something with color
  },
)
```

### Customize
Customize the slider's **height** using `trackHeight`:
```dart
HuePicker(
  ...
  trackHeight: 50,
)
```


Customize the **thumb** by passing a `thumbOverlayColor` and a custom `thumbShape`:
```dart
HuePicker(
  ...
  thumbOverlayColor: Colors.green.withOpacity(0.3),
  thumbShape: HueSliderThumbShape(
    color: Colors.black,
    strokeWidth: 8,
    filled: false,
    showBorder: true
  ),
)
```
`HueSliderThumbShape` offers the following properties for customisation:
- `radius`: the radius of the thumb (double)
- `filled`: whether the thumb should be filled or not (bool)
- `color`: main color of the thumb
- `strokeWidth`: stroke with for non-filled thumb (double)
- `showBorder`: whether to show the border or not (bool)
- `borderColor`: color of the border, if shown
- `borderWidth`: stroke with of the border, if shown (double)

## Coming soon...
- Saturation Picker
- Brightness Picker

## Contribute
If you have any ideas for extending this package or have found a bug, please contribute!

1. You'll need a GitHub account.
2. Fork the [hsv_color_pickers repository](https://github.com/WieFel/hsv_color_pickers).
3. Work on your feature/bug.
4. Create a pull request.
5. Star this project. ⭐
6. Become a hero!! 🎉
