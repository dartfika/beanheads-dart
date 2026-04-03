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

  void _updateConfig(BeanheadConfig c) => setState(() => _config = c);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BeanHeads Demo'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: FilledButton.icon(
              onPressed: _randomize,
              icon: const Icon(Icons.shuffle, size: 18),
              label: const Text('Randomize'),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Avatar preview - fixed height, centered
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Beanhead(config: _config, width: 260, height: 260),
          ),
          const Divider(height: 1),
          // Controls - two columns, takes remaining space
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Left column
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ..._buildAppearanceSection(_config, _updateConfig),
                        const Divider(height: 16),
                        ..._buildFaceSection(_config, _updateConfig),
                        const Divider(height: 16),
                        ..._buildHairSection(_config, _updateConfig),
                      ],
                    ),
                  ),
                ),
                const VerticalDivider(width: 1),
                // Right column
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ..._buildClothingSection(_config, _updateConfig),
                        const Divider(height: 16),
                        ..._buildAccessoriesSection(_config, _updateConfig),
                        const Divider(height: 16),
                        ..._buildOtherSection(_config, _updateConfig),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


// ---------------------------------------------------------------------------
// Preview helpers
// ---------------------------------------------------------------------------

/// A base config used for generating preview thumbnails.
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
// Control section builders (shared between layouts)
// ---------------------------------------------------------------------------

List<Widget> _buildAppearanceSection(
  BeanheadConfig config,
  ValueChanged<BeanheadConfig> onConfigChanged,
) {
  return [
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
  ];
}

List<Widget> _buildFaceSection(
  BeanheadConfig config,
  ValueChanged<BeanheadConfig> onConfigChanged,
) {
  return [
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
  ];
}

List<Widget> _buildHairSection(
  BeanheadConfig config,
  ValueChanged<BeanheadConfig> onConfigChanged,
) {
  return [
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
  ];
}

List<Widget> _buildClothingSection(
  BeanheadConfig config,
  ValueChanged<BeanheadConfig> onConfigChanged,
) {
  return [
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
  ];
}

List<Widget> _buildAccessoriesSection(
  BeanheadConfig config,
  ValueChanged<BeanheadConfig> onConfigChanged,
) {
  return [
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
  ];
}

List<Widget> _buildOtherSection(
  BeanheadConfig config,
  ValueChanged<BeanheadConfig> onConfigChanged,
) {
  return [
    const _SectionHeader('Other'),
    _BoolSwitch(
      label: 'Mask (circular clip)',
      value: config.mask,
      onChanged: (v) => onConfigChanged(config.copyWith(mask: v)),
    ),
    _CircleColorDropdown(
      label: 'Circle Color',
      value: config.circleColor,
      onChanged: (v) => onConfigChanged(config.copyWith(circleColor: v)),
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
  ];
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
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
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

/// Preset circle color options with display labels.
const _circleColorPresets = <String, String>{
  'Default': '#85c5e5',
  'White': '#FFFFFF',
  'Grey 300': '#E0E0E0',
  'Grey 400': '#BDBDBD',
  'Grey 500': '#9E9E9E',
  'Deep Purple 100': '#D1C4E9',
  'Deep Purple 200': '#B39DDB',
  'Deep Purple 300': '#9575CD',
  'Deep Purple 400': '#7E57C2',
  'Deep Purple 500': '#673AB7',
  'Deep Purple 700': '#512DA8',
  'Cyan 200': '#80DEEA',
  'Light Blue 300': '#4FC3F7',
  'Blue 500': '#2196F3',
  'Green 200': '#A5D6A7',
  'Green 300': '#81C784',
  'Green 400': '#66BB6A',
  'Light Green 200': '#C5E1A5',
  'Light Green 300': '#AED581',
  'Light Green 600': '#7CB342',
  'Yellow 200': '#FFF59D',
  'Amber 200': '#FFE082',
  'Orange 300': '#FFB74D',
  'Pink 100': '#F8BBD0',
  'Pink 200': '#F48FB1',
  'Pink 400': '#EC407A',
  'Red 200': '#EF9A9A',
  'Red 300': '#E57373',
  'Red 600': '#E53935',
  'Purple 200': '#CE93D8',
  'Purple 400': '#AB47BC',
  'Purple 600': '#8E24AA',
  'Purple 800': '#6A1B9A',
};

class _CircleColorDropdown extends StatelessWidget {
  const _CircleColorDropdown({
    required this.label,
    required this.value,
    required this.onChanged,
  });

  final String label;
  final String value;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    // Build a reverse map from hex -> label for lookup.
    final hexToLabel = {
      for (final entry in _circleColorPresets.entries) entry.value: entry.key,
    };

    final items = <DropdownMenuItem<String>>[
      for (final entry in _circleColorPresets.entries)
        DropdownMenuItem<String>(
          value: entry.value,
          child: Row(
            children: [
              _ColorSwatch(hexColor: entry.value),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  entry.key,
                  style: Theme.of(context).textTheme.bodySmall,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
    ];

    // Ensure the current value is always represented.
    final effectiveValue =
        hexToLabel.containsKey(value) ? value : '#85c5e5';

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          SizedBox(
            width: 120,
            child: Text(label, style: Theme.of(context).textTheme.bodySmall),
          ),
          Expanded(
            child: DropdownButtonFormField<String>(
              initialValue: effectiveValue,
              isExpanded: true,
              isDense: true,
              decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              items: items,
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
