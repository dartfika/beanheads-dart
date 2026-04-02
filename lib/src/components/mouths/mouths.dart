import '../../enums.dart';
import '../../svg_builder.dart';
import '../../theme.dart';
import 'grin_mouth.dart';
import 'sad_mouth.dart';
import 'lips_mouth.dart';
import 'smile_open_mouth.dart';
import 'open_mouth.dart';
import 'serious_mouth.dart';
import 'tongue_mouth.dart';

/// Renders the mouth for the given [type].
///
/// The [lipColor] is only used by the [Mouth.lips] variant.
void renderMouth(
  SvgBuilder svg, {
  required Mouth type,
  required BeanheadsTheme theme,
  LipColor? lipColor,
}) {
  switch (type) {
    case Mouth.grin:
      renderGrinMouth(svg, theme: theme);
    case Mouth.sad:
      renderSadMouth(svg, theme: theme);
    case Mouth.lips:
      final color = lipColor ?? LipColor.red;
      final pair = theme.lipColors[color]!;
      renderLipsMouth(svg,
          theme: theme, lipBase: pair.base, lipShadow: pair.shadow);
    case Mouth.openSmile:
      renderSmileOpenMouth(svg, theme: theme);
    case Mouth.open:
      renderOpenMouth(svg, theme: theme);
    case Mouth.serious:
      renderSeriousMouth(svg, theme: theme);
    case Mouth.tongue:
      renderTongueMouth(svg, theme: theme);
  }
}
