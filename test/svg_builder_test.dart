import 'package:flutter_test/flutter_test.dart';
import 'package:beanheads/beanheads.dart';

void main() {
  late SvgBuilder svg;

  setUp(() {
    svg = SvgBuilder();
  });

  group('basic SVG generation', () {
    test('openSvg and closeSvg produce valid wrapper', () {
      svg.openSvg(width: 100, height: 200, viewBox: '0 0 100 200');
      svg.closeSvg();
      final result = svg.build();
      expect(result, startsWith('<svg'));
      expect(result, endsWith('</svg>'));
      expect(result, contains('width="100.0"'));
      expect(result, contains('height="200.0"'));
      expect(result, contains('viewBox="0 0 100 200"'));
      expect(result, contains('xmlns="http://www.w3.org/2000/svg"'));
    });

    test('empty builder produces empty string', () {
      expect(svg.build(), isEmpty);
    });
  });

  group('addPath', () {
    test('renders a basic path', () {
      svg.addPath('M0 0 L10 10', fill: '#ff0000');
      final result = svg.build();
      expect(result, contains('<path'));
      expect(result, contains('d="M0 0 L10 10"'));
      expect(result, contains('fill="#ff0000"'));
    });

    test('renders path with all optional attributes', () {
      svg.addPath(
        'M0 0',
        fill: '#000',
        fillRule: 'evenodd',
        stroke: '#fff',
        strokeWidth: '2',
        strokeLinecap: 'round',
        strokeMiterlimit: 4.0,
        opacity: '0.5',
      );
      final result = svg.build();
      expect(result, contains('fill-rule="evenodd"'));
      expect(result, contains('stroke="#fff"'));
      expect(result, contains('stroke-width="2"'));
      expect(result, contains('stroke-linecap="round"'));
      expect(result, contains('stroke-miterlimit="4.0"'));
      expect(result, contains('opacity="0.5"'));
    });
  });

  group('addCircle', () {
    test('renders a circle with required attributes', () {
      svg.addCircle(cx: 50, cy: 50, r: 25, fill: '#00ff00');
      final result = svg.build();
      expect(result, contains('<circle'));
      expect(result, contains('cx="50.0"'));
      expect(result, contains('cy="50.0"'));
      expect(result, contains('r="25.0"'));
      expect(result, contains('fill="#00ff00"'));
    });
  });

  group('addRect', () {
    test('renders a rect with required attributes', () {
      svg.addRect(x: 10, y: 20, width: 100, height: 50, fill: '#blue');
      final result = svg.build();
      expect(result, contains('<rect'));
      expect(result, contains('x="10.0"'));
      expect(result, contains('y="20.0"'));
      expect(result, contains('width="100.0"'));
      expect(result, contains('height="50.0"'));
    });

    test('renders a rect with rounded corners', () {
      svg.addRect(x: 0, y: 0, width: 10, height: 10, rx: 5);
      expect(svg.build(), contains('rx="5.0"'));
    });
  });

  group('nested groups', () {
    test('open and close group produce correct nesting', () {
      svg.openGroup(transform: 'translate(10, 20)');
      svg.addCircle(cx: 0, cy: 0, r: 5);
      svg.closeGroup();
      final result = svg.build();
      expect(result, contains('<g'));
      expect(result, contains('transform="translate(10, 20)"'));
      expect(result, contains('</g>'));
    });

    test('group supports clipPath and mask', () {
      svg.openGroup(clipPath: 'url(#clip)', mask: 'url(#mask)');
      svg.closeGroup();
      final result = svg.build();
      expect(result, contains('clip-path="url(#clip)"'));
      expect(result, contains('mask="url(#mask)"'));
    });

    test('group supports style attribute', () {
      svg.openGroup(style: 'opacity: 0.5');
      svg.closeGroup();
      expect(svg.build(), contains('style="opacity: 0.5"'));
    });
  });

  group('defs and masks', () {
    test('openDefs and closeDefs produce valid block', () {
      svg.openDefs();
      svg.closeDefs();
      final result = svg.build();
      expect(result, contains('<defs>'));
      expect(result, contains('</defs>'));
    });

    test('openMask and closeMask produce valid block', () {
      svg.openMask('myMask');
      svg.closeMask();
      final result = svg.build();
      expect(result, contains('<mask id="myMask">'));
      expect(result, contains('</mask>'));
    });

    test('openClipPath and closeClipPath produce valid block', () {
      svg.openClipPath('myClip');
      svg.closeClipPath();
      final result = svg.build();
      expect(result, contains('<clipPath id="myClip">'));
      expect(result, contains('</clipPath>'));
    });
  });

  group('build()', () {
    test('produces valid SVG string structure', () {
      svg.openSvg(width: 1000, height: 990, viewBox: '0 0 1000 990');
      svg.openDefs();
      svg.openMask('mask');
      svg.addRect(x: 0, y: 0, width: 1000, height: 990, fill: '#fff');
      svg.closeMask();
      svg.closeDefs();
      svg.openGroup(transform: 'translate(100, 100)');
      svg.addCircle(cx: 500, cy: 500, r: 400, fill: '#85c5e5');
      svg.addPath('M100 200 L300 400', fill: '#592d3d');
      svg.closeGroup();
      svg.closeSvg();

      final result = svg.build();
      expect(result, startsWith('<svg'));
      expect(result, endsWith('</svg>'));
      expect(result, contains('<defs>'));
      expect(result, contains('</defs>'));
      expect(result, contains('<mask id="mask">'));
      expect(result, contains('</mask>'));
      expect(result, contains('<g'));
      expect(result, contains('</g>'));
    });
  });

  group('additional elements', () {
    test('addPolygon renders correctly', () {
      svg.addPolygon('10,20 30,40 50,60', fill: '#000');
      final result = svg.build();
      expect(result, contains('<polygon'));
      expect(result, contains('points="10,20 30,40 50,60"'));
    });

    test('addPolyline renders correctly', () {
      svg.addPolyline('10,20 30,40', stroke: '#000', strokeWidth: '2');
      final result = svg.build();
      expect(result, contains('<polyline'));
      expect(result, contains('points="10,20 30,40"'));
    });

    test('addLine renders correctly', () {
      svg.addLine(x1: 0, y1: 0, x2: 100, y2: 100, stroke: '#000');
      final result = svg.build();
      expect(result, contains('<line'));
      expect(result, contains('x1="0.0"'));
      expect(result, contains('x2="100.0"'));
    });

    test('writeRaw writes content directly', () {
      svg.writeRaw('<text>Hello</text>');
      expect(svg.build(), contains('<text>Hello</text>'));
    });
  });
}
