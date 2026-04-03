import 'enums.dart';

/// A pair of colors representing the base color and its shadow.
class ColorPair {
  /// The main/base color as a hex string.
  final String base;

  /// The shadow color as a hex string.
  final String shadow;

  const ColorPair(this.base, this.shadow);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ColorPair && base == other.base && shadow == other.shadow;

  @override
  int get hashCode => Object.hash(base, shadow);

  @override
  String toString() => 'ColorPair($base, $shadow)';
}

/// Color theme used for rendering a BeanHead avatar.
class BeanheadsTheme {
  /// Skin tone color mappings.
  final Map<SkinTone, ColorPair> skinColors;

  /// Hair color mappings.
  final Map<HairColor, ColorPair> hairColors;

  /// Lip color mappings.
  final Map<LipColor, ColorPair> lipColors;

  /// Clothing color mappings.
  final Map<ClothingColor, ColorPair> clothingColors;

  /// Outline color used for strokes.
  final String outline;

  /// Tongue color.
  final String tongue;

  /// White color constant.
  final String white;

  const BeanheadsTheme({
    required this.skinColors,
    required this.hairColors,
    required this.lipColors,
    required this.clothingColors,
    required this.outline,
    required this.tongue,
    required this.white,
  });

  /// Resolves a [HatColor] to a [ColorPair] using the clothing color map.
  ColorPair hatColor(HatColor color) {
    switch (color) {
      case HatColor.white: return clothingColors[ClothingColor.white]!;
      case HatColor.blue: return clothingColors[ClothingColor.blue]!;
      case HatColor.black: return clothingColors[ClothingColor.black]!;
      case HatColor.green: return clothingColors[ClothingColor.green]!;
      case HatColor.red: return clothingColors[ClothingColor.red]!;
    }
  }

  /// Resolves a [FaceMaskColor] to a [ColorPair] using the clothing color map.
  ColorPair faceMaskColor(FaceMaskColor color) {
    switch (color) {
      case FaceMaskColor.white: return clothingColors[ClothingColor.white]!;
      case FaceMaskColor.blue: return clothingColors[ClothingColor.blue]!;
      case FaceMaskColor.black: return clothingColors[ClothingColor.black]!;
      case FaceMaskColor.green: return clothingColors[ClothingColor.green]!;
      case FaceMaskColor.red: return clothingColors[ClothingColor.red]!;
    }
  }
}

/// The default theme matching the original BeanHeads library.
const defaultTheme = BeanheadsTheme(
  skinColors: {
    SkinTone.light: ColorPair('#fdd2b2', '#f3ab98'),
    SkinTone.yellow: ColorPair('#FBE8B3', '#EDD494'),
    SkinTone.brown: ColorPair('#D8985D', '#C6854E'),
    SkinTone.dark: ColorPair('#A56941', '#8D5638'),
    SkinTone.red: ColorPair('#CC734C', '#B56241'),
    SkinTone.black: ColorPair('#754437', '#6B3D34'),
  },
  hairColors: {
    HairColor.blonde: ColorPair('#FEDC58', '#EDBF2E'),
    HairColor.orange: ColorPair('#D96E27', '#C65C22'),
    HairColor.black: ColorPair('#592d3d', '#592d3d'),
    HairColor.white: ColorPair('#ffffff', '#E2E2E2'),
    HairColor.brown: ColorPair('#A56941', '#8D5638'),
    HairColor.blue: ColorPair('#85c5e5', '#67B7D6'),
    HairColor.pink: ColorPair('#D69AC7', '#C683B4'),
  },
  lipColors: {
    LipColor.red: ColorPair('#DD3E3E', '#C43333'),
    LipColor.purple: ColorPair('#B256A1', '#9C4490'),
    LipColor.pink: ColorPair('#D69AC7', '#C683B4'),
    LipColor.turquoise: ColorPair('#5CCBF1', '#49B5CD'),
    LipColor.green: ColorPair('#4AB749', '#3CA047'),
  },
  clothingColors: {
    ClothingColor.white: ColorPair('#FFFFFF', '#E2E2E2'),
    ClothingColor.blue: ColorPair('#85c5e5', '#67B7D6'),
    ClothingColor.black: ColorPair('#633749', '#5E3244'),
    ClothingColor.green: ColorPair('#89D86F', '#7DC462'),
    ClothingColor.red: ColorPair('#D67070', '#C46565'),
  },
  outline: '#592d3d',
  tongue: '#f28195',
  white: '#ffffff',
);
