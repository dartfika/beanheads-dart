import 'config.dart';
import 'theme.dart';
import 'enums.dart';
import 'svg_builder.dart';
import 'components/base.dart';
import 'components/bg_circle.dart';
import 'components/mask.dart';
import 'components/face_mask.dart' as face_mask_component;
import 'components/eyes/eyes.dart' as eyes_component;
import 'components/eyebrows/eyebrows.dart' as eyebrows_component;
import 'components/mouths/mouths.dart' as mouths_component;
import 'components/facial_hair/facial_hair.dart' as facial_hair_component;
import 'components/hair/hair.dart';
import 'components/hats/hats.dart';
import 'components/accessories/accessories.dart' as accessories_component;
import 'components/clothing/clothing.dart';
import 'components/clothing_graphic/clothing_graphic.dart';
import 'components/bodies/bodies.dart';

/// Generates a complete BeanHead avatar as an SVG string.
///
/// Takes a [BeanheadConfig] that describes the avatar's appearance and an
/// optional [BeanheadsTheme] for color customization (defaults to [defaultTheme]).
String generateAvatar(BeanheadConfig config, {BeanheadsTheme? theme}) {
  final t = theme ?? defaultTheme;

  // Resolve colors from the theme based on config enum values.
  final skinColor = t.skinColors[config.skinTone]!;
  final hairColor = t.hairColors[config.hairColor]!;
  final clothingColor = t.clothingColors[config.clothingColor]!;
  final circleColor = config.circleColor;
  final hatColorPair = t.hatColor(config.hatColor);
  final faceMaskColor = t.faceMaskColor(config.faceMaskColor);
  final outline = t.outline;
  final white = t.white;
  final whiteColor = t.clothingColors[ClothingColor.white]!;

  // Determine hat presence.
  final hasHat = config.hat != Hat.none;

  // Get hair renderers (must be resolved before hats for hatScale).
  final hairResult = getHairRenderers(
    type: config.hair,
    hairColor: hairColor,
    skinShadow: skinColor.shadow,
    outline: outline,
    white: white,
    hasHat: hasHat,
  );

  // Get hat renderers, using hair's hatScale if available.
  final hatResult = getHatRenderers(
    type: config.hat,
    hatColor: hatColorPair,
    outline: outline,
    white: white,
    scale: hairResult.hatScale ?? 1,
  );

  // Get clothing graphic renderer.
  final graphicRenderer = getClothingGraphicRenderer(
    type: config.graphic,
    white: white,
  );

  // Get clothing renderers.
  final clothingResult = getClothingRenderers(
    type: config.clothing,
    color: clothingColor,
    skinColor: skinColor,
    outline: outline,
    white: white,
    whiteColor: whiteColor,
    renderGraphic: graphicRenderer,
  );

  // Resolve the body color: DressShirt overrides it to white.
  final bodyColor = clothingResult.bodyColorOverride ?? clothingColor;

  // Get body renderers.
  final bodyResult = getBodyRenderers(
    type: config.body,
    clothingColor: bodyColor,
    skinColor: skinColor,
    outline: outline,
    white: white,
    braStraps: clothingResult.braStraps,
  );

  // Determine whether to skip front body rendering when naked.
  final isNaked = config.clothing == Clothing.naked;

  // Build the SVG.
  final svg = SvgBuilder();

  // Open the root <svg> element.
  svg.openSvg(width: 1000, height: 990, viewBox: '0 0 1000 990');

  // Render the base avatar with all component callbacks in layer order.
  renderBase(
    svg,
    skinColor: skinColor,
    outlineColor: outline,
    viewBox: '0 0 1000 990',
    renderMask: config.mask ? (s) => renderMaskDef(s, id: 'mask') : null,
    renderBgCircle: (s) => renderBgCircle(s, color: circleColor),
    renderBackHat: hatResult.renderBack,
    renderBackHair: hairResult.renderBack,
    renderBackBody: bodyResult.renderBack,
    renderClothingBack: clothingResult.renderBack,
    renderFrontBody: isNaked ? null : bodyResult.renderFront,
    renderClothingFront: clothingResult.renderFront,
    renderFacialHair: config.faceMask
        ? null
        : (config.facialHair != FacialHair.none
            ? (s) => facial_hair_component.renderFacialHair(
                  s,
                  type: config.facialHair,
                  theme: t,
                  hairColor: config.hairColor,
                )
            : null),
    renderEyes: (s) => eyes_component.renderEyes(
      s,
      type: config.eyes,
      theme: t,
      skinBase: skinColor.base,
      skinShadow: skinColor.shadow,
      withLashes: config.lashes,
    ),
    renderMouth: (s) => mouths_component.renderMouth(
      s,
      type: config.mouth,
      theme: t,
      lipColor: config.lipColor,
    ),
    renderFaceMask: config.faceMask
        ? (s) => face_mask_component.renderFaceMask(
              s,
              maskColor: faceMaskColor,
              skinShadow: skinColor.shadow,
              outlineColor: outline,
            )
        : null,
    renderFrontHair: hairResult.renderFront,
    renderEyebrows: (s) => eyebrows_component.renderEyebrows(
      s,
      type: config.eyebrows,
      theme: t,
    ),
    renderFrontHat: hatResult.renderFront,
    renderAccessory: config.accessory != Accessory.none
        ? (s) => accessories_component.renderAccessory(
              s,
              type: config.accessory,
              outline: outline,
              white: white,
            )
        : null,
  );

  // Close the root <svg> element.
  svg.closeSvg();

  return svg.build();
}
