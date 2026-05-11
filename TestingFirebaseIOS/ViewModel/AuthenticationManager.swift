import FirebaseAuth
import Foundation

struct AuthDataResultModel {
    let uid: String
    let email: String?
    let photoUrl: String?

    init(user: User) {
        uid = user.uid
        email = user.email
        photoUrl = user.photoURL?.absoluteString
    }
}

final class AuthenticationManager {
    static let shared = AuthenticationManager()

    func getAuthenticatedUser() throws -> AuthDataResultModel {
        guard let user = Auth.auth().currentUser else {
            throw URLError(.badServerResponse)
        }

        return AuthDataResultModel(user: user)
    }

    func createUser(email: String, password: String) async throws -> AuthDataResultModel {
        let authDataResult = try await Auth.auth().createUser(withEmail: email, password: password)

        return AuthDataResultModel(user: authDataResult.user)
    }

    func signIn(email: String, password: String) async throws -> AuthDataResultModel {
        let authDateResult = try await Auth.auth().signIn(withEmail: email, password: password)

        return AuthDataResultModel(user: authDateResult.user)
    }

    func resetPasswordLink(email: String) async {
        do {
            try await Auth.auth().sendPasswordReset(withEmail: email)
            print("Email sent successfully")
        } catch {
            print(error.localizedDescription)
        }
    }

    func signOut() throws {
        try Auth.auth().signOut()
    }
}
