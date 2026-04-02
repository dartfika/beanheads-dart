import 'package:flutter_test/flutter_test.dart';
import 'package:beanheads/beanheads.dart';

void main() {
  group('hat scale with different hair styles', () {
    test('long hair + beanie should use scale(1.12) centered transform', () {
      final svg = generateAvatar(const BeanheadConfig(
        hair: Hair.long,
        hat: Hat.beanie,
      ));
      expect(
        svg,
        contains('translate(500, 495) scale(1.12) translate(-500, -495)'),
        reason: 'Long hair + beanie should scale hat to 1.12 from center',
      );
    });

    test('bob hair + beanie should use scale(1.12) centered transform', () {
      final svg = generateAvatar(const BeanheadConfig(
        hair: Hair.bob,
        hat: Hat.beanie,
      ));
      expect(
        svg,
        contains('translate(500, 495) scale(1.12) translate(-500, -495)'),
        reason: 'Bob hair + beanie should scale hat to 1.12 from center',
      );
    });

    test('short hair + beanie should use scale(1.0) centered transform', () {
      final svg = generateAvatar(const BeanheadConfig(
        hair: Hair.short,
        hat: Hat.beanie,
      ));
      expect(
        svg,
        contains('translate(500, 495) scale(1.0) translate(-500, -495)'),
      );
    });

    test('long hair + turban should use scale(1.12) centered transform', () {
      final svg = generateAvatar(const BeanheadConfig(
        hair: Hair.long,
        hat: Hat.turban,
      ));
      expect(
        svg,
        contains('translate(500, 495) scale(1.12) translate(-500, -495)'),
        reason: 'Long hair + turban should scale hat to 1.12 from center',
      );
    });

    test('bob hair + turban should use scale(1.12) centered transform', () {
      final svg = generateAvatar(const BeanheadConfig(
        hair: Hair.bob,
        hat: Hat.turban,
      ));
      expect(
        svg,
        contains('translate(500, 495) scale(1.12) translate(-500, -495)'),
        reason: 'Bob hair + turban should scale hat to 1.12 from center',
      );
    });

    test('afro + beanie should use scale(0.0) - hat hidden', () {
      final svg = generateAvatar(const BeanheadConfig(
        hair: Hair.afro,
        hat: Hat.beanie,
      ));
      expect(
        svg,
        contains('translate(500, 495) scale(0.0) translate(-500, -495)'),
        reason: 'Afro + beanie should scale hat to 0 (hidden)',
      );
    });
  });
}
