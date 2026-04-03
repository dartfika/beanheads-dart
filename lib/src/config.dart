import 'dart:math';

import 'enums.dart';

/// Configuration for generating a BeanHead avatar.
///
/// Each field corresponds to a visual property of the avatar.
/// All fields have sensible defaults and can be overridden individually.
class BeanheadConfig {
  final SkinTone skinTone;
  final Eyes eyes;
  final Eyebrows eyebrows;
  final Mouth mouth;
  final Hair hair;
  final FacialHair facialHair;
  final Clothing clothing;
  final Accessory accessory;
  final ClothingGraphic graphic;
  final Hat hat;
  final Body body;
  final HairColor hairColor;
  final ClothingColor clothingColor;
  final String circleColor;
  final LipColor lipColor;
  final HatColor hatColor;
  final FaceMaskColor faceMaskColor;
  final bool mask;
  final bool faceMask;
  final bool lashes;

  const BeanheadConfig({
    this.skinTone = SkinTone.light,
    this.eyes = Eyes.normal,
    this.eyebrows = Eyebrows.raised,
    this.mouth = Mouth.grin,
    this.hair = Hair.none,
    this.facialHair = FacialHair.none,
    this.clothing = Clothing.shirt,
    this.accessory = Accessory.none,
    this.graphic = ClothingGraphic.none,
    this.hat = Hat.none,
    this.body = Body.chest,
    this.hairColor = HairColor.brown,
    this.clothingColor = ClothingColor.white,
    this.circleColor = '#85c5e5',
    this.lipColor = LipColor.red,
    this.hatColor = HatColor.white,
    this.faceMaskColor = FaceMaskColor.white,
    this.mask = true,
    this.faceMask = false,
    this.lashes = false,
  });

  /// Returns a copy of this config with the given fields replaced.
  BeanheadConfig copyWith({
    SkinTone? skinTone,
    Eyes? eyes,
    Eyebrows? eyebrows,
    Mouth? mouth,
    Hair? hair,
    FacialHair? facialHair,
    Clothing? clothing,
    Accessory? accessory,
    ClothingGraphic? graphic,
    Hat? hat,
    Body? body,
    HairColor? hairColor,
    ClothingColor? clothingColor,
    String? circleColor,
    LipColor? lipColor,
    HatColor? hatColor,
    FaceMaskColor? faceMaskColor,
    bool? mask,
    bool? faceMask,
    bool? lashes,
  }) {
    return BeanheadConfig(
      skinTone: skinTone ?? this.skinTone,
      eyes: eyes ?? this.eyes,
      eyebrows: eyebrows ?? this.eyebrows,
      mouth: mouth ?? this.mouth,
      hair: hair ?? this.hair,
      facialHair: facialHair ?? this.facialHair,
      clothing: clothing ?? this.clothing,
      accessory: accessory ?? this.accessory,
      graphic: graphic ?? this.graphic,
      hat: hat ?? this.hat,
      body: body ?? this.body,
      hairColor: hairColor ?? this.hairColor,
      clothingColor: clothingColor ?? this.clothingColor,
      circleColor: circleColor ?? this.circleColor,
      lipColor: lipColor ?? this.lipColor,
      hatColor: hatColor ?? this.hatColor,
      faceMaskColor: faceMaskColor ?? this.faceMaskColor,
      mask: mask ?? this.mask,
      faceMask: faceMask ?? this.faceMask,
      lashes: lashes ?? this.lashes,
    );
  }

  /// Generate a random avatar configuration.
  ///
  /// If [random] is not provided, a new [Random] instance is used.
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BeanheadConfig &&
          runtimeType == other.runtimeType &&
          skinTone == other.skinTone &&
          eyes == other.eyes &&
          eyebrows == other.eyebrows &&
          mouth == other.mouth &&
          hair == other.hair &&
          facialHair == other.facialHair &&
          clothing == other.clothing &&
          accessory == other.accessory &&
          graphic == other.graphic &&
          hat == other.hat &&
          body == other.body &&
          hairColor == other.hairColor &&
          clothingColor == other.clothingColor &&
          circleColor == other.circleColor &&
          lipColor == other.lipColor &&
          hatColor == other.hatColor &&
          faceMaskColor == other.faceMaskColor &&
          mask == other.mask &&
          faceMask == other.faceMask &&
          lashes == other.lashes;

