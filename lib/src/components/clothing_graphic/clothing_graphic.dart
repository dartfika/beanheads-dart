import '../../enums.dart';
import '../../svg_builder.dart';
import 'gatsby.dart';
import 'graphql.dart';
import 'react_graphic.dart';
import 'redwood.dart';
import 'vue.dart';

/// Renders a clothing graphic of the given [type] onto the SVG.
///
/// Returns a render function that can be passed to clothing renderers,
/// or null if [type] is [ClothingGraphic.none].
void Function(SvgBuilder)? getClothingGraphicRenderer({
  required ClothingGraphic type,
  required String white,
}) {
  switch (type) {
    case ClothingGraphic.none:
      return null;
    case ClothingGraphic.redwood:
      return (svg) => renderRedwood(svg, white: white);
    case ClothingGraphic.gatsby:
      return (svg) => renderGatsby(svg);
    case ClothingGraphic.vue:
      return (svg) => renderVue(svg);
    case ClothingGraphic.react:
      return (svg) => renderReactGraphic(svg, white: white);
    case ClothingGraphic.graphQL:
      return (svg) => renderGraphQL(svg, white: white);
  }
}
