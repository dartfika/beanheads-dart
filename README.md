# BeanHeads

<p align="center">
  <img src="https://raw.githubusercontent.com/dartfika/beanheads-dart/main/doc/assets/demo.gif" alt="BeanHeads Demo" width="450" />
</p>

A customizable cartoon avatar generator for Dart and Flutter. Generates SVG strings that can be used anywhere.

Dart port of [BeanHeads](https://github.com/RobertBroersma/beanheads) by Robert Broersma.

## Features

- 17 customizable dimensions (eyes, hair, clothing, accessories, etc.)
- Random avatar generation with optional seed for deterministic results
- SVG string generation -- the core produces plain SVG strings you can use anywhere
- Flutter widget included for easy integration (requires Flutter SDK)
- Immutable configuration with `copyWith` support
- Value equality on `BeanheadConfig` and `ColorPair`
- SVG caching in the `Beanhead` widget for efficient rebuilds
- Theming support via `BeanheadsTheme`

## Installation

Add to your `pubspec.yaml`:

```yaml
dependencies:
  beanheads: ^0.1.0
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

### Immutable Updates with copyWith

```dart
final base = BeanheadConfig(eyes: Eyes.normal);
final updated = base.copyWith(eyes: Eyes.happy, hair: Hair.afro);
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

## Example App

An interactive demo app is included that lets you customize avatars in real-time with dropdown selectors, SVG preview thumbnails, and live preview.

### Running the Example

```bash
cd example
flutter pub get
```

#### macOS
```bash
flutter run -d macos
```

#### Windows
```bash
flutter run -d windows
```

#### Linux
```bash
flutter run -d linux
```

#### iOS
```bash
flutter run -d ios
```

#### Android
```bash
flutter run -d android
```

#### Web
```bash
flutter run -d chrome
```

## API Reference

### `BeanheadConfig`

Configuration class holding all avatar customization options. Supports:

- `const` constructor with sensible defaults
- `BeanheadConfig.random({Random? random})` -- generate a random configuration, optionally seeded for deterministic results
- `copyWith(...)` -- create a modified copy (immutable updates)
- Value equality (`==`, `hashCode`) and `toString`

### `generateAvatar(BeanheadConfig config, {BeanheadsTheme? theme})`

Generates a complete avatar as an SVG string. Accepts an optional theme for color customization.

### `Beanhead` Widget

A `StatefulWidget` that renders an avatar from a `BeanheadConfig`. The SVG is cached internally and only regenerated when `config` or `theme` changes.

```dart
Beanhead(config: myConfig, width: 200, height: 200)
```

### `Beanhead.random()`

Factory constructor that creates a widget with a random configuration.

```dart
Beanhead.random(width: 200, height: 200)
Beanhead.random(random: Random(42))  // deterministic
```

### `BeanheadsTheme` / `ColorPair`

`BeanheadsTheme` holds all color mappings (skin, hair, clothing, etc.) used during SVG generation. `ColorPair` represents a base color and its shadow variant. A `defaultTheme` is provided out of the box.

## Contributing

Contributions are welcome! Please open an issue or submit a pull request on [GitHub](https://github.com/dartfika/beanheads-dart).

## Credits

Based on [BeanHeads](https://github.com/RobertBroersma/beanheads) by [Robert Broersma](https://github.com/RobertBroersma), licensed under MIT.

## License

MIT
