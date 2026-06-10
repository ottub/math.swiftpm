// PlaygroundApp.swift: kept for reference but no @main here to avoid duplicate
// If you want to run the playground directly, open Math.playground/Contents.swift
// or Pages/Page1.playgroundpage/Contents.swift in Swift Playgrounds on iPad.

import SwiftUI

struct PlaygroundReference_TitleView: View {
    var body: some View {
        Text("Playground title view (reference)")
            .font(.headline)
            .padding()
    }
}

// Preview for development in Xcode-like editors
#if DEBUG
struct PlaygroundReference_Previews: PreviewProvider {
    static var previews: some View { PlaygroundReference_TitleView() }
}
#endif
