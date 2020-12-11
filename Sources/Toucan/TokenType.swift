import Foundation

public enum TokenType {
    case comment
    case customType
    case identifier
    case instanceVariable
    case keyword
    case number
    case other
    case placeholder
    case plain
    case string
    case type
}

protocol SourceCodeToken: Token {
    var type: TokenType { get }
}

extension SourceCodeToken {
    var isPlaceholder: Bool {
        return type == .placeholder
    }

    var isPlain: Bool {
        return type == .plain
    }
}

struct SimpleSourceCodeToken: SourceCodeToken {
    let type: TokenType
    let range: Range<String.Index>
}
