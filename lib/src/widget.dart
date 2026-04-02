import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'avatar.dart';
import 'config.dart';
import 'theme.dart';

/// A Flutter widget that renders a BeanHead avatar.
///
/// Generates an SVG string from the given [config] and renders it
/// using [SvgPicture]. The SVG is cached and only regenerated when
/// [config] or [theme] changes.
class Beanhead extends StatefulWidget {
  /// The avatar configuration describing each visual property.
  final BeanheadConfig config;

  /// Optional custom theme for color overrides.
  final BeanheadsTheme? theme;

  /// Optional fixed width for the widget.
  final double? width;

  /// Optional fixed height for the widget.
  final double? height;

  /// How the avatar should be inscribed into the available space.
  final BoxFit fit;

  const Beanhead({
    super.key,
    required this.config,
    this.theme,
    this.width,
    this.height,
    this.fit = BoxFit.contain,
  });

  /// Creates a Beanhead widget with a random configuration.
  factory Beanhead.random({
    Key? key,
    Random? random,
    BeanheadsTheme? theme,
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
  }) {
    return Beanhead(
      key: key,
      config: BeanheadConfig.random(random: random),
      theme: theme,
      width: width,
      height: height,
      fit: fit,
    );
  }

  @override
  State<Beanhead> createState() => _BeanheadState();
}

class _BeanheadState extends State<Beanhead> {
  late String _svgString;

  @override
  void initState() {
    super.initState();
    _svgString = generateAvatar(widget.config, theme: widget.theme);
  }

  @override
  void didUpdateWidget(Beanhead oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.config != oldWidget.config || widget.theme != oldWidget.theme) {
      _svgString = generateAvatar(widget.config, theme: widget.theme);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SvgPicture.string(
      _svgString,
      width: widget.width,
      height: widget.height,
      fit: widget.fit,
    );
  }
}
