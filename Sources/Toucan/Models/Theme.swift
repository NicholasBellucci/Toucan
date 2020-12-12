import Foundation
import Cocoa
import CoreGraphics

public struct LineNumbersStyle {
    internal let font: NSFont
    internal let textColor: NSColor

    public init(font: NSFont, textColor: NSColor) {
        self.font = font
        self.textColor = textColor
    }
}

public struct GutterStyle {
    internal let backgroundColor: NSColor
    internal let minimumWidth: CGFloat

    public init(backgroundColor: NSColor, minimumWidth: CGFloat) {
        self.backgroundColor = backgroundColor
        self.minimumWidth = minimumWidth
    }
}

public protocol Theme {
    var backgroundColor: NSColor { get }
    var cursorColor: NSColor { get }
    var font: NSFont { get }
    var foregroundColor: NSColor { get }
    var globalAttributes: [NSAttributedString.Key: Any] { get }
    var gutterStyle: GutterStyle { get }
    var lineNumbersStyle: LineNumbersStyle { get }

    func attributes(for token: Token) -> [NSAttributedString.Key: Any]
}
