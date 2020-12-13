import Foundation
import SwiftUI

public struct SyntaxTextView: NSViewRepresentable {
    @Binding private var text: String
    private var lexer: Lexer
    private var theme: EditorTheme
    private var didBeginEditing: (() -> ())?
    private var didChange: ((String) -> ())?

    public init(
        text: Binding<String>,
        theme: EditorTheme = DefaultThemeLight(),
        lexer: Lexer = SwiftLexer(),
        didBeginEditing: (() -> ())? = nil,
        didChange: ((String) -> ())? = nil
    ) {
        _text = text
        self.theme = theme
        self.lexer = lexer
        self.didBeginEditing = didBeginEditing
        self.didChange = didChange
    }

    public func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    public func makeNSView(context: Context) -> SyntaxView {
        let wrappedView = SyntaxView()
        wrappedView.delegate = context.coordinator
        wrappedView.theme = theme
        wrappedView.lexer = lexer
        wrappedView.textView.insertionPointColor = theme.cursorColor

        context.coordinator.wrappedView = wrappedView
        context.coordinator.wrappedView.text = text

        return wrappedView
    }

    public func updateNSView(_ view: SyntaxView, context: Context) {
        context.coordinator.wrappedView.text = text
        view.selectedRanges = context.coordinator.selectedRanges
    }
}

extension SyntaxTextView {
    public class Coordinator: SyntaxViewDelegate {
        let parent: SyntaxTextView
        var wrappedView: SyntaxView!
        var selectedRanges: [NSValue] = []

        init(_ parent: SyntaxTextView) {
            self.parent = parent
        }

        public func textViewTextDidChange(_ editorTextView: EditorTextView) {
            selectedRanges = editorTextView.selectedRanges
            parent.text = editorTextView.text
            parent.didChange?(editorTextView.text)
        }

        public func textViewDidBeginEditing(_ editorTextView: EditorTextView) {
            parent.didBeginEditing?()
        }
    }
}
