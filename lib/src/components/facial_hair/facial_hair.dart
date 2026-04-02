import '../../enums.dart';
import '../../svg_builder.dart';
import '../../theme.dart';
import 'stubble.dart';
import 'medium_beard.dart';

/// Renders facial hair for the given [type].
///
/// The [hairColor] is used by [FacialHair.mediumBeard] to determine
/// the beard color via the theme's hair color map.
void renderFacialHair(
  SvgBuilder svg, {
  required FacialHair type,
  required BeanheadsTheme theme,
  HairColor? hairColor,
}) {
  switch (type) {
    case FacialHair.none:
      return;
    case FacialHair.stubble:
      renderStubble(svg, theme: theme);
    case FacialHair.mediumBeard:
      final color = hairColor ?? HairColor.brown;
      final pair = theme.hairColors[color]!;
      renderMediumBeard(svg,
          theme: theme, base: pair.base, shadow: pair.shadow);
  }
}
