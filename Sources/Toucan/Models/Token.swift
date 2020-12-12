import Foundation

public protocol Token {
    var isPlaceholder: Bool { get }
    var isPlain: Bool { get }
    var range: Range<String.Index> { get }
}

struct CachedToken {
    let token: Token
    let range: NSRange
}
