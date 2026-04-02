import '../../enums.dart';
import '../../svg_builder.dart';
import '../../theme.dart';
import 'normal_eyebrows.dart';
import 'left_lowered_eyebrows.dart';
import 'serious_eyebrows.dart';
import 'angry_eyebrows.dart';
import 'concerned_eyebrows.dart';

/// Renders the eyebrows for the given [type].
void renderEyebrows(
  SvgBuilder svg, {
  required Eyebrows type,
  required BeanheadsTheme theme,
}) {
  switch (type) {
    case Eyebrows.raised:
      renderNormalEyebrows(svg, theme: theme);
    case Eyebrows.leftLowered:
      renderLeftLoweredEyebrows(svg, theme: theme);
    case Eyebrows.serious:
      renderSeriousEyebrows(svg, theme: theme);
    case Eyebrows.angry:
      renderAngryEyebrows(svg, theme: theme);
    case Eyebrows.concerned:
      renderConcernedEyebrows(svg, theme: theme);
  }
}
