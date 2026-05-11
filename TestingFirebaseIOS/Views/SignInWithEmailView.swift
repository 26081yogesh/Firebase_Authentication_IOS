import SwiftUI

struct SignInWithEmailView: View {
    @State private var signInEmailModel = SignInEmailViewModel()

    @State private var showResetSheet = false
    @State private var resetEmail = ""
    @State private var showResetEmailSentAlert = false

    var body: some View {
        VStack(spacing: 25) {
            VStack(alignment: .leading, spacing: 8) {
                Text("Welcome Back 👋")
                    .font(.largeTitle)
                    .fontWeight(.bold)

                Text("Sign in to continue")
                    .foregroundColor(.gray)
            }
            .frame(maxWidth: .infinity, alignment: .leading)

            VStack(spacing: 15) {
                TextField("Email", text: $signInEmailModel.signInEmail)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(12)

                SecureField("Password", text: $signInEmailModel.signInPassword)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(12)

                HStack {
                    Spacer()

                    Button {
                        showResetSheet = true
                    } label: {
                        Text("Forgot Password?")
                            .font(.footnote)
                            .foregroundColor(.blue)
                    }
                }
            }
            .padding()
            .background(Color.white)
            .cornerRadius(16)
            .shadow(color: .black.opacity(0.05), radius: 10, x: 0, y: 5)

            Button {
                Task {
                    try? await AuthenticationManager.shared.signIn(
                        email: signInEmailModel.signInEmail,
                        password: signInEmailModel.signInPassword
                    )
                }
            } label: {
                Text("Sign In")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 55)
                    .background(Color.blue)
                    .cornerRadius(12)
            }

            Spacer()
        }
        .padding()
        .navigationTitle("Sign In")
        .alert("Success", isPresented: $showResetEmailSentAlert) {
            Button("OK", role: .cancel) {}
        } message: {
            Text("Reset email has been sent. Please check your inbox.")
        }

        .sheet(isPresented: $showResetSheet) {
            VStack(spacing: 20) {
                Text("Reset Password")
                    .font(.title2)
                    .fontWeight(.bold)

                Text("Enter your email to receive reset link")
                    .font(.footnote)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)

                TextField("Email", text: $resetEmail)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(12)

                Button {
                    Task {
                        await AuthenticationManager.shared.resetPasswordLink(email: resetEmail)

                        showResetSheet = false

                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                            showResetEmailSentAlert = true
                        }
                    }
                } label: {
                    Text("Send Link")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(Color.red)
                        .cornerRadius(12)
                }

                Button("Cancel") {
                    showResetSheet = false
                }
                .foregroundColor(.gray)
            }
            .padding()
            .presentationDetents([.medium])
        }
    }
}

#Preview {
    SignInWithEmailView()
}
