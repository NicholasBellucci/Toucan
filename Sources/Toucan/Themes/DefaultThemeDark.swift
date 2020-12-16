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
        if let type = type as? SwiftLexer.SwiftTokenType {
            return swiftColor(for: type)
        } else if let type = type as? KotlinLexer.KotlinTokenType {
            return kotlinColor(for: type)
        }

        return .clear
    }
}

private extension DefaultThemeDark {
    func swiftColor(for type: SwiftLexer.SwiftTokenType) -> NSColor {
        switch type {
        case .comment: return NSColor(0x6C7986)
        case .string: return NSColor(0xFC6A5D)
        case .number: return NSColor(0xD0BF69)
        case .keyword: return NSColor(0xFC5FA3)
        case .typeDeclaration: return NSColor(0x5DD8FF)
        case .otherDeclaration: return NSColor(0x41A1C0)
        case .projectType: return NSColor(0x9EF1DD)
        case .projectVariable: return NSColor(0x67B7A4)
        case .otherType: return NSColor(0xD0A8FF)
        case .otherFunction: return NSColor(0xA167E6)
        case .otherVariables: return NSColor(0xA167E6)
        case .placeholder: return .white
        case .plain: return .white
        }
    }

    func kotlinColor(for type: KotlinLexer.KotlinTokenType) -> NSColor {
        switch type {
        case .comma: return NSColor(0xd37a2c)
        case .comment: return NSColor(0x8b8b8b)
        case .dotComment: return NSColor(0x5fa45a)
        case .otherFunction: return NSColor(0xffc76e)
        case .keyword: return NSColor(0xd37a2c)
        case .string: return NSColor(0x6c905f)
        case .placeholder: return NSColor(0xa5b4c1)
        case .plain: return .yellow
        }
    }
}
