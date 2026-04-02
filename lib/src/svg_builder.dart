/// A simple utility for building SVG markup strings.
class SvgBuilder {
  final StringBuffer _buffer = StringBuffer();

  /// Opens the root `<svg>` element.
  void openSvg({
    required double width,
    required double height,
    required String viewBox,
  }) {
    _buffer.write(
      '<svg width="$width" height="$height" viewBox="$viewBox" '
      'xmlns="http://www.w3.org/2000/svg">',
    );
  }

  /// Closes the root `<svg>` element.
  void closeSvg() {
    _buffer.write('</svg>');
  }

  /// Opens a `<g>` group element with optional attributes.
  void openGroup({
    String? transform,
    String? clipPath,
    String? mask,
    String? style,
  }) {
    _buffer.write('<g');
    if (style != null) _buffer.write(' style="$style"');
    if (transform != null) _buffer.write(' transform="$transform"');
    if (clipPath != null) _buffer.write(' clip-path="$clipPath"');
    if (mask != null) _buffer.write(' mask="$mask"');
    _buffer.write('>');
  }

  /// Closes a `<g>` group element.
  void closeGroup() {
    _buffer.write('</g>');
  }

  /// Adds a `<path>` element.
  void addPath(
    String d, {
    String? fill,
    String? fillRule,
    String? stroke,
    String? strokeWidth,
    String? strokeLinecap,
    double? strokeMiterlimit,
    String? opacity,
  }) {
    _buffer.write('<path d="$d"');
    if (fill != null) _buffer.write(' fill="$fill"');
    if (fillRule != null) _buffer.write(' fill-rule="$fillRule"');
    if (stroke != null) _buffer.write(' stroke="$stroke"');
    if (strokeWidth != null) _buffer.write(' stroke-width="$strokeWidth"');
    if (strokeLinecap != null) _buffer.write(' stroke-linecap="$strokeLinecap"');
    if (strokeMiterlimit != null) {
      _buffer.write(' stroke-miterlimit="$strokeMiterlimit"');
    }
    if (opacity != null) _buffer.write(' opacity="$opacity"');
    _buffer.write('/>');
  }

  /// Adds a `<circle>` element.
  void addCircle({
    required double cx,
    required double cy,
    required double r,
    String? fill,
    String? stroke,
    String? strokeWidth,
    double? strokeMiterlimit,
    String? opacity,
  }) {
    _buffer.write('<circle cx="$cx" cy="$cy" r="$r"');
    if (fill != null) _buffer.write(' fill="$fill"');
    if (stroke != null) _buffer.write(' stroke="$stroke"');
    if (strokeWidth != null) _buffer.write(' stroke-width="$strokeWidth"');
    if (strokeMiterlimit != null) {
      _buffer.write(' stroke-miterlimit="$strokeMiterlimit"');
    }
    if (opacity != null) _buffer.write(' opacity="$opacity"');
    _buffer.write('/>');
  }

  /// Adds a `<rect>` element.
  void addRect({
    required double x,
    required double y,
    required double width,
    required double height,
    double? rx,
    String? fill,
  }) {
    _buffer.write('<rect x="$x" y="$y" width="$width" height="$height"');
    if (rx != null) _buffer.write(' rx="$rx"');
    if (fill != null) _buffer.write(' fill="$fill"');
    _buffer.write('/>');
  }

  /// Opens a `<defs>` block.
  void openDefs() {
    _buffer.write('<defs>');
  }

  /// Closes a `<defs>` block.
  void closeDefs() {
    _buffer.write('</defs>');
  }

  /// Opens a `<mask>` element with the given [id].
  void openMask(String id) {
    _buffer.write('<mask id="$id">');
  }

  /// Closes a `<mask>` element.
  void closeMask() {
    _buffer.write('</mask>');
  }

  /// Opens a `<clipPath>` element with the given [id].
  void openClipPath(String id) {
    _buffer.write('<clipPath id="$id">');
  }

  /// Closes a `<clipPath>` element.
  void closeClipPath() {
    _buffer.write('</clipPath>');
  }

  /// Adds a `<polygon>` element.
  void addPolygon(
    String points, {
    String? fill,
    String? stroke,
    String? strokeWidth,
    String? strokeLinecap,
    double? strokeMiterlimit,
  }) {
    _buffer.write('<polygon points="$points"');
    if (fill != null) _buffer.write(' fill="$fill"');
    if (stroke != null) _buffer.write(' stroke="$stroke"');
    if (strokeWidth != null) _buffer.write(' stroke-width="$strokeWidth"');
    if (strokeLinecap != null) _buffer.write(' stroke-linecap="$strokeLinecap"');
    if (strokeMiterlimit != null) {
      _buffer.write(' stroke-miterlimit="$strokeMiterlimit"');
    }
    _buffer.write('/>');
  }

  /// Adds a `<polyline>` element.
  void addPolyline(
    String points, {
    String? fill,
    String? stroke,
    String? strokeWidth,
    double? strokeMiterlimit,
  }) {
    _buffer.write('<polyline points="$points"');
    if (fill != null) _buffer.write(' fill="$fill"');
    if (stroke != null) _buffer.write(' stroke="$stroke"');
    if (strokeWidth != null) _buffer.write(' stroke-width="$strokeWidth"');
    if (strokeMiterlimit != null) {
      _buffer.write(' stroke-miterlimit="$strokeMiterlimit"');
    }
    _buffer.write('/>');
  }

  /// Adds a `<line>` element.
  void addLine({
    required double x1,
    required double y1,
    required double x2,
    required double y2,
    String? fill,
    String? stroke,
    String? strokeWidth,
    String? strokeLinecap,
    double? strokeMiterlimit,
  }) {
    _buffer.write('<line x1="$x1" y1="$y1" x2="$x2" y2="$y2"');
    if (fill != null) _buffer.write(' fill="$fill"');
    if (stroke != null) _buffer.write(' stroke="$stroke"');
    if (strokeWidth != null) _buffer.write(' stroke-width="$strokeWidth"');
    if (strokeLinecap != null) _buffer.write(' stroke-linecap="$strokeLinecap"');
    if (strokeMiterlimit != null) {
      _buffer.write(' stroke-miterlimit="$strokeMiterlimit"');
    }
    _buffer.write('/>');
  }

  /// Writes raw SVG content directly into the buffer.
  void writeRaw(String content) {
    _buffer.write(content);
  }

  /// Returns the built SVG string.
  String build() => _buffer.toString();
}
