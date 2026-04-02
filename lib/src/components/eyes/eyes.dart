import '../../enums.dart';
import '../../svg_builder.dart';
import '../../theme.dart';
import 'normal_eyes.dart';
import 'happy_eyes.dart';
import 'content_eyes.dart';
import 'squint_eyes.dart';
import 'simple_eyes.dart';
import 'dizzy_eyes.dart';
import 'wink_eyes.dart';
import 'heart_eyes.dart';
import 'left_twitch_eyes.dart';

/// Renders the eyes for the given [type].
///
/// Some eye variants require skin colors for lid overlays.
/// The [withLashes] flag adds eyelash decorations.
void renderEyes(
  SvgBuilder svg, {
  required Eyes type,
  required BeanheadsTheme theme,
  required String skinBase,
  required String skinShadow,
  bool withLashes = false,
}) {
  switch (type) {
    case Eyes.normal:
      renderNormalEyes(svg,
          theme: theme, skinShadow: skinShadow, withLashes: withLashes);
    case Eyes.happy:
      renderHappyEyes(svg, theme: theme);
    case Eyes.content:
      renderContentEyes(svg, theme: theme);
    case Eyes.squint:
      renderSquintEyes(svg,
          theme: theme,
          skinBase: skinBase,
          skinShadow: skinShadow,
          withLashes: withLashes);
    case Eyes.simple:
      renderSimpleEyes(svg, theme: theme);
    case Eyes.dizzy:
      renderDizzyEyes(svg, theme: theme);
    case Eyes.wink:
      renderWinkEyes(svg,
          theme: theme, skinShadow: skinShadow, withLashes: withLashes);
    case Eyes.heart:
      renderHeartEyes(svg,
          theme: theme, skinShadow: skinShadow, withLashes: withLashes);
    case Eyes.leftTwitch:
      renderLeftTwitchEyes(svg,
          theme: theme,
          skinBase: skinBase,
          skinShadow: skinShadow,
          withLashes: withLashes);
  }
}
