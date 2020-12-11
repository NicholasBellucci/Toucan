import Foundation
import Cocoa

public protocol CodeTheme: Theme {
    func color(for type: TokenType) -> NSColor
}

extension CodeTheme {
    public var globalAttributes: [NSAttributedString.Key: Any] {
        [
            .font: font,
            .foregroundColor: color(for: .plain)
        ]
    }

    public func attributes(for token: Token) -> [NSAttributedString.Key: Any] {
        var attributes: [NSAttributedString.Key: Any] = [:]

        if let token = token as? SimpleSourceCodeToken {
            attributes[.foregroundColor] = color(for: token.type)
        }

        return attributes
    }
}
