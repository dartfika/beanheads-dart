## 0.2.0

### Breaking Changes

- Removed `CircleColor` enum. `BeanheadConfig.circleColor` is now a `String` (hex color value) instead of `CircleColor`. Replace `CircleColor.blue` with `'#85c5e5'`
- Removed `circleColors` field from `BeanheadsTheme`. Circle color is now specified directly as a hex string

### Features

- Circle background color can now be set to any hex color string (e.g., `'#FF5733'`)
- 27 Material Design color presets for random circle color generation
- Example app redesigned with two-column control layout

### Other

- Improved README installation instructions
- Updated CI `actions/checkout` from v4 to v5

## 0.1.1

### Bug Fixes

- Fixed clothing render layer assignment — Shirt, DressShirt, VNeck, and TankTop now correctly render in the back layer, making `Body.breasts` characteristics visible as intended
- Regenerated demo GIF with corrected rendering

## 0.1.0

- Interactive example app with real-time avatar customization and SVG preview thumbnails
- `BeanheadConfig.copyWith()` for immutable state updates
- `BeanheadConfig` equality support (`==`, `hashCode`) and `toString`
- `ColorPair` equality support (`==`, `hashCode`) and `toString`
- `Beanhead` widget SVG caching for better performance
- `Beanhead.random()` now accepts optional `Random` parameter for deterministic results
- Improved hat scaling for Long, Bob, and Afro hair styles using pure SVG transforms
- Removed `SvgBuilder` from public API (internal implementation detail)
- Fixed `HatColor`/`FaceMaskColor` resolution to use explicit mapping instead of name matching

## 0.0.1

- Initial release
- Pure Dart SVG avatar generation
- Flutter widget (`Beanhead`) for easy integration
- 17 customizable dimensions with random avatar generation
- Based on [BeanHeads](https://github.com/RobertBroersma/beanheads) by Robert Broersma
