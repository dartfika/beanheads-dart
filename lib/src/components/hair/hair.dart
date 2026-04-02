import '../../enums.dart';
import '../../svg_builder.dart';
import '../../theme.dart';
import 'afro.dart';
import 'balding_hair.dart';
import 'bob_cut.dart';
import 'bun_hair.dart';
import 'buzz_cut.dart';
import 'long_hair.dart';
import 'pixie_cut.dart';
import 'short_hair.dart';

/// Result of hair rendering setup, including optional hat scale override.
class HairRenderResult {
  /// Callback to render the front layer of the hair.
  final void Function(SvgBuilder)? renderFront;

  /// Callback to render the back layer of the hair.
  final void Function(SvgBuilder)? renderBack;

  /// Optional hat scale override (only set by certain hair types).
  final double? hatScale;

  const HairRenderResult({this.renderFront, this.renderBack, this.hatScale});
}

/// Returns a [HairRenderResult] with front/back renderers for the given
/// hair [type] and [hairColor].
HairRenderResult getHairRenderers({
  required Hair type,
  required ColorPair hairColor,
  required String skinShadow,
  required String outline,
  required String white,
  bool hasHat = false,
}) {
  switch (type) {
    case Hair.none:
      return const HairRenderResult();

    case Hair.long:
      return HairRenderResult(
        renderFront: (svg) => renderLongHairFront(
          svg,
          hairColor: hairColor,
          skinShadow: skinShadow,
          outline: outline,
          white: white,
          hasHat: hasHat,
        ),
        renderBack: (svg) => renderLongHairBack(
          svg,
          hairColor: hairColor,
          outline: outline,
        ),
        hatScale: longHairHatScale,
      );

    case Hair.bun:
      return HairRenderResult(
        renderFront: (svg) => renderBunHairFront(
          svg,
          hairColor: hairColor,
          skinShadow: skinShadow,
          outline: outline,
          white: white,
          hasHat: hasHat,
        ),
        renderBack: (svg) => renderBunHairBack(
          svg,
          hairColor: hairColor,
          outline: outline,
        ),
      );

    case Hair.short:
      return HairRenderResult(
        renderFront: (svg) => renderShortHairFront(
          svg,
          hairColor: hairColor,
          skinShadow: skinShadow,
          outline: outline,
          white: white,
          hasHat: hasHat,
        ),
        renderBack: (svg) => renderShortHairBack(
          svg,
          hairColor: hairColor,
          outline: outline,
        ),
      );

    case Hair.pixie:
      return HairRenderResult(
        renderFront: (svg) => renderPixieCutFront(
          svg,
          hairColor: hairColor,
          skinShadow: skinShadow,
          outline: outline,
          white: white,
          hasHat: hasHat,
        ),
        renderBack: (svg) => renderPixieCutBack(
          svg,
          hairColor: hairColor,
          outline: outline,
        ),
      );

    case Hair.balding:
      return HairRenderResult(
        renderFront: (svg) => renderBaldingHairFront(
          svg,
          hairColor: hairColor,
          skinShadow: skinShadow,
          outline: outline,
          white: white,
          hasHat: hasHat,
        ),
        renderBack: (svg) => renderBaldingHairBack(
          svg,
          hairColor: hairColor,
          outline: outline,
        ),
        hatScale: baldingHairHatScale,
      );

    case Hair.buzz:
      return HairRenderResult(
        renderFront: (svg) => renderBuzzCutFront(
          svg,
          hairColor: hairColor,
          skinShadow: skinShadow,
          outline: outline,
          white: white,
          hasHat: hasHat,
        ),
        renderBack: (svg) => renderBuzzCutBack(
          svg,
          hairColor: hairColor,
          outline: outline,
        ),
      );

    case Hair.afro:
      return HairRenderResult(
        renderFront: (svg) => renderAfroFront(
          svg,
          hairColor: hairColor,
          skinShadow: skinShadow,
          outline: outline,
          white: white,
          hasHat: hasHat,
        ),
        renderBack: (svg) => renderAfroBack(
          svg,
          hairColor: hairColor,
          outline: outline,
        ),
        hatScale: afroHatScale,
      );

    case Hair.bob:
      return HairRenderResult(
        renderFront: (svg) => renderBobCutFront(
          svg,
          hairColor: hairColor,
          skinShadow: skinShadow,
          outline: outline,
          white: white,
          hasHat: hasHat,
        ),
        renderBack: (svg) => renderBobCutBack(
          svg,
          hairColor: hairColor,
          outline: outline,
        ),
        hatScale: bobCutHatScale,
      );
  }
}
