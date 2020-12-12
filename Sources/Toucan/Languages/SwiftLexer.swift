import Foundation

public class SwiftLexer {
    public enum SwiftTokenType: TokenType {
        case comment, customType, identifier, instanceVariable
        case keyword, number, other, placeholder, plain
        case string, type

        public var isPlaceholder: Bool {
            self == .placeholder
        }

        public var isPlain: Bool {
            self == .plain
        }
    }

    public init() { }

    private lazy var generators: [Generator] = {
        var editorPlaceholderPattern = "(<#)[^\"\\n]*"
        editorPlaceholderPattern += "(#>)"

        return [
            regexGenerator("\\b(NS|UI)[A-Z][a-zA-Z]+\\b", tokenType: SwiftTokenType.identifier),
            regexGenerator("(?<=\\b(struct|class|enum|typealias|)\\s)(\\w+)", tokenType: SwiftTokenType.identifier),
            regexGenerator("(?<=\\b:\\s)(\\w+)|(?<=\\[)(.*?)(?=\\])", tokenType: SwiftTokenType.customType),
            regexGenerator("\\b(println|print)(?=\\()", tokenType: SwiftTokenType.identifier),
            regexGenerator("(?<=(\\s|\\[|,|:))(\\d|\\.|_)+", tokenType: SwiftTokenType.number),
            regexGenerator("(?<=\\.)[A-Za-z_]+\\w*", tokenType: SwiftTokenType.instanceVariable),
            regexGenerator("\\bself(?=\\.)", tokenType: SwiftTokenType.keyword),
            keywordGenerator(keywords, tokenType: SwiftTokenType.keyword),
            keywordGenerator(swiftIdentifiers, tokenType: SwiftTokenType.identifier),
            regexGenerator("//(.*)", tokenType: SwiftTokenType.comment),
            regexGenerator("(/\\*)(.*)(\\*/)", options: [.dotMatchesLineSeparators], tokenType: SwiftTokenType.comment),
            regexGenerator("(\"|@\")[^\"\\n]*(@\"|\")", tokenType: SwiftTokenType.string),
            regexGenerator("(\"\"\")(.*?)(\"\"\")", options: [.dotMatchesLineSeparators], tokenType: SwiftTokenType.string),
            regexGenerator("(?<=\\b(?:var|let|case)\\s)(\\w+)", tokenType: SwiftTokenType.other),
            regexGenerator(editorPlaceholderPattern, tokenType: SwiftTokenType.placeholder)
        ]
        .compactMap({ $0 })
    }()
}

extension SwiftLexer: RegexLexer {
    public func generators(source: String) -> [Generator] {
        return generators
    }
}

extension SwiftLexer {
    private var keywords: [String] {
        "as associatedtype break case catch class continue convenience default defer deinit else enum extension fallthrough false fileprivate final for func get guard if import in init inout internal is lazy let mutating nil nonmutating open operator override private protocol public repeat required rethrows return required self set static struct subscript super switch throw throws true try typealias unowned var weak where while".components(separatedBy: " ")
    }

    private var swiftIdentifiers: [String] {
        "Any Array AutoreleasingUnsafePointer BidirectionalReverseView Bit Bool CaseIterable CFunctionPointer COpaquePointer CVaListPointer Character Codable CodingKey CollectionOfOne ConstUnsafePointer ContiguousArray Data Dictionary DictionaryGenerator DictionaryIndex Double EmptyCollection EmptyGenerator EnumerateGenerator FilterCollectionView FilterCollectionViewIndex FilterGenerator FilterSequenceView Float Float80 FloatingPointClassification GeneratorOf GeneratorOfOne GeneratorSequence HeapBuffer HeapBuffer HeapBufferStorage HeapBufferStorageBase ImplicitlyUnwrappedOptional IndexingGenerator Int Int16 Int32 Int64 Int8 IntEncoder LazyBidirectionalCollection LazyForwardCollection LazyRandomAccessCollection LazySequence Less MapCollectionView MapSequenceGenerator MapSequenceView MirrorDisposition ObjectIdentifier OnHeap Optional PermutationGenerator QuickLookObject RandomAccessReverseView Range RangeGenerator RawByte Repeat ReverseBidirectionalIndex Printable ReverseRandomAccessIndex SequenceOf SinkOf Slice StaticString StrideThrough StrideThroughGenerator StrideTo StrideToGenerator String Index UTF8View Index UnicodeScalarView IndexType GeneratorType UTF16View UInt UInt16 UInt32 UInt64 UInt8 UTF16 UTF32 UTF8 UnicodeDecodingResult UnicodeScalar Unmanaged UnsafeArray UnsafeArrayGenerator UnsafeMutableArray UnsafePointer URL VaListBuilder Header Zip2 ZipGenerator2".components(separatedBy: " ")
    }
}
