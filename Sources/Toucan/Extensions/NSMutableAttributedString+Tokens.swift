import AppKit
import Foundation

public enum PlaceholderState {
    case active
    case inactive
}

public extension NSAttributedString.Key {
    static let placeholder = NSAttributedString.Key("placeholder")
}

public extension NSMutableAttributedString {
    convenience init(source: String, tokens: [Token], theme: CodeTheme) {
        self.init(string: source)

        var attributes: [NSAttributedString.Key: Any] = [:]
        let widthOfSpace = NSAttributedString(string: " ", attributes: [.font: theme.font]).size().width

        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.paragraphSpacing = 2.0
        paragraphStyle.defaultTabInterval = widthOfSpace * 4
        paragraphStyle.tabStops = []
        paragraphStyle.baseWritingDirection = .leftToRight
        paragraphStyle.alignment = .left
        attributes[.paragraphStyle] = paragraphStyle

        theme.globalAttributes.forEach {
            attributes[$0] = $1
        }

        setAttributes(attributes, range: NSRange(location: 0, length: source.count))

        tokens.forEach {
            if !$0.isPlain {
                let range = source.range(from: $0.range)

                if $0.isPlaceholder {
                    let startRange = NSRange(location: range.lowerBound, length: 2)
                    let endRange = NSRange(location: range.upperBound - 2, length: 2)
                    let contentRange = NSRange(location: range.lowerBound + 2, length: range.length - 4)

                    addAttributes(theme.attributes(for: $0), range: contentRange)
                    addAttributes([.placeholder: PlaceholderState.inactive], range: range)
                    addAttributes([.foregroundColor: NSColor.clear, .font: NSFont.systemFont(ofSize: 0.01)], range: startRange)
                    addAttributes([.foregroundColor: NSColor.clear, .font: NSFont.systemFont(ofSize: 0.01)], range: endRange)
                } else {
                    setAttributes(theme.attributes(for: $0), range: range)
                }
            }
        }
    }
}
