import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hsv_color_pickers/widgets/common.dart';

/// This class defines a slider for picking the hue of a [HSVColor].
class HuePicker extends StatefulWidget {
  /// The initial [HSVColor] which should be set on the color slider. Either this
  /// color should be set at the beginning, or [initialColor].
  final HSVColor initialColor;

  /// The height of the slider's track.
  ///
  /// Defaults to 15px.
  final double trackHeight;

  /// Callback which is triggered on every change of the color slider's value.
  /// Check [Slider.onChanged].
  final HSVColorChange onChanged;

  /// Callback which is triggered when the user starts dragging.
  /// Check [Slider.onChangeStart].
  final HSVColorChange onChangeStart;

  /// Callback which is triggered when the user finishes dragging.
  /// Check [Slider.onChangeEnd].
  final HSVColorChange onChangeEnd;

  /// The [RoundSliderThumbShape] that should be used for the slider.
  /// It is recommended to use [HueSliderThumbShape] and parametrise it
  /// accordingly.
  ///
  /// Defaults to `HueSliderThumbShape()`.
  final RoundSliderThumbShape thumbShape;

  /// The color shown around the thumb when it is being dragged.
  final Color thumbOverlayColor;

  /// Creates an instance of [HuePicker].
  HuePicker({
    Key key,
    @required this.initialColor,
    this.trackHeight = 15,
    this.onChanged,
    this.onChangeStart,
    this.onChangeEnd,
    this.thumbShape = const HueSliderThumbShape(),
    this.thumbOverlayColor,
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
          trackShape: HueTrackShape(),
          thumbColor: Colors.white,
          activeTrackColor: Colors.transparent,
          inactiveTrackColor: Colors.transparent,
          thumbShape: widget.thumbShape,
          overlayColor: widget.thumbOverlayColor,
        ),
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
          onChangeStart: (_) => widget.onChangeStart?.call(_color),
          onChangeEnd: (_) => widget.onChangeEnd?.call(_color),
        ),
      ),
    );
  }
}

/// Defines a custom track shape for the hue-[Slider].
/// Lets the slider thumb slide until the exact end of the slider.
class HueTrackShape extends RoundedRectSliderTrackShape {
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
class HueSliderThumbShape extends RoundSliderThumbShape {
  /// The radius of the slider thumb.
  final double radius;

  /// Whether the thumb should be filled or not on the inside.
  ///
  /// Defaults to `false`.
  final bool filled;

  /// Main color of the thumb (either fill color or stroke color if filled: `false`).
  ///
  /// Defaults to [Colors.white].
  final Color color;

  /// Width of the stroke, if filled is set to `false`.
  ///
  /// Defaults to 3.
  final double strokeWidth;

  /// Whether an additional border should be shown around the thumb.
  ///
  /// Defaults to `true`.
  final bool showBorder;

  /// The [Color] of the additional border around the thumb.
  ///
  /// Defaults to [Colors.black].
  final Color borderColor;

  /// The width of the border.
  ///
  /// Defaults to 1.
  final double borderWidth;

  /// Creates an instance of [HueSliderThumbShape].
  const HueSliderThumbShape({
    this.radius = 10,
    this.filled = true,
    this.color = Colors.white,
    this.strokeWidth = 3,
    this.showBorder = false,
    this.borderColor = Colors.black,
    this.borderWidth = 1,
  }) : super(enabledThumbRadius: radius);

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

    final double radius = radiusTween.evaluate(enableAnimation);

    var circlePaint = Paint()
      ..color = color
      ..style = filled ? PaintingStyle.fill : PaintingStyle.stroke;

    if (!filled) {
      circlePaint.strokeWidth = strokeWidth;
    }

    // draw main thumb circle
    canvas.drawCircle(
        center, showBorder ? radius - borderWidth : radius, circlePaint);

    if (showBorder) {
      // if border should be shown, draw it around existing circle
      var borderRadius = radius - borderWidth;
      if (!filled) {
        borderRadius = borderRadius + strokeWidth / 2;
      }
      canvas.drawCircle(
        center,
        borderRadius,
        Paint()
          ..color = borderColor
          ..style = PaintingStyle.stroke
          ..strokeWidth = borderWidth,
      );
    }
  }
}
