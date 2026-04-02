import '../../enums.dart';
import '../../svg_builder.dart';
import 'round_glasses.dart';
import 'shades.dart';
import 'tiny_glasses.dart';

/// Renders the specified accessory type.
void renderAccessory(
  SvgBuilder svg, {
  required Accessory type,
  required String outline,
  required String white,
}) {
  switch (type) {
    case Accessory.none:
      return;
    case Accessory.roundGlasses:
      renderRoundGlasses(svg, outline: outline);
    case Accessory.tinyGlasses:
      renderTinyGlasses(svg, outline: outline, white: white);
    case Accessory.shades:
      renderShades(svg, outline: outline, white: white);
  }
}
