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
