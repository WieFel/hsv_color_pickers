import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hsv_color_pickers/widgets/common.dart';

/// This class defines a slider for picking the hue of a [HSVColor].
class HuePicker extends StatefulWidget {
  /// The initial [HSVColor] which should be set on the color slider. Either this
  /// color should be set at the beginning, or [initialColor].
  final HSVColor initialColor;

  /// Callback which is triggered on every change of the color slider's value.
  final HSVColorChange onChanged;

  /// The height of the slider's track.
  ///
  /// Defaults to 15px.
  final double trackHeight;

  /// Creates an instance of [HuePicker].
  HuePicker({
    Key key,
    @required this.initialColor,
    this.onChanged,
    this.trackHeight = 15,
  })  : assert(initialColor != null),
        super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _HuePickerState();
  }
}

class _HuePickerState extends State<HuePicker> {
  HSVColor _color;

  final List<Color> hueColors = [
    const Color.fromARGB(255, 255, 0, 0),
    const Color.fromARGB(255, 255, 255, 0),
    const Color.fromARGB(255, 0, 255, 0),
    const Color.fromARGB(255, 0, 255, 255),
    const Color.fromARGB(255, 0, 0, 255),
    const Color.fromARGB(255, 255, 0, 255),
    const Color.fromARGB(255, 255, 0, 0),
  ];

  @override
  void initState() {
    _color = widget.initialColor;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.trackHeight,
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: this.hueColors),
          borderRadius: BorderRadius.circular(widget.trackHeight)),
      child: SliderTheme(
        data: SliderThemeData(
            trackShape: CustomTrackShape(),
            thumbColor: Colors.white,
            activeTrackColor: Colors.transparent,
            inactiveTrackColor: Colors.transparent,
            thumbShape: CustomSliderThumbShape()),
        child: Slider(
          min: 0.0,
          max: 360.0,
          value: _color.hue,
          onChanged: (hue) {
            setState(() {
              _color = _color.withHue(hue);
            });
            widget.onChanged?.call(_color);
          },
        ),
      ),
    );
  }
}

/// Defines a custom track shape for a [Slider].
class CustomTrackShape extends RoundedRectSliderTrackShape {
  Rect getPreferredRect({
    @required RenderBox parentBox,
    Offset offset = Offset.zero,
    @required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final double trackHeight = sliderTheme.trackHeight;
    final double trackLeft = offset.dx +
        sliderTheme.thumbShape.getPreferredSize(isEnabled, isDiscrete).width /
            2;
    final double trackTop =
        offset.dy + (parentBox.size.height - trackHeight) / 2;
    final double trackWidth = parentBox.size.width -
        sliderTheme.thumbShape.getPreferredSize(isEnabled, isDiscrete).width;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }
}

/// Defines a custom thumb shape for a [Slider].
class CustomSliderThumbShape extends RoundSliderThumbShape {
  /// Copied from [RoundSliderThumbShape.paint] and modified.
  @override
  void paint(
    PaintingContext context,
    Offset center, {
    Animation<double> activationAnimation,
    @required Animation<double> enableAnimation,
    bool isDiscrete,
    TextPainter labelPainter,
    RenderBox parentBox,
    @required SliderThemeData sliderTheme,
    TextDirection textDirection,
    double value,
    double textScaleFactor,
    Size sizeWithOverflow,
  }) {
    assert(context != null);
    assert(center != null);
    assert(enableAnimation != null);
    assert(sliderTheme != null);
    assert(sliderTheme.disabledThumbColor != null);
    assert(sliderTheme.thumbColor != null);

    final Canvas canvas = context.canvas;
    final Tween<double> radiusTween = Tween<double>(
      begin: disabledThumbRadius ?? enabledThumbRadius,
      end: enabledThumbRadius,
    );
    final ColorTween colorTween = ColorTween(
      begin: sliderTheme.disabledThumbColor,
      end: sliderTheme.thumbColor,
    );

    final Color color = colorTween.evaluate(enableAnimation);
    final double radius = radiusTween.evaluate(enableAnimation);

    canvas.drawCircle(
      center,
      radius - 1,
      Paint()
        ..color = color
        ..style = PaintingStyle.stroke
        ..strokeWidth = 3,
    );

    canvas.drawCircle(
      center,
      radius,
      Paint()
        ..color = Colors.black
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1,
    );
  }
}
