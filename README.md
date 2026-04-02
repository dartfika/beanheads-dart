# BeanHeads

A customizable cartoon avatar generator for Dart and Flutter. Generates SVG strings that can be used anywhere.

Dart port of [BeanHeads](https://github.com/RobertBroersma/beanheads) by Robert Broersma.

## Features

- 17 customizable dimensions (eyes, hair, clothing, accessories, etc.)
- Random avatar generation with optional seed for deterministic results
- Pure Dart SVG generation -- works on server, CLI, and Flutter
- Flutter widget included for easy integration

## Installation

Add to your `pubspec.yaml`:

```yaml
dependencies:
  beanheads: ^0.0.1
```

## Usage

### Generate SVG String (Pure Dart)

```dart
import 'package:beanheads/beanheads.dart';

// With specific configuration
final config = BeanheadConfig(
  skinTone: SkinTone.light,
  eyes: Eyes.happy,
  hair: Hair.long,
  hairColor: HairColor.brown,
  clothing: Clothing.dressShirt,
);

final svgString = generateAvatar(config);

// Random avatar
final randomConfig = BeanheadConfig.random();
final randomSvg = generateAvatar(randomConfig);

// Deterministic random avatar (same seed = same avatar)
final seededConfig = BeanheadConfig.random(random: Random(42));
```

### Flutter Widget

```dart
import 'package:beanheads/beanheads.dart';

// With configuration
Beanhead(
  config: BeanheadConfig(
    eyes: Eyes.heart,
    mouth: Mouth.grin,
    hair: Hair.afro,
    accessory: Accessory.shades,
  ),
  width: 200,
  height: 200,
)

// Random avatar
Beanhead.random(
  width: 200,
  height: 200,
)
```

## Customization Options

| Option | Values |
|---|---|
| `skinTone` | light, yellow, brown, dark, red, black |
| `eyes` | normal, leftTwitch, happy, content, squint, simple, dizzy, wink, heart |
| `eyebrows` | raised, leftLowered, serious, angry, concerned |
| `mouth` | grin, sad, openSmile, lips, open, serious, tongue |
| `hair` | none, long, bun, short, pixie, balding, buzz, afro, bob |
| `facialHair` | none, stubble, mediumBeard |
| `clothing` | naked, shirt, dressShirt, vneck, tankTop, dress |
| `accessory` | none, roundGlasses, tinyGlasses, shades |
| `graphic` | none, redwood, gatsby, vue, react, graphQL |
| `hat` | none, beanie, turban |
| `body` | chest, breasts |
| `hairColor` | blonde, orange, black, white, brown, blue, pink |
| `clothingColor` | white, blue, black, green, red |
| `hatColor` | white, blue, black, green, red |
| `lipColor` | red, purple, pink, turquoise, green |
| `faceMaskColor` | white, blue, black, green, red |
| `lashes` | true, false |
| `mask` | true, false (circular background mask) |
| `faceMask` | true, false (COVID-style face mask) |

## Credits

Based on [BeanHeads](https://github.com/RobertBroersma/beanheads) by [Robert Broersma](https://github.com/RobertBroersma), licensed under MIT.

## License

MIT
