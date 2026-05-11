import Combine
import Foundation

@Observable
class CreateUserModel {
    var createUserEmail = ""
    var createUserPassword = ""

    func createUser() async throws {
        do {
            try await AuthenticationManager.shared.createUser(email: createUserEmail, password: createUserPassword)
            print("User Created Successfully Using Email")
        } catch {
            print("Error - \(error.localizedDescription)")
        }
    }
}