  @override
  int get hashCode => Object.hash(
        skinTone, eyes, eyebrows, mouth, hair,
        facialHair, clothing, accessory, graphic, hat,
        body, hairColor, clothingColor, circleColor, lipColor,
        hatColor, faceMaskColor, mask, faceMask, lashes,
      );

  @override
  String toString() => 'BeanheadConfig('
      'skinTone: $skinTone, eyes: $eyes, eyebrows: $eyebrows, '
      'mouth: $mouth, hair: $hair, facialHair: $facialHair, '
      'clothing: $clothing, accessory: $accessory, graphic: $graphic, '
      'hat: $hat, body: $body, hairColor: $hairColor, '
      'clothingColor: $clothingColor, circleColor: $circleColor, lipColor: $lipColor, '
      'hatColor: $hatColor, faceMaskColor: $faceMaskColor, '
      'mask: $mask, faceMask: $faceMask, lashes: $lashes)';

  factory BeanheadConfig.random({Random? random}) {
    final rng = random ?? Random();

    T pick<T>(List<T> values) => values[rng.nextInt(values.length)];

    // Weighted facial hair selection: ~60% chance of none.
    // Original has 3 "none" variants out of 5 total options.
    final facialHairOptions = [
      FacialHair.none,
      FacialHair.none,
      FacialHair.none,
      FacialHair.stubble,
      FacialHair.mediumBeard,
    ];

    // Weighted hat selection: ~71% chance of none.
    // Original has 5 "none" variants out of 7 total options.
    final hatOptions = [
      Hat.none,
      Hat.none,
      Hat.none,
      Hat.none,
      Hat.none,
      Hat.beanie,
      Hat.turban,
    ];

    return BeanheadConfig(
      skinTone: pick(SkinTone.values),
      eyes: pick(Eyes.values),
      eyebrows: pick(Eyebrows.values),
      mouth: pick(Mouth.values),
      hair: pick(Hair.values),
      facialHair: pick(facialHairOptions),
      clothing: pick(Clothing.values),
      accessory: pick(Accessory.values),
      graphic: pick(ClothingGraphic.values),
      hat: pick(hatOptions),
      body: pick(Body.values),
      hairColor: pick(HairColor.values),
      clothingColor: pick(ClothingColor.values),
      circleColor: pick(const [
        '#85c5e5', // Default
        '#E0E0E0', // Grey 300
        '#9E9E9E', // Grey 500
        '#B39DDB', // Deep Purple 200
        '#9575CD', // Deep Purple 300
        '#7E57C2', // Deep Purple 400
        '#673AB7', // Deep Purple 500
        '#80DEEA', // Cyan 200
        '#4FC3F7', // Light Blue 300
        '#2196F3', // Blue 500
        '#A5D6A7', // Green 200
        '#66BB6A', // Green 400
        '#AED581', // Light Green 300
        '#7CB342', // Light Green 600
        '#FFF59D', // Yellow 200
        '#FFE082', // Amber 200
        '#FFB74D', // Orange 300
        '#F8BBD0', // Pink 100
        '#F48FB1', // Pink 200
        '#EC407A', // Pink 400
        '#EF9A9A', // Red 200
        '#E57373', // Red 300
        '#E53935', // Red 600
        '#CE93D8', // Purple 200
        '#AB47BC', // Purple 400
        '#8E24AA', // Purple 600
        '#6A1B9A', // Purple 800
      ]),
      lipColor: pick(LipColor.values),
      hatColor: pick(HatColor.values),
      faceMaskColor: pick(FaceMaskColor.values),
      mask: true,
      faceMask: false,
      lashes: rng.nextBool(),
    );
  }
}
