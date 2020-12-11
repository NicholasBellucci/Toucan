import AppKit
import Foundation

extension EditorTextView {
    func paragraphRectForRange(range: NSRange) -> CGRect {
        guard let layoutManager = layoutManager, let textContainer = textContainer else { return .zero }

        let range = layoutManager.glyphRange(forCharacterRange: range, actualCharacterRange: nil)
        var sectionRect = layoutManager.boundingRect(forGlyphRange: range, in: textContainer)

        // FIXME: don't use this hack
        // This gets triggered for the final paragraph in a textview if the next line is empty (so the last paragraph ends with a newline)
        if sectionRect.origin.x == 0 {
            sectionRect.size.height -= 22
        }

        sectionRect.origin.x = 0

        return sectionRect
    }
}
