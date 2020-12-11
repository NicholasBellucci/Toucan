import Foundation

public protocol Token {
    /**
     When true, this token will be treated as a placeholder.
     Users can tab between placeholder.
     Typing in a placeholder replaces it completely.
     */
    var isPlaceholder: Bool { get }

    /**
     When true, no attributes will be requested for this token.
     This causes a performance win for a large amount of tokens
        that don't require any attributes.
     */
    var isPlain: Bool { get }

    /** The range of the token in the source string. */
    var range: Range<String.Index> { get }
}

struct CachedToken {
    let token: Token
    let range: NSRange
}
