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
  final CircleColor circleColor;
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
    this.circleColor = CircleColor.blue,
    this.lipColor = LipColor.red,
    this.hatColor = HatColor.white,
    this.faceMaskColor = FaceMaskColor.white,
    this.mask = true,
    this.faceMask = false,
    this.lashes = false,
  });

  /// Generate a random avatar configuration.
  ///
  /// If [random] is not provided, a new [Random] instance is used.
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
      circleColor: pick(CircleColor.values),
      lipColor: pick(LipColor.values),
      hatColor: pick(HatColor.values),
      faceMaskColor: pick(FaceMaskColor.values),
      mask: true,
      faceMask: false,
      lashes: rng.nextBool(),
    );
  }
}
