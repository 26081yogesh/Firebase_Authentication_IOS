import FirebaseCore
import SwiftUI

@main
struct TestingFirebaseIOSApp: App {
//    MARK: Firebase Initialization

    init() {
        print("Firebase Configured")
        FirebaseApp.configure()
    }

    var body: some Scene {
        WindowGroup {
            RootView()
        }
    }
}
