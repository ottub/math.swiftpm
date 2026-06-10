import SwiftUI
import Math

@main
struct TestApp: App {
    @StateObject private var musicManager = BackgroundMusicManager()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .onAppear {
                    musicManager.start()
                }
        }
    }
}
