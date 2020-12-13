import Cocoa
import Foundation

// Xcode Theme: Default (Dark)
public struct DefaultThemeDark: EditorTheme {
    public init() { }

    public var backgroundColor: NSColor {
        NSColor(0x2A2A30)
    }

    public var cursorColor: NSColor {
        .white
    }

    public var font: NSFont {
        .monospacedSystemFont(ofSize: 13, weight: .medium)
    }

    public var foregroundColor: NSColor {
        .white
    }

    public var gutterStyle: GutterStyle {
        GutterStyle(backgroundColor: backgroundColor, minimumWidth: 32)
    }

    public var lineNumbersStyle: LineNumbersStyle {
        LineNumbersStyle(font: .monospacedSystemFont(ofSize: 11, weight: .medium), textColor: NSColor(0x646464))
    }

    public func color(for type: TokenType) -> NSColor {
        guard let type = type as? SwiftLexer.SwiftTokenType else { return .clear }

        switch type {
        case .comment:
            return NSColor(0x6C7986)
        case .string:
            return NSColor(0xFC6A5D)
        case .number:
            return NSColor(0xD0BF69)
        case .keyword:
            return NSColor(0xFC5FA3)
        case .typeDeclaration:
            return NSColor(0x5DD8FF)
        case .otherDeclaration:
            return NSColor(0x41A1C0)
        case .projectType:
            return NSColor(0x9EF1DD)
        case .projectVariable:
            return NSColor(0x67B7A4)
        case .otherType:
            return NSColor(0xD0A8FF)
        case .otherFunction:
            return NSColor(0xA167E6)
        case .otherVariables:
            return NSColor(0xA167E6)
        case .placeholder:
            return backgroundColor
        case .plain:
            return .white
        }
    }
}
