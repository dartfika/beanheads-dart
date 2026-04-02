import 'package:flutter_test/flutter_test.dart';
import 'package:beanheads/beanheads.dart';

void main() {
  group('generateAvatar()', () {
    test('with default config produces valid SVG', () {
      const config = BeanheadConfig();
      final svg = generateAvatar(config);
      expect(svg, isNotEmpty);
      expect(svg, startsWith('<svg'));
      expect(svg, endsWith('</svg>'));
    });

    test('SVG contains expected viewBox', () {
      const config = BeanheadConfig();
      final svg = generateAvatar(config);
      expect(svg, contains('viewBox="0 0 1000 990"'));
    });

    test('with every skin tone', () {
      for (final tone in SkinTone.values) {
        final svg = generateAvatar(BeanheadConfig(skinTone: tone));
        expect(svg, startsWith('<svg'), reason: 'Failed for skinTone: $tone');
        expect(svg, endsWith('</svg>'), reason: 'Failed for skinTone: $tone');
      }
    });

    test('with every eye type', () {
      for (final eye in Eyes.values) {
        final svg = generateAvatar(BeanheadConfig(eyes: eye));
        expect(svg, startsWith('<svg'), reason: 'Failed for eyes: $eye');
        expect(svg, endsWith('</svg>'), reason: 'Failed for eyes: $eye');
      }
    });

    test('with every eyebrow type', () {
      for (final brow in Eyebrows.values) {
        final svg = generateAvatar(BeanheadConfig(eyebrows: brow));
        expect(svg, startsWith('<svg'), reason: 'Failed for eyebrows: $brow');
        expect(svg, endsWith('</svg>'), reason: 'Failed for eyebrows: $brow');
      }
    });

    test('with every mouth type', () {
      for (final mouth in Mouth.values) {
        final svg = generateAvatar(BeanheadConfig(mouth: mouth));
        expect(svg, startsWith('<svg'), reason: 'Failed for mouth: $mouth');
        expect(svg, endsWith('</svg>'), reason: 'Failed for mouth: $mouth');
      }
    });

    test('with every hair type', () {
      for (final hair in Hair.values) {
        final svg = generateAvatar(BeanheadConfig(hair: hair));
        expect(svg, startsWith('<svg'), reason: 'Failed for hair: $hair');
        expect(svg, endsWith('</svg>'), reason: 'Failed for hair: $hair');
      }
    });

    test('with every facial hair type', () {
      for (final fh in FacialHair.values) {
        final svg = generateAvatar(BeanheadConfig(facialHair: fh));
        expect(svg, startsWith('<svg'), reason: 'Failed for facialHair: $fh');
        expect(svg, endsWith('</svg>'), reason: 'Failed for facialHair: $fh');
      }
    });

    test('with every clothing type', () {
      for (final clothing in Clothing.values) {
        final svg = generateAvatar(BeanheadConfig(clothing: clothing));
        expect(svg, startsWith('<svg'),
            reason: 'Failed for clothing: $clothing');
        expect(svg, endsWith('</svg>'),
            reason: 'Failed for clothing: $clothing');
      }
    });

    test('with every accessory', () {
      for (final acc in Accessory.values) {
        final svg = generateAvatar(BeanheadConfig(accessory: acc));
        expect(svg, startsWith('<svg'), reason: 'Failed for accessory: $acc');
        expect(svg, endsWith('</svg>'), reason: 'Failed for accessory: $acc');
      }
    });

    test('with every graphic', () {
      for (final graphic in ClothingGraphic.values) {
        final svg = generateAvatar(BeanheadConfig(graphic: graphic));
        expect(svg, startsWith('<svg'), reason: 'Failed for graphic: $graphic');
        expect(svg, endsWith('</svg>'),
            reason: 'Failed for graphic: $graphic');
      }
    });

    test('with every hat type', () {
      for (final hat in Hat.values) {
        final svg = generateAvatar(BeanheadConfig(hat: hat));
        expect(svg, startsWith('<svg'), reason: 'Failed for hat: $hat');
        expect(svg, endsWith('</svg>'), reason: 'Failed for hat: $hat');
      }
    });

    test('with every body type', () {
      for (final body in Body.values) {
        final svg = generateAvatar(BeanheadConfig(body: body));
        expect(svg, startsWith('<svg'), reason: 'Failed for body: $body');
        expect(svg, endsWith('</svg>'), reason: 'Failed for body: $body');
      }
    });

    test('with faceMask enabled', () {
      final svg = generateAvatar(const BeanheadConfig(faceMask: true));
      expect(svg, startsWith('<svg'));
      expect(svg, endsWith('</svg>'));
    });

    test('with mask disabled', () {
      final svg = generateAvatar(const BeanheadConfig(mask: false));
      expect(svg, startsWith('<svg'));
      expect(svg, endsWith('</svg>'));
    });

    test('with lashes enabled', () {
      final svg = generateAvatar(const BeanheadConfig(lashes: true));
      expect(svg, startsWith('<svg'));
      expect(svg, endsWith('</svg>'));
    });

    test('with lashes disabled', () {
      final svg = generateAvatar(const BeanheadConfig(lashes: false));
      expect(svg, startsWith('<svg'));
      expect(svg, endsWith('</svg>'));
    });

    test('random config generates valid SVG', () {
      final config = BeanheadConfig.random();
      final svg = generateAvatar(config);
      expect(svg, startsWith('<svg'));
      expect(svg, endsWith('</svg>'));
    });

    test('dress + breasts combination', () {
      final svg = generateAvatar(const BeanheadConfig(
        clothing: Clothing.dress,
        body: Body.breasts,
      ));
      expect(svg, startsWith('<svg'));
      expect(svg, endsWith('</svg>'));
    });

    test('dressShirt combination', () {
      final svg = generateAvatar(const BeanheadConfig(
        clothing: Clothing.dressShirt,
      ));
      expect(svg, startsWith('<svg'));
      expect(svg, endsWith('</svg>'));
    });

    test('afro + beanie combination', () {
      final svg = generateAvatar(const BeanheadConfig(
        hair: Hair.afro,
        hat: Hat.beanie,
      ));
      expect(svg, startsWith('<svg'));
      expect(svg, endsWith('</svg>'));
    });

    test('vneck + graphic combination', () {
      final svg = generateAvatar(const BeanheadConfig(
        clothing: Clothing.vneck,
        graphic: ClothingGraphic.vue,
      ));
      expect(svg, startsWith('<svg'));
      expect(svg, endsWith('</svg>'));
    });

    test('tankTop + breasts combination', () {
      final svg = generateAvatar(const BeanheadConfig(
        clothing: Clothing.tankTop,
        body: Body.breasts,
      ));
      expect(svg, startsWith('<svg'));
      expect(svg, endsWith('</svg>'));
    });

    test('turban + long hair combination', () {
      final svg = generateAvatar(const BeanheadConfig(
        hat: Hat.turban,
        hair: Hair.long,
      ));
      expect(svg, startsWith('<svg'));
      expect(svg, endsWith('</svg>'));
    });

    test('faceMask hides facial hair', () {
      final svgWithBeard = generateAvatar(const BeanheadConfig(
        facialHair: FacialHair.mediumBeard,
        faceMask: false,
      ));
      final svgWithMask = generateAvatar(const BeanheadConfig(
        facialHair: FacialHair.mediumBeard,
        faceMask: true,
      ));
      // Both should be valid SVG, but content will differ.
      expect(svgWithBeard, startsWith('<svg'));
      expect(svgWithMask, startsWith('<svg'));
      expect(svgWithBeard, isNot(equals(svgWithMask)));
    });

    test('naked clothing with chest body', () {
      final svg = generateAvatar(const BeanheadConfig(
        clothing: Clothing.naked,
        body: Body.chest,
      ));
      expect(svg, startsWith('<svg'));
      expect(svg, endsWith('</svg>'));
    });

    test('all accessories produce different SVG', () {
      final svgs = <String>{};
      for (final acc in Accessory.values) {
        final svg = generateAvatar(BeanheadConfig(accessory: acc));
        svgs.add(svg);
      }
      // At least 'none' and one actual accessory should differ.
      expect(svgs.length, greaterThan(1));
    });
  });
}
