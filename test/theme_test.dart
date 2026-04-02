import 'package:flutter_test/flutter_test.dart';
import 'package:beanheads/beanheads.dart';

void main() {
  group('defaultTheme', () {
    test('has all skin tone colors', () {
      for (final tone in SkinTone.values) {
        expect(defaultTheme.skinColors.containsKey(tone), isTrue,
            reason: 'Missing skin color for $tone');
      }
    });

    test('has all hair colors', () {
      for (final color in HairColor.values) {
        expect(defaultTheme.hairColors.containsKey(color), isTrue,
            reason: 'Missing hair color for $color');
      }
    });

    test('has all clothing colors', () {
      for (final color in ClothingColor.values) {
        expect(defaultTheme.clothingColors.containsKey(color), isTrue,
            reason: 'Missing clothing color for $color');
      }
    });

    test('has all lip colors', () {
      for (final color in LipColor.values) {
        expect(defaultTheme.lipColors.containsKey(color), isTrue,
            reason: 'Missing lip color for $color');
      }
    });

    test('has all circle colors', () {
      for (final color in CircleColor.values) {
        expect(defaultTheme.circleColors.containsKey(color), isTrue,
            reason: 'Missing circle color for $color');
      }
    });
  });

  group('color constants', () {
    test('outline is a non-empty hex string', () {
      expect(defaultTheme.outline, isNotEmpty);
      expect(defaultTheme.outline, startsWith('#'));
    });

    test('tongue is a non-empty hex string', () {
      expect(defaultTheme.tongue, isNotEmpty);
      expect(defaultTheme.tongue, startsWith('#'));
    });

    test('white is #ffffff', () {
      expect(defaultTheme.white, '#ffffff');
    });
  });

  group('ColorPair', () {
    test('all skin color pairs have non-empty base and shadow', () {
      for (final pair in defaultTheme.skinColors.values) {
        expect(pair.base, isNotEmpty);
        expect(pair.shadow, isNotEmpty);
      }
    });

    test('all hair color pairs have non-empty base and shadow', () {
      for (final pair in defaultTheme.hairColors.values) {
        expect(pair.base, isNotEmpty);
        expect(pair.shadow, isNotEmpty);
      }
    });

    test('all clothing color pairs have non-empty base and shadow', () {
      for (final pair in defaultTheme.clothingColors.values) {
        expect(pair.base, isNotEmpty);
        expect(pair.shadow, isNotEmpty);
      }
    });

    test('all lip color pairs have non-empty base and shadow', () {
      for (final pair in defaultTheme.lipColors.values) {
        expect(pair.base, isNotEmpty);
        expect(pair.shadow, isNotEmpty);
      }
    });
  });

  group('hatColor resolver', () {
    test('resolves all hat colors via clothing color map', () {
      for (final color in HatColor.values) {
        final pair = defaultTheme.hatColor(color);
        expect(pair.base, isNotEmpty);
        expect(pair.shadow, isNotEmpty);
      }
    });
  });

  group('faceMaskColor resolver', () {
    test('resolves all face mask colors via clothing color map', () {
      for (final color in FaceMaskColor.values) {
        final pair = defaultTheme.faceMaskColor(color);
        expect(pair.base, isNotEmpty);
        expect(pair.shadow, isNotEmpty);
      }
    });
  });
}
