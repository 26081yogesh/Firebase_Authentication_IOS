import FirebaseAuth
import FirebaseCore
import GoogleSignIn
import UIKit

final class GoogleSignInManager {
    static let shared = GoogleSignInManager()

    func signIn() async throws -> AuthDataResult {
        guard let clientID = FirebaseApp.app()?.options.clientID else {
            throw URLError(.badURL)
        }

        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config

        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let rootViewController = windowScene.windows.first?.rootViewController
        else {
            throw URLError(.cannotFindHost)
        }

        let result = try await GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController)

        let user = result.user
        guard let idToken = user.idToken?.tokenString else {
            throw URLError(.badServerResponse)
        }

        let credential = GoogleAuthProvider.credential(
            withIDToken: idToken,
            accessToken: user.accessToken.tokenString
        )

        return try await Auth.auth().signIn(with: credential)
    }
}
