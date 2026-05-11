import Foundation

@Observable
final class SignInEmailViewModel {
    var signInEmail = ""
    var signInPassword = ""
    var showError: Bool = false
    var errorMessage: String = ""

    func signIn() async {
        do {
            print("Email - \(signInEmail)")
            print("Password - \(signInPassword)")

            try await AuthenticationManager.shared.signIn(email: signInEmail, password: signInPassword)

            print("Signed in successfully")
        } catch {
            errorMessage = error.localizedDescription
            showError = true
            print("Error - \(error.localizedDescription)")
        }
    }
}
