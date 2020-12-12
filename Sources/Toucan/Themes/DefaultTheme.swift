import Cocoa
import Foundation

// Xcode Theme: Default (Light)
public struct DefaultTheme: EditorTheme {
    public init() { }

    public var backgroundColor: NSColor {
        .white
    }

    public var font: NSFont {
        .monospacedSystemFont(ofSize: 13, weight: .medium)
    }

    public var gutterStyle: GutterStyle {
        GutterStyle(backgroundColor: backgroundColor, minimumWidth: 32)
    }

    public var cursorColor: NSColor {
        .black
    }

    public var lineNumbersStyle: LineNumbersStyle {
        LineNumbersStyle(font: .monospacedSystemFont(ofSize: 11, weight: .medium), textColor: NSColor(0x5D6C79))
    }

    public func color(for type: TokenType) -> NSColor {
        switch type {
        case .comment:
            return NSColor(0x5D6C79)
        case .customType:
            return NSColor(0x1C464A)
        case .identifier:
            return NSColor(0x3900A0)
        case .instanceVariable:
            return NSColor(0x6C36A9)
        case .keyword:
            return NSColor(0x9B2393)
        case .number:
            return NSColor(0x1C00CF)
        case .other:
            return NSColor(0x0F68A0)
        case .placeholder:
            return NSColor(0xB7B7B7)
        case .plain:
            return NSColor(0x000000)
        case .string:
            return NSColor(0xC41A16)
        case .type:
            return NSColor(0x0B4F79)
        }
    }
}
