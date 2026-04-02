import '../../enums.dart';
import '../../svg_builder.dart';
import '../../theme.dart';
import 'beanie.dart';
import 'turban.dart';

/// Result of hat rendering setup.
class HatRenderResult {
  /// Callback to render the front layer of the hat.
  final void Function(SvgBuilder)? renderFront;

  /// Callback to render the back layer of the hat.
  final void Function(SvgBuilder)? renderBack;

  const HatRenderResult({this.renderFront, this.renderBack});
}

/// Returns a [HatRenderResult] with front/back renderers for the given
/// hat [type] and [hatColor].
HatRenderResult getHatRenderers({
  required Hat type,
  required ColorPair hatColor,
  required String outline,
  required String white,
  double scale = 1,
}) {
  switch (type) {
    case Hat.none:
      return const HatRenderResult();

    case Hat.beanie:
      return HatRenderResult(
        renderFront: (svg) => renderBeanieFront(
          svg,
          hatColor: hatColor,
          outline: outline,
          white: white,
          scale: scale,
        ),
        renderBack: (svg) => renderBeanieBack(
          svg,
          outline: outline,
          scale: scale,
        ),
      );

    case Hat.turban:
      return HatRenderResult(
        renderFront: (svg) => renderTurbanFront(
          svg,
          hatColor: hatColor,
          outline: outline,
          white: white,
          scale: scale,
        ),
        renderBack: (svg) => renderTurbanBack(
          svg,
          outline: outline,
          scale: scale,
        ),
      );
  }
}
