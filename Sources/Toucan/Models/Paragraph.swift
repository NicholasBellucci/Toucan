import AppKit
import CoreGraphics
import Foundation

struct Paragraph {
    var rect: CGRect
    let number: Int

    var string: String {
        "\(number)"
    }

    func attributedString(for style: LineNumbersStyle) -> NSAttributedString {
        let attributes = NSMutableAttributedString(string: string)
        let range = NSMakeRange(0, attributes.length)

        attributes.addAttributes(
            [
                .font: style.font,
                .foregroundColor : style.textColor
            ],
            range: range
        )

        return attributes
    }

    func drawSize(for style: LineNumbersStyle) -> CGSize {
        return attributedString(for: style).size()
    }
}

extension Paragraph {
    static func paragraphs(for textView: EditorTextView, flipRects: Bool = false) -> [Paragraph] {
        let range = NSRange(location: 0, length: (textView.text as NSString).length)

        var paragraphs: [Paragraph] = []
        var paragraphNumber = 1
        let text = textView.text as NSString

        text.enumerateSubstrings(in: range, options: [.byParagraphs]) { content, paragraphRange, enclosingRange, stop in
            let rect = textView.paragraphRectForRange(range: paragraphRange)
            let paragraph = Paragraph(rect: rect, number: paragraphNumber)

            paragraphs.append(paragraph)
            paragraphNumber += 1
        }

        if textView.text.isEmpty || textView.text.hasSuffix("\n") {
            var rect: CGRect
            let gutterWidth = textView.textContainerInset.width
            let lineHeight: CGFloat = 18

            if let last = paragraphs.last {
                let lineSpacing: CGFloat = 2
                rect = CGRect(x: 0, y: last.rect.origin.y + last.rect.height + lineSpacing, width: gutterWidth, height: last.rect.height)

            } else {
                rect = CGRect(x: 0, y: 0, width: gutterWidth, height: lineHeight)
            }

            let endParagraph = Paragraph(rect: rect, number: paragraphNumber)
            paragraphs.append(endParagraph)
            paragraphNumber += 1
        }

        if flipRects {
            paragraphs = paragraphs.map {
                var paragraph = $0
                paragraph.rect.origin.y = textView.bounds.height - paragraph.rect.height - paragraph.rect.origin.y
                return paragraph
            }
        }

        return paragraphs
    }

    static func offsetParagraphs(_ paragraphs: [Paragraph], for textView: EditorTextView, yOffset: CGFloat = 0) -> [Paragraph] {
        paragraphs.map {
            var paragraph = $0
            paragraph.rect.origin.y += yOffset
            return paragraph
        }
    }

    static func drawLineNumbers(for paragraphs: [Paragraph], in rect: CGRect, for textView: EditorTextView) {
        guard let style = textView.theme?.lineNumbersStyle else { return }

        paragraphs.forEach {
            if $0.rect.intersects(rect) {
                let attributes = $0.attributedString(for: style)
                var drawRect = $0.rect
                let drawSize = attributes.size()
                let gutterWidth = textView.gutterWidth

                drawRect.origin.x = gutterWidth - drawSize.width - 4
                drawRect.size.width = drawSize.width
                drawRect.size.height = drawSize.height
                attributes.draw(in: drawRect)
            }
        }
    }
}
