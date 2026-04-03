import 'package:flutter_test/flutter_test.dart';
import 'package:beanheads/beanheads.dart';

void main() {
  group('SkinTone', () {
    test('has 6 values', () {
      expect(SkinTone.values.length, 6);
    });

    test('has expected value names', () {
      expect(
        SkinTone.values.map((e) => e.name).toList(),
        ['light', 'yellow', 'brown', 'dark', 'red', 'black'],
      );
    });
  });

  group('Eyes', () {
    test('has 9 values', () {
      expect(Eyes.values.length, 9);
    });

    test('has expected value names', () {
      expect(
        Eyes.values.map((e) => e.name).toList(),
        [
          'normal',
          'leftTwitch',
          'happy',
          'content',
          'squint',
          'simple',
          'dizzy',
          'wink',
          'heart',
        ],
      );
    });
  });

  group('Eyebrows', () {
    test('has 5 values', () {
      expect(Eyebrows.values.length, 5);
    });

    test('has expected value names', () {
      expect(
        Eyebrows.values.map((e) => e.name).toList(),
        ['raised', 'leftLowered', 'serious', 'angry', 'concerned'],
      );
    });
  });

  group('Mouth', () {
    test('has 7 values', () {
      expect(Mouth.values.length, 7);
    });

    test('has expected value names', () {
      expect(
        Mouth.values.map((e) => e.name).toList(),
        ['grin', 'sad', 'openSmile', 'lips', 'open', 'serious', 'tongue'],
      );
    });
  });

  group('Hair', () {
    test('has 9 values', () {
      expect(Hair.values.length, 9);
    });

    test('has expected value names', () {
      expect(
        Hair.values.map((e) => e.name).toList(),
        ['none', 'long', 'bun', 'short', 'pixie', 'balding', 'buzz', 'afro', 'bob'],
      );
    });
  });

  group('FacialHair', () {
    test('has 3 values', () {
      expect(FacialHair.values.length, 3);
    });

    test('has expected value names', () {
      expect(
        FacialHair.values.map((e) => e.name).toList(),
        ['none', 'stubble', 'mediumBeard'],
      );
    });
  });

  group('Clothing', () {
    test('has 6 values', () {
      expect(Clothing.values.length, 6);
    });

    test('has expected value names', () {
      expect(
        Clothing.values.map((e) => e.name).toList(),
        ['naked', 'shirt', 'dressShirt', 'vneck', 'tankTop', 'dress'],
      );
    });
  });

  group('Accessory', () {
    test('has 4 values', () {
      expect(Accessory.values.length, 4);
    });

    test('has expected value names', () {
      expect(
        Accessory.values.map((e) => e.name).toList(),
        ['none', 'roundGlasses', 'tinyGlasses', 'shades'],
      );
    });
  });

  group('ClothingGraphic', () {
    test('has 6 values', () {
      expect(ClothingGraphic.values.length, 6);
    });

    test('has expected value names', () {
      expect(
        ClothingGraphic.values.map((e) => e.name).toList(),
        ['none', 'redwood', 'gatsby', 'vue', 'react', 'graphQL'],
      );
    });
  });

  group('Hat', () {
    test('has 3 values', () {
      expect(Hat.values.length, 3);
    });

    test('has expected value names', () {
      expect(
        Hat.values.map((e) => e.name).toList(),
        ['none', 'beanie', 'turban'],
      );
    });
  });

  group('Body', () {
    test('has 2 values', () {
      expect(Body.values.length, 2);
    });

    test('has expected value names', () {
      expect(
        Body.values.map((e) => e.name).toList(),
        ['chest', 'breasts'],
      );
    });
  });

  group('HairColor', () {
    test('has 7 values', () {
      expect(HairColor.values.length, 7);
    });

    test('has expected value names', () {
      expect(
        HairColor.values.map((e) => e.name).toList(),
        ['blonde', 'orange', 'black', 'white', 'brown', 'blue', 'pink'],
      );
    });
  });

  group('ClothingColor', () {
    test('has 5 values', () {
      expect(ClothingColor.values.length, 5);
    });

    test('has expected value names', () {
      expect(
        ClothingColor.values.map((e) => e.name).toList(),
        ['white', 'blue', 'black', 'green', 'red'],
      );
    });
  });

  group('LipColor', () {
    test('has 5 values', () {
      expect(LipColor.values.length, 5);
    });

    test('has expected value names', () {
      expect(
        LipColor.values.map((e) => e.name).toList(),
        ['red', 'purple', 'pink', 'turquoise', 'green'],
      );
    });
  });

  group('HatColor', () {
    test('has 5 values', () {
      expect(HatColor.values.length, 5);
    });

    test('has expected value names', () {
      expect(
        HatColor.values.map((e) => e.name).toList(),
        ['white', 'blue', 'black', 'green', 'red'],
      );
    });
  });

  group('FaceMaskColor', () {
    test('has 5 values', () {
      expect(FaceMaskColor.values.length, 5);
    });

    test('has expected value names', () {
      expect(
        FaceMaskColor.values.map((e) => e.name).toList(),
        ['white', 'blue', 'black', 'green', 'red'],
      );
    });
  });
}
