import Foundation

public struct KeywordTokenGenerator {
    internal let keywords: [String]
    internal let excludeWrappedKeywords: Bool
    internal let transformer: TokenTransformer

    public init(keywords: [String], excludeWrappedKeywords: Bool, transformer: @escaping TokenTransformer) {
        self.keywords = keywords
        self.excludeWrappedKeywords = excludeWrappedKeywords
        self.transformer = transformer
    }
}
