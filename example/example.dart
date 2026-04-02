// ignore_for_file: avoid_print

import 'package:beanheads/beanheads.dart';

void main() {
  // Generate a custom avatar
  final config = BeanheadConfig(
    skinTone: SkinTone.light,
    eyes: Eyes.happy,
    mouth: Mouth.grin,
    hair: Hair.long,
    hairColor: HairColor.brown,
    clothing: Clothing.shirt,
    clothingColor: ClothingColor.blue,
  );

  final svg = generateAvatar(config);
  print('Custom avatar SVG length: ${svg.length}');

  // Generate a random avatar
  final randomSvg = generateAvatar(BeanheadConfig.random());
  print('Random avatar SVG length: ${randomSvg.length}');
}
