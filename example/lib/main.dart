import 'package:flutter/material.dart';
import 'package:beanheads/beanheads.dart';

void main() {
  runApp(const BeanheadsExampleApp());
}

class BeanheadsExampleApp extends StatelessWidget {
  const BeanheadsExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BeanHeads Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: const Color(0xFF85C5E5),
        useMaterial3: true,
        brightness: Brightness.light,
      ),
      home: const AvatarCustomizerPage(),
    );
  }
}

class AvatarCustomizerPage extends StatefulWidget {
  const AvatarCustomizerPage({super.key});

  @override
  State<AvatarCustomizerPage> createState() => _AvatarCustomizerPageState();
}

class _AvatarCustomizerPageState extends State<AvatarCustomizerPage> {
  BeanheadConfig _config = BeanheadConfig.random();

  void _randomize() {
    setState(() {
      _config = BeanheadConfig.random();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BeanHeads Demo'),
        centerTitle: true,
        actions: [
          FilledButton.icon(
            onPressed: _randomize,
            icon: const Icon(Icons.shuffle),
            label: const Text('Randomize'),
          ),
          const SizedBox(width: 12),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth >= 720;
          if (isWide) {
            return Row(
              children: [
                Expanded(
                  flex: 2,
                  child: _AvatarPreview(config: _config),
                ),
                const VerticalDivider(width: 1),
                Expanded(
                  flex: 3,
                  child: _ControlsPanel(
                    config: _config,
                    onConfigChanged: (c) => setState(() => _config = c),
                  ),
                ),
              ],
            );
          }
          return Column(
            children: [
              SizedBox(
                height: 280,
                child: _AvatarPreview(config: _config),
              ),
              const Divider(height: 1),
              Expanded(
                child: _ControlsPanel(
                  config: _config,
                  onConfigChanged: (c) => setState(() => _config = c),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Avatar preview
// ---------------------------------------------------------------------------

class _AvatarPreview extends StatelessWidget {
  const _AvatarPreview({required this.config});

  final BeanheadConfig config;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      color: colorScheme.surfaceContainerLowest,
      alignment: Alignment.center,
      padding: const EdgeInsets.all(24),
      child: Beanhead(
        config: config,
        width: 300,
        height: 300,
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Preview helpers
// ---------------------------------------------------------------------------

/// A base config used for generating preview thumbnails.
/// Kept simple (no hat, no accessory, no facial hair) so that
/// the changed property is clearly visible.
const _previewBase = BeanheadConfig(
  skinTone: SkinTone.light,
  eyes: Eyes.normal,
  eyebrows: Eyebrows.raised,
  mouth: Mouth.grin,
  hair: Hair.none,
  facialHair: FacialHair.none,
  clothing: Clothing.shirt,
  accessory: Accessory.none,
  graphic: ClothingGraphic.none,
  hat: Hat.none,
  body: Body.chest,
  hairColor: HairColor.brown,
  clothingColor: ClothingColor.white,
  lipColor: LipColor.red,
  hatColor: HatColor.white,
  faceMaskColor: FaceMaskColor.white,
  mask: true,
  faceMask: false,
  lashes: false,
);

/// Small avatar thumbnail widget used inside dropdown items.
class _AvatarThumbnail extends StatelessWidget {
  const _AvatarThumbnail({required this.config});

  final BeanheadConfig config;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 28,
      height: 28,
      child: Beanhead(config: config),
    );
  }
}

/// Color swatch circle widget used for color-type dropdown items.
class _ColorSwatch extends StatelessWidget {
  const _ColorSwatch({required this.hexColor});

  final String hexColor;

  @override
  Widget build(BuildContext context) {
    // Parse hex color string like '#fdd2b2' or 'fdd2b2'.
    final hex = hexColor.replaceFirst('#', '');
    final colorValue = int.parse(hex, radix: 16) | 0xFF000000;
    return SizedBox(
      width: 28,
      height: 28,
      child: Center(
        child: Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            color: Color(colorValue),
            shape: BoxShape.circle,
            border: Border.all(color: Colors.grey.shade400, width: 0.5),
          ),
        ),
      ),
    );
  }
}

/// Returns a preview widget builder for component-type enums.
/// Each option shows a small avatar with that specific property applied.
Widget Function(T) _avatarPreviewBuilder<T extends Enum>(
  BeanheadConfig Function(T value) configBuilder,
) {
  return (T value) => _AvatarThumbnail(config: configBuilder(value));
}

/// Returns a preview widget builder for color-type enums.
Widget Function(T) _colorSwatchBuilder<T extends Enum>(
  String Function(T value) colorResolver,
) {
  return (T value) => _ColorSwatch(hexColor: colorResolver(value));
}

// ---------------------------------------------------------------------------
// Controls panel
// ---------------------------------------------------------------------------

class _ControlsPanel extends StatelessWidget {
  const _ControlsPanel({
    required this.config,
    required this.onConfigChanged,
  });

  final BeanheadConfig config;
  final ValueChanged<BeanheadConfig> onConfigChanged;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      children: [
        const _SectionHeader('Appearance'),
        _EnumDropdown<SkinTone>(
          label: 'Skin Tone',
          value: config.skinTone,
          values: SkinTone.values,
          onChanged: (v) => onConfigChanged(config.copyWith(skinTone: v)),
          previewBuilder: _colorSwatchBuilder<SkinTone>(
            (v) => defaultTheme.skinColors[v]!.base,
          ),
        ),
        _EnumDropdown<Body>(
          label: 'Body',
          value: config.body,
          values: Body.values,
          onChanged: (v) => onConfigChanged(config.copyWith(body: v)),
          previewBuilder: _avatarPreviewBuilder<Body>(
            (v) => _previewBase.copyWith(body: v),
          ),
        ),
        _BoolSwitch(
          label: 'Lashes',
          value: config.lashes,
          onChanged: (v) => onConfigChanged(config.copyWith(lashes: v)),
        ),
        const SizedBox(height: 4),
        const _SectionHeader('Face'),
        _EnumDropdown<Eyes>(
          label: 'Eyes',
          value: config.eyes,
          values: Eyes.values,
          onChanged: (v) => onConfigChanged(config.copyWith(eyes: v)),
          previewBuilder: _avatarPreviewBuilder<Eyes>(
            (v) => _previewBase.copyWith(eyes: v),
          ),
        ),
        _EnumDropdown<Eyebrows>(
          label: 'Eyebrows',
          value: config.eyebrows,
          values: Eyebrows.values,
          onChanged: (v) => onConfigChanged(config.copyWith(eyebrows: v)),
          previewBuilder: _avatarPreviewBuilder<Eyebrows>(
            (v) => _previewBase.copyWith(eyebrows: v),
          ),
        ),
        _EnumDropdown<Mouth>(
          label: 'Mouth',
          value: config.mouth,
          values: Mouth.values,
          onChanged: (v) => onConfigChanged(config.copyWith(mouth: v)),
          previewBuilder: _avatarPreviewBuilder<Mouth>(
            (v) => _previewBase.copyWith(mouth: v),
          ),
        ),
        _EnumDropdown<FacialHair>(
          label: 'Facial Hair',
          value: config.facialHair,
          values: FacialHair.values,
          onChanged: (v) => onConfigChanged(config.copyWith(facialHair: v)),
          previewBuilder: _avatarPreviewBuilder<FacialHair>(
            (v) => _previewBase.copyWith(facialHair: v),
          ),
        ),
        _EnumDropdown<LipColor>(
          label: 'Lip Color',
          value: config.lipColor,
          values: LipColor.values,
          onChanged: (v) => onConfigChanged(config.copyWith(lipColor: v)),
          previewBuilder: _colorSwatchBuilder<LipColor>(
            (v) => defaultTheme.lipColors[v]!.base,
          ),
        ),
        const SizedBox(height: 4),
        const _SectionHeader('Hair'),
        _EnumDropdown<Hair>(
          label: 'Hair Style',
          value: config.hair,
          values: Hair.values,
          onChanged: (v) => onConfigChanged(config.copyWith(hair: v)),
          previewBuilder: _avatarPreviewBuilder<Hair>(
            (v) => _previewBase.copyWith(hair: v),
          ),
        ),
        _EnumDropdown<HairColor>(
          label: 'Hair Color',
          value: config.hairColor,
          values: HairColor.values,
          onChanged: (v) => onConfigChanged(config.copyWith(hairColor: v)),
          previewBuilder: _colorSwatchBuilder<HairColor>(
            (v) => defaultTheme.hairColors[v]!.base,
          ),
        ),
        const SizedBox(height: 4),
        const _SectionHeader('Clothing'),
        _EnumDropdown<Clothing>(
          label: 'Clothing',
          value: config.clothing,
          values: Clothing.values,
          onChanged: (v) => onConfigChanged(config.copyWith(clothing: v)),
          previewBuilder: _avatarPreviewBuilder<Clothing>(
            (v) => _previewBase.copyWith(clothing: v),
          ),
        ),
        _EnumDropdown<ClothingColor>(
          label: 'Clothing Color',
          value: config.clothingColor,
          values: ClothingColor.values,
          onChanged: (v) => onConfigChanged(config.copyWith(clothingColor: v)),
          previewBuilder: _colorSwatchBuilder<ClothingColor>(
            (v) => defaultTheme.clothingColors[v]!.base,
          ),
        ),
        _EnumDropdown<ClothingGraphic>(
          label: 'Graphic',
          value: config.graphic,
          values: ClothingGraphic.values,
          onChanged: (v) => onConfigChanged(config.copyWith(graphic: v)),
          previewBuilder: _avatarPreviewBuilder<ClothingGraphic>(
            (v) => _previewBase.copyWith(graphic: v, clothing: Clothing.shirt),
          ),
        ),
        const SizedBox(height: 4),
        const _SectionHeader('Accessories'),
        _EnumDropdown<Accessory>(
          label: 'Accessory',
          value: config.accessory,
          values: Accessory.values,
          onChanged: (v) => onConfigChanged(config.copyWith(accessory: v)),
          previewBuilder: _avatarPreviewBuilder<Accessory>(
            (v) => _previewBase.copyWith(accessory: v),
          ),
        ),
        _EnumDropdown<Hat>(
          label: 'Hat',
          value: config.hat,
          values: Hat.values,
          onChanged: (v) => onConfigChanged(config.copyWith(hat: v)),
          previewBuilder: _avatarPreviewBuilder<Hat>(
            (v) => _previewBase.copyWith(hat: v),
          ),
        ),
        _EnumDropdown<HatColor>(
          label: 'Hat Color',
          value: config.hatColor,
          values: HatColor.values,
          onChanged: (v) => onConfigChanged(config.copyWith(hatColor: v)),
          previewBuilder: _colorSwatchBuilder<HatColor>(
            (v) => defaultTheme.clothingColors[ClothingColor.values
                    .firstWhere((c) => c.name == v.name)]!
                .base,
          ),
        ),
        const SizedBox(height: 4),
        const _SectionHeader('Other'),
        _BoolSwitch(
          label: 'Mask (circular clip)',
          value: config.mask,
          onChanged: (v) => onConfigChanged(config.copyWith(mask: v)),
        ),
        _BoolSwitch(
          label: 'Face Mask',
          value: config.faceMask,
          onChanged: (v) => onConfigChanged(config.copyWith(faceMask: v)),
        ),
        _EnumDropdown<FaceMaskColor>(
          label: 'Face Mask Color',
          value: config.faceMaskColor,
          values: FaceMaskColor.values,
          onChanged: (v) => onConfigChanged(config.copyWith(faceMaskColor: v)),
          previewBuilder: _colorSwatchBuilder<FaceMaskColor>(
            (v) => defaultTheme.clothingColors[ClothingColor.values
                    .firstWhere((c) => c.name == v.name)]!
                .base,
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Reusable control widgets
// ---------------------------------------------------------------------------

class _SectionHeader extends StatelessWidget {
  const _SectionHeader(this.title);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 4, bottom: 2),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
            ),
      ),
    );
  }
}

class _EnumDropdown<T extends Enum> extends StatelessWidget {
  const _EnumDropdown({
    required this.label,
    required this.value,
    required this.values,
    required this.onChanged,
    this.previewBuilder,
  });

  final String label;
  final T value;
  final List<T> values;
  final ValueChanged<T> onChanged;

  /// Optional builder that returns a preview widget for each enum value.
  final Widget Function(T value)? previewBuilder;

  String _formatName(String name) {
    // Convert camelCase to Title Case with spaces.
    final buffer = StringBuffer();
    for (var i = 0; i < name.length; i++) {
      final ch = name[i];
      if (i > 0 && ch == ch.toUpperCase() && ch != ch.toLowerCase()) {
        buffer.write(' ');
      }
      buffer.write(i == 0 ? ch.toUpperCase() : ch);
    }
    return buffer.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          SizedBox(
            width: 120,
            child: Text(label, style: Theme.of(context).textTheme.bodySmall),
          ),
          Expanded(
            child: DropdownButtonFormField<T>(
              initialValue: value,
              isExpanded: true,
              isDense: true,
              decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              items: values
                  .map(
                    (v) => DropdownMenuItem<T>(
                      value: v,
                      child: Row(
                        children: [
                          if (previewBuilder != null) ...[
                            previewBuilder!(v),
                            const SizedBox(width: 8),
                          ],
                          Expanded(
                            child: Text(
                              _formatName(v.name),
                              style: Theme.of(context).textTheme.bodySmall,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                  .toList(),
              onChanged: (v) {
                if (v != null) onChanged(v);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _BoolSwitch extends StatelessWidget {
  const _BoolSwitch({
    required this.label,
    required this.value,
    required this.onChanged,
  });

  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          SizedBox(
            width: 120,
            child: Text(label, style: Theme.of(context).textTheme.bodySmall),
          ),
          SizedBox(
            height: 28,
            child: FittedBox(
              child: Switch(
                value: value,
                onChanged: onChanged,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
