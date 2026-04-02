import '../../svg_builder.dart';
import '../../theme.dart';

/// Renders a serious (straight line) mouth.
void renderSeriousMouth(SvgBuilder svg, {required BeanheadsTheme theme}) {
  svg.addLine(
    x1: 446.66,
    y1: 606.02,
    x2: 542.53,
    y2: 606.02,
    fill: 'none',
    stroke: theme.outline,
    strokeLinecap: 'round',
    strokeMiterlimit: 10,
    strokeWidth: '12px',
  );
}
