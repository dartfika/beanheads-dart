import '../../enums.dart';
import '../../svg_builder.dart';
import '../../theme.dart';
import 'dress.dart';
import 'dress_shirt.dart';
import 'shirt.dart';
import 'tank_top.dart';
import 'vneck.dart';

/// Result of resolving clothing renderers for a given clothing type.
class ClothingRenderResult {
  /// Renderer for the front layer of the clothing (drawn on top of body).
  final void Function(SvgBuilder)? renderFront;

  /// Renderer for the back layer of the clothing (drawn behind body).
  final void Function(SvgBuilder)? renderBack;

  /// Whether bra straps should be shown on the body.
  /// Dress sets this to false since it covers the straps.
  final bool braStraps;

  /// Optional override for the body color (e.g. DressShirt forces white).
  final ColorPair? bodyColorOverride;

  const ClothingRenderResult({
    this.renderFront,
    this.renderBack,
    this.braStraps = true,
    this.bodyColorOverride,
  });
}

/// Resolves clothing renderers based on the given clothing [type].
ClothingRenderResult getClothingRenderers({
  required Clothing type,
  required ColorPair color,
  required ColorPair skinColor,
  required String outline,
  required String white,
  required ColorPair whiteColor,
  void Function(SvgBuilder)? renderGraphic,
}) {
  switch (type) {
    case Clothing.naked:
      return const ClothingRenderResult();

    case Clothing.shirt:
      return ClothingRenderResult(
        renderFront: (svg) => renderShirtFront(
          svg,
          skinColor: skinColor,
          color: color,
          outline: outline,
          renderGraphic: renderGraphic,
        ),
      );

    case Clothing.dressShirt:
      return ClothingRenderResult(
        renderFront: (svg) => renderDressShirtFront(
          svg,
          skinColor: skinColor,
          color: color,
          outline: outline,
          white: white,
          whiteColor: whiteColor,
          renderGraphic: renderGraphic,
        ),
        bodyColorOverride: whiteColor,
      );

    case Clothing.vneck:
      return ClothingRenderResult(
        renderFront: (svg) => renderVNeckFront(
          svg,
          skinColor: skinColor,
          color: color,
          outline: outline,
          renderGraphic: renderGraphic,
        ),
      );

    case Clothing.tankTop:
      return ClothingRenderResult(
        renderFront: (svg) => renderTankTopFront(
          svg,
          color: color,
          outline: outline,
          renderGraphic: renderGraphic,
        ),
      );

    case Clothing.dress:
      return ClothingRenderResult(
        renderFront: (svg) => renderDressFront(
          svg,
          skinColor: skinColor,
          color: color,
          outline: outline,
        ),
        renderBack: (svg) => renderDressBack(
          svg,
          color: color,
          outline: outline,
        ),
        braStraps: false,
      );
  }
}
