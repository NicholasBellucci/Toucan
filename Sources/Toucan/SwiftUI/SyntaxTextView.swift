import Foundation
import SwiftUI

public struct SyntaxTextView: NSViewRepresentable {
    public struct Customization {

        var insertionPointColor: NSColor
        var lexerForSource: Lexer
        var theme: CodeTheme
        var didBeginEditing: (() -> ())?
        var didChange: ((String) -> ())?

        /// Creates a **Customization** to pass into the *init()* of a **SourceCodeTextEditor**.
        ///
        /// - Parameters:
        ///     - didChangeText: A SyntaxTextView delegate action.
        ///     - lexerForSource: The lexer to use (default: SwiftLexer()).
        ///     - insertionPointColor: To customize color of insertion point caret (default: .white).
        ///     - textViewDidBeginEditing: A SyntaxTextView delegate action.
        ///     - theme: Custom theme (default: DefaultSourceCodeTheme()).
        public init(
            insertionPointColor: NSColor = .white,
            lexerForSource: Lexer = SwiftLexer(),
            theme: CodeTheme = DefaultTheme(),
            didBeginEditing: (() -> ())? = nil,
            didChange: ((String) -> ())? = nil
        ) {
            self.insertionPointColor = insertionPointColor
            self.lexerForSource = lexerForSource
            self.theme = theme
            self.didBeginEditing = didBeginEditing
            self.didChange = didChange
        }
    }

    @Binding private var text: String
    private var custom: Customization

    public init(
        text: Binding<String>,
        customization: Customization = Customization()
    ) {
        _text = text
        self.custom = customization
    }

    public func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    public func makeNSView(context: Context) -> SyntaxView {
        let wrappedView = SyntaxView()
        wrappedView.delegate = context.coordinator
        wrappedView.theme = custom.theme
        wrappedView.textView.insertionPointColor = custom.insertionPointColor

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

        public func lexerForSource(_ source: String) -> Lexer {
            parent.custom.lexerForSource
        }

        public func textViewTextDidChange(_ editorTextView: EditorTextView) {
            selectedRanges = editorTextView.selectedRanges
            parent.text = editorTextView.text
            parent.custom.didChange?(editorTextView.text)
        }

        public func textViewDidBeginEditing(_ editorTextView: EditorTextView) {
            parent.custom.didBeginEditing?()
        }
    }
}
