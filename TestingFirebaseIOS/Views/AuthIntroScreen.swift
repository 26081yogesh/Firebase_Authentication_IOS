import FirebaseAuth
import SwiftUI

struct AuthIntroScreen: View {
    var body: some View {
        VStack(spacing: 30) {
            VStack(spacing: 10) {
                Image(systemName: "person.crop.circle")
                    .resizable()
                    .frame(width: 100, height: 100)

                Text("Welcome 👋")
                    .font(.largeTitle)
                    .fontWeight(.bold)

                Text("Let’s get you started")
                    .foregroundColor(.gray)
                    .font(.subheadline)
            }
            .padding(.top, 40)

            Spacer()

            VStack(spacing: 15) {
//                MARK: Sign Up With Email

                NavigationLink {
                    SignUpWithEmailView()
                } label: {
                    Text("Create Account")
                        .font(.title3)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 55)
                        .background(Color.black)
                        .cornerRadius(12)
                }

//                MARK: Sign In With Email

                NavigationLink {
                    SignInWithEmailView()
                } label: {
                    Text("Sign In")
                        .font(.title3)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 55)
                        .background(Color.black)
                        .cornerRadius(12)
                }

//                MARK: Google Sign In

                Button {
                    Task {
                        do {
                            let result = try await GoogleSignInManager.shared.signIn()
                            print("Google user:", result.user.email ?? "")
                        } catch {
                            print(error)
                        }
                    }
                } label: {
                    HStack {
                        Image("googlelogo")
                            .resizable()
                            .frame(width: 50, height: 50)
                        Text("Google Sign In")
                            .font(.title3)
                            .foregroundColor(.white)
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 55)
                    .background(Color.black)
                    .cornerRadius(12)
                }
            }
            .padding()
            .background(Color.white)
            .cornerRadius(18)
            .shadow(color: .black.opacity(0.05), radius: 10, x: 0, y: 5)

            Spacer()
        }
        .padding()
    }
}

#Preview {
    AuthIntroScreen()
}
