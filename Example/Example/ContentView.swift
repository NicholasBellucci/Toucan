//
//  ContentView.swift
//  Example
//
//  Created by Nicholas Bellucci on 12/12/20.
//

import SwiftUI

struct ContentView: View {
    @State private var swift: String = ""

    var body: some View {
        SyntaxTextView(
            text: $swift,
            theme: DefaultTheme()
        )
        .cornerRadius(5)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
