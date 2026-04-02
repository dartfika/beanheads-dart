import 'package:flutter_test/flutter_test.dart';
import 'package:beanheads/beanheads.dart';

void main() {
  group('Beanhead widget', () {
    testWidgets('renders without errors', (tester) async {
      await tester.pumpWidget(
        const Beanhead(config: BeanheadConfig()),
      );
      // No exception means it rendered successfully.
      expect(tester.takeException(), isNull);
    });

    testWidgets('renders with custom config', (tester) async {
      await tester.pumpWidget(
        const Beanhead(
          config: BeanheadConfig(
            eyes: Eyes.heart,
            mouth: Mouth.grin,
            hair: Hair.afro,
            accessory: Accessory.shades,
          ),
          width: 200,
          height: 200,
        ),
      );
      expect(tester.takeException(), isNull);
    });

    testWidgets('Beanhead.random() renders without errors', (tester) async {
      await tester.pumpWidget(
        Beanhead.random(width: 100, height: 100),
      );
      expect(tester.takeException(), isNull);
    });
  });
}
