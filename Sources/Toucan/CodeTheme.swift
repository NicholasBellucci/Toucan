import Foundation
import Cocoa

public protocol EditorTheme: Theme {
    func color(for type: TokenType) -> NSColor
}

extension EditorTheme {
    public var globalAttributes: [NSAttributedString.Key: Any] {
        [
            .font: font
        ]
    }

    public func attributes(for token: Token) -> [NSAttributedString.Key: Any] {
        var attributes: [NSAttributedString.Key: Any] = [:]

        if let token = token as? SourceCodeToken {
            attributes[.foregroundColor] = color(for: token.type)
        }

        return attributes
    }
}
