import SwiftUI

struct SignUpWithEmailView: View {
    @State var createUserModel = CreateUserModel()

    var body: some View {
        VStack(spacing: 25) {
            VStack(alignment: .leading, spacing: 8) {
                Text("Create Account 🚀")
                    .font(.largeTitle)
                    .fontWeight(.bold)

                Text("Sign up to get started")
                    .foregroundColor(.gray)
            }
            .frame(maxWidth: .infinity, alignment: .leading)

            VStack(spacing: 15) {
                TextField("Email", text: $createUserModel.createUserEmail)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(12)

                SecureField("Password", text: $createUserModel.createUserPassword)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(12)
            }
            .padding()
            .background(Color.white)
            .cornerRadius(16)
            .shadow(color: .black.opacity(0.05), radius: 10, x: 0, y: 5)

            Button {
                Task {
                    try await AuthenticationManager.shared.createUser(
                        email: createUserModel.createUserEmail,
                        password: createUserModel.createUserPassword
                    )
                }
            } label: {
                Text("Create Account")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 55)
                    .background(Color.blue)
                    .cornerRadius(12)
                    .shadow(color: .blue.opacity(0.3), radius: 8, x: 0, y: 4)
            }

            Spacer()
        }
        .padding()
        .navigationTitle("Sign Up")
    }
}

#Preview {
    SignUpWithEmailView()
}
