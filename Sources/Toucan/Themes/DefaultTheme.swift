import Cocoa
import Foundation

public struct DefaultTheme: CodeTheme {
    public init() { }
    
    public var backgroundColor: NSColor {
        NSColor(red: 42/255.0, green: 42/255, blue: 48/255, alpha: 1.0)
    }

    public var font: NSFont {
        .systemFont(ofSize: 15)
    }

    public var gutterStyle: GutterStyle {
        GutterStyle(backgroundColor: NSColor(red: 21/255, green: 22/255, blue: 31/255, alpha: 1), minimumWidth: 32)
    }

    public var lineNumbersStyle: LineNumbersStyle {
        LineNumbersStyle(font: .systemFont(ofSize: 16), textColor: lineNumbersColor)
    }

    private var lineNumbersColor: NSColor {
        NSColor(red: 100/255, green: 100/255, blue: 100/255, alpha: 1)
    }

    public func color(for syntaxColorType: TokenType) -> NSColor {
        switch syntaxColorType {
        case .comment:
            return NSColor(red: 69/255, green: 187/255, blue: 62/255, alpha: 1)
        case .customType:
            return NSColor(red: 158/255, green: 241/255, blue: 221/255, alpha: 1)
        case .identifier:
            return NSColor(red: 208/255, green: 168/255, blue: 255/255, alpha: 1)
        case .instanceVariable:
            return NSColor(red: 103/255, green: 183/255, blue: 164/255, alpha: 1)
        case .keyword:
            return NSColor(red: 252/255, green: 95/255, blue: 163/255, alpha: 1)
        case .number:
            return NSColor(red: 116/255, green: 109/255, blue: 176/255, alpha: 1)
        case .other:
            return NSColor(red: 65/255, green: 161/255, blue: 192/255, alpha: 1)
        case .placeholder:
            return backgroundColor
        case .plain:
            return .white
        case .string:
            return NSColor(red: 252/255, green: 106/255, blue: 93/255, alpha: 1)
        case .type:
            return NSColor(red: 93/255, green: 216/255, blue: 255/255, alpha: 1)
        }
    }
}
