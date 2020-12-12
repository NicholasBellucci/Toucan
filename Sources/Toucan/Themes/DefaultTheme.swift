import Cocoa
import Foundation

// Xcode Theme: Default (Light)
public struct DefaultTheme: EditorTheme {
    public init() { }

    public var backgroundColor: NSColor {
        NSColor(red: 42/255.0, green: 42/255, blue: 48/255, alpha: 1.0)
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
        GutterStyle(backgroundColor: NSColor(red: 42/255.0, green: 42/255, blue: 48/255, alpha: 1.0), minimumWidth: 32)
    }

    public var lineNumbersStyle: LineNumbersStyle {
        LineNumbersStyle(font: .monospacedSystemFont(ofSize: 13, weight: .medium), textColor: lineNumbersColor)
    }

    private var lineNumbersColor: NSColor {
        NSColor(red: 100/255, green: 100/255, blue: 100/255, alpha: 1)
    }

    public func color(for type: TokenType) -> NSColor {
        guard let type = type as? SwiftLexer.SwiftTokenType else { return .clear }

        switch type {
        case .comment:
            return NSColor(red: 69/255, green: 187/255, blue: 62/255, alpha: 1)
        case .string:
            return NSColor(red: 252/255, green: 106/255, blue: 93/255, alpha: 1)
        case .number:
            return NSColor(red: 116/255, green: 109/255, blue: 176/255, alpha: 1)
        case .keyword:
            return NSColor(red: 252/255, green: 95/255, blue: 163/255, alpha: 1)
        case .typeDeclaration:
            return NSColor(red: 93/255, green: 216/255, blue: 255/255, alpha: 1)
        case .otherDeclaration:
            return NSColor(red: 65/255, green: 161/255, blue: 192/255, alpha: 1)
        case .projectType:
            return NSColor(red: 158/255, green: 241/255, blue: 221/255, alpha: 1)
        case .projectVariable:
            return NSColor(red: 103/255, green: 183/255, blue: 164/255, alpha: 1)
        case .otherType:
            return NSColor(red: 208/255, green: 168/255, blue: 255/255, alpha: 1)
        case .otherFunction, .otherVariables:
            return NSColor(red: 161/255, green: 103/255, blue: 230/255, alpha: 1)
        case .placeholder:
            return backgroundColor
        case .plain:
            return .white
        }
    }
}
