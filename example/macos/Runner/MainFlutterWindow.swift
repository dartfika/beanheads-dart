import Cocoa
import FlutterMacOS

class MainFlutterWindow: NSWindow {
  override func awakeFromNib() {
    let flutterViewController = FlutterViewController()
    self.contentViewController = flutterViewController
    let screenFrame = NSScreen.main?.visibleFrame ?? NSRect(x: 0, y: 0, width: 800, height: 1080)
    let windowFrame = NSRect(
      x: (screenFrame.width - 800) / 2 + screenFrame.origin.x,
      y: (screenFrame.height - 1080) / 2 + screenFrame.origin.y,
      width: 800,
      height: 1080
    )
    self.setFrame(windowFrame, display: true)

    RegisterGeneratedPlugins(registry: flutterViewController)

    super.awakeFromNib()
  }
}
