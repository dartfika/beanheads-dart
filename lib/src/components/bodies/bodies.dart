import '../../enums.dart';
import '../../svg_builder.dart';
import '../../theme.dart';
import 'breasts.dart';
import 'chest.dart';

/// Result of resolving body renderers for a given body type.
class BodyRenderResult {
  /// Renderer for the front layer of the body.
  final void Function(SvgBuilder)? renderFront;

  /// Renderer for the back layer of the body.
  final void Function(SvgBuilder)? renderBack;

  const BodyRenderResult({this.renderFront, this.renderBack});
}

/// Resolves body renderers based on the given body [type].
BodyRenderResult getBodyRenderers({
  required Body type,
  required ColorPair clothingColor,
  required ColorPair skinColor,
  required String outline,
  required String white,
  bool braStraps = true,
}) {
  switch (type) {
    case Body.chest:
      // Chest: front is a no-op, only back renders
      return BodyRenderResult(
        renderBack: (svg) => renderChestBack(
          svg,
          skinColor: skinColor,
          outline: outline,
        ),
      );

    case Body.breasts:
      return BodyRenderResult(
        renderFront: (svg) => renderBreastsFront(
          svg,
          clothingColor: clothingColor,
          outline: outline,
        ),
        renderBack: (svg) => renderBreastsBack(
          svg,
          clothingColor: clothingColor,
          skinColor: skinColor,
          outline: outline,
          white: white,
          braStraps: braStraps,
        ),
      );
  }
}
