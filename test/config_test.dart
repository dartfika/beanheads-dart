import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:beanheads/beanheads.dart';

void main() {
  group('BeanheadConfig default constructor', () {
    test('has sensible defaults', () {
      const config = BeanheadConfig();
      expect(config.skinTone, SkinTone.light);
      expect(config.eyes, Eyes.normal);
      expect(config.eyebrows, Eyebrows.raised);
      expect(config.mouth, Mouth.grin);
      expect(config.hair, Hair.none);
      expect(config.facialHair, FacialHair.none);
      expect(config.clothing, Clothing.shirt);
      expect(config.accessory, Accessory.none);
      expect(config.graphic, ClothingGraphic.none);
      expect(config.hat, Hat.none);
      expect(config.body, Body.chest);
      expect(config.hairColor, HairColor.brown);
      expect(config.clothingColor, ClothingColor.white);
      expect(config.circleColor, '#85c5e5');
      expect(config.lipColor, LipColor.red);
      expect(config.hatColor, HatColor.white);
      expect(config.faceMaskColor, FaceMaskColor.white);
      expect(config.mask, true);
      expect(config.faceMask, false);
      expect(config.lashes, false);
    });

    test('allows overriding individual properties', () {
      const config = BeanheadConfig(
        skinTone: SkinTone.dark,
        eyes: Eyes.heart,
        lashes: true,
        faceMask: true,
      );
      expect(config.skinTone, SkinTone.dark);
      expect(config.eyes, Eyes.heart);
      expect(config.lashes, true);
      expect(config.faceMask, true);
      // Defaults for non-overridden fields
      expect(config.mouth, Mouth.grin);
      expect(config.hair, Hair.none);
    });
  });

  group('BeanheadConfig.random()', () {
    test('produces a valid config', () {
      final config = BeanheadConfig.random();
      expect(SkinTone.values, contains(config.skinTone));
      expect(Eyes.values, contains(config.eyes));
      expect(Eyebrows.values, contains(config.eyebrows));
      expect(Mouth.values, contains(config.mouth));
      expect(Hair.values, contains(config.hair));
      expect(FacialHair.values, contains(config.facialHair));
      expect(Clothing.values, contains(config.clothing));
      expect(Accessory.values, contains(config.accessory));
      expect(ClothingGraphic.values, contains(config.graphic));
      expect(Hat.values, contains(config.hat));
      expect(Body.values, contains(config.body));
      expect(HairColor.values, contains(config.hairColor));
      expect(ClothingColor.values, contains(config.clothingColor));
      expect(config.circleColor, isA<String>());
      expect(config.circleColor, startsWith('#'));
      expect(LipColor.values, contains(config.lipColor));
      expect(HatColor.values, contains(config.hatColor));
      expect(FaceMaskColor.values, contains(config.faceMaskColor));
      expect(config.mask, isA<bool>());
      expect(config.faceMask, isA<bool>());
      expect(config.lashes, isA<bool>());
    });

    test('with seed produces deterministic results', () {
      final config1 = BeanheadConfig.random(random: Random(42));
      final config2 = BeanheadConfig.random(random: Random(42));

      expect(config1.skinTone, config2.skinTone);
      expect(config1.eyes, config2.eyes);
      expect(config1.eyebrows, config2.eyebrows);
      expect(config1.mouth, config2.mouth);
      expect(config1.hair, config2.hair);
      expect(config1.facialHair, config2.facialHair);
      expect(config1.clothing, config2.clothing);
      expect(config1.accessory, config2.accessory);
      expect(config1.graphic, config2.graphic);
      expect(config1.hat, config2.hat);
      expect(config1.body, config2.body);
      expect(config1.hairColor, config2.hairColor);
      expect(config1.clothingColor, config2.clothingColor);
      expect(config1.lipColor, config2.lipColor);
      expect(config1.hatColor, config2.hatColor);
      expect(config1.lashes, config2.lashes);
    });

    test('different seeds produce different results', () {
      final config1 = BeanheadConfig.random(random: Random(1));
      final config2 = BeanheadConfig.random(random: Random(999));

      // With different seeds, at least some properties should differ.
      final properties1 = [
        config1.skinTone,
        config1.eyes,
        config1.hair,
        config1.clothing,
        config1.hairColor,
      ];
      final properties2 = [
        config2.skinTone,
        config2.eyes,
        config2.hair,
        config2.clothing,
        config2.hairColor,
      ];
      // It's statistically near-impossible for all to be equal.
      expect(properties1, isNot(equals(properties2)));
    });
  });

  group('BeanheadConfig copyWith', () {
    test('copyWith with no args returns equal config', () {
      const original = BeanheadConfig();
      final copy = original.copyWith();
      expect(copy, equals(original));
    });

    test('copyWith with one arg changes only that field', () {
      const original = BeanheadConfig();
      final copy = original.copyWith(eyes: Eyes.heart);
      expect(copy.eyes, Eyes.heart);
      expect(copy.skinTone, original.skinTone);
      expect(copy.mouth, original.mouth);
      expect(copy.hair, original.hair);
      expect(copy.clothing, original.clothing);
    });

    test('copyWith does not mutate the original', () {
      const original = BeanheadConfig();
      original.copyWith(eyes: Eyes.heart, hair: Hair.afro);
      expect(original.eyes, Eyes.normal);
      expect(original.hair, Hair.none);
    });
  });

  group('BeanheadConfig equality and hashCode', () {
    test('equal configs are equal', () {
      const config1 = BeanheadConfig(eyes: Eyes.happy, hair: Hair.long);
      const config2 = BeanheadConfig(eyes: Eyes.happy, hair: Hair.long);
      expect(config1, equals(config2));
    });

    test('different configs are not equal', () {
      const config1 = BeanheadConfig(eyes: Eyes.happy);
      const config2 = BeanheadConfig(eyes: Eyes.wink);
      expect(config1, isNot(equals(config2)));
    });

    test('hashCode is same for equal configs', () {
      const config1 = BeanheadConfig(eyes: Eyes.happy, hair: Hair.long);
      const config2 = BeanheadConfig(eyes: Eyes.happy, hair: Hair.long);
      expect(config1.hashCode, equals(config2.hashCode));
    });

    test('toString contains class name and fields', () {
      const config = BeanheadConfig();
      final str = config.toString();
      expect(str, startsWith('BeanheadConfig('));
      expect(str, contains('skinTone:'));
      expect(str, contains('eyes:'));
    });
  });

  group('BeanheadConfig properties', () {
    test('all properties are accessible', () {
      const config = BeanheadConfig(
        skinTone: SkinTone.brown,
        eyes: Eyes.wink,
        eyebrows: Eyebrows.angry,
        mouth: Mouth.tongue,
        hair: Hair.afro,
        facialHair: FacialHair.mediumBeard,
        clothing: Clothing.dress,
        accessory: Accessory.shades,
        graphic: ClothingGraphic.react,
        hat: Hat.beanie,
        body: Body.breasts,
        hairColor: HairColor.pink,
        clothingColor: ClothingColor.red,
        circleColor: '#85c5e5',
        lipColor: LipColor.turquoise,
        hatColor: HatColor.green,
        faceMaskColor: FaceMaskColor.black,
        mask: false,
        faceMask: true,
        lashes: true,
      );

      expect(config.skinTone, SkinTone.brown);
      expect(config.eyes, Eyes.wink);
      expect(config.eyebrows, Eyebrows.angry);
      expect(config.mouth, Mouth.tongue);
      expect(config.hair, Hair.afro);
      expect(config.facialHair, FacialHair.mediumBeard);
      expect(config.clothing, Clothing.dress);
      expect(config.accessory, Accessory.shades);
      expect(config.graphic, ClothingGraphic.react);
      expect(config.hat, Hat.beanie);
      expect(config.body, Body.breasts);
      expect(config.hairColor, HairColor.pink);
      expect(config.clothingColor, ClothingColor.red);
      expect(config.circleColor, '#85c5e5');
      expect(config.lipColor, LipColor.turquoise);
      expect(config.hatColor, HatColor.green);
      expect(config.faceMaskColor, FaceMaskColor.black);
      expect(config.mask, false);
      expect(config.faceMask, true);
      expect(config.lashes, true);
    });
  });
}
