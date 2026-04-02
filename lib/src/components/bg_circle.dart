import '../svg_builder.dart';

/// Renders the background circle behind the avatar.
void renderBgCircle(SvgBuilder svg, {required String color}) {
  svg.addCircle(cx: 500, cy: 630.1601, r: 332.441995, fill: color);
}
