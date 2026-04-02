import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'avatar.dart';
import 'config.dart';
import 'theme.dart';

/// A Flutter widget that renders a BeanHead avatar.
///
/// Generates an SVG string from the given [config] and renders it
/// using [SvgPicture].
class Beanhead extends StatelessWidget {
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
    BeanheadsTheme? theme,
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
  }) {
    return Beanhead(
      key: key,
      config: BeanheadConfig.random(),
      theme: theme,
      width: width,
      height: height,
      fit: fit,
    );
  }

  @override
  Widget build(BuildContext context) {
    final svgString = generateAvatar(config, theme: theme);
    return SvgPicture.string(
      svgString,
      width: width,
      height: height,
      fit: fit,
    );
  }
}
