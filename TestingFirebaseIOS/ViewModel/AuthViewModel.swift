import FirebaseAuth
import Foundation

// MARK: Handles Firebase Listeners

@MainActor
@Observable
class AuthViewModel {
    var user: User?
    private var handle: AuthStateDidChangeListenerHandle?

    init() {
        handle = Auth.auth().addStateDidChangeListener { _, user in
            Task {
                self.user = user
            }
        }
    }
}
