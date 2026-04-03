import Cocoa
import FlutterMacOS

class MainFlutterWindow: NSWindow {
  override func awakeFromNib() {
    let flutterViewController = FlutterViewController()
    self.contentViewController = flutterViewController
    let screenFrame = NSScreen.main?.visibleFrame ?? NSRect(x: 0, y: 0, width: 1100, height: 750)
    let windowFrame = NSRect(
      x: (screenFrame.width - 1100) / 2 + screenFrame.origin.x,
      y: (screenFrame.height - 750) / 2 + screenFrame.origin.y,
      width: 1100,
      height: 750
    )
    self.setFrame(windowFrame, display: true)

    RegisterGeneratedPlugins(registry: flutterViewController)

    super.awakeFromNib()
  }
}
