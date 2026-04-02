import '../../svg_builder.dart';
import '../../theme.dart';

/// Renders dizzy X-shaped eyes.
void renderDizzyEyes(SvgBuilder svg, {required BeanheadsTheme theme}) {
  // Left eye X
  svg.addLine(
    x1: 375.88,
    y1: 603.9,
    x2: 306.24,
    y2: 534.26,
    fill: 'none',
    stroke: theme.outline,
    strokeLinecap: 'round',
    strokeMiterlimit: 10,
    strokeWidth: '16px',
  );
  svg.addLine(
    x1: 306.24,
    y1: 603.9,
    x2: 375.88,
    y2: 534.26,
    fill: 'none',
    stroke: theme.outline,
    strokeLinecap: 'round',
    strokeMiterlimit: 10,
    strokeWidth: '16px',
  );
  // Right eye X
  svg.addLine(
    x1: 695.99,
    y1: 603.9,
    x2: 626.34,
    y2: 534.26,
    fill: 'none',
    stroke: theme.outline,
    strokeLinecap: 'round',
    strokeMiterlimit: 10,
    strokeWidth: '16px',
  );
  svg.addLine(
    x1: 626.34,
    y1: 603.9,
    x2: 695.99,
    y2: 534.26,
    fill: 'none',
    stroke: theme.outline,
    strokeLinecap: 'round',
    strokeMiterlimit: 10,
    strokeWidth: '16px',
  );
}
