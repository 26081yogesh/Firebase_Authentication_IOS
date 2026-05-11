import FirebaseAuth
import SwiftUI

struct HomeScreen: View {
    var body: some View {
        VStack(spacing: 30) {
            VStack(alignment: .leading, spacing: 8) {
                Text("Welcome Back 👋")
                    .font(.system(size: 34, weight: .bold))

                Text("You're successfully signed in")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            .frame(maxWidth: .infinity, alignment: .leading)

            VStack(alignment: .leading, spacing: 12) {
                Text("Account Details")
                    .font(.headline)
                    .foregroundColor(.gray)

                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Email")
                            .font(.caption)
                            .foregroundColor(.gray)

                        Text(Auth.auth().currentUser?.email ?? "No Email")
                            .font(.body)
                            .fontWeight(.semibold)
                    }

                    Spacer()

                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .frame(width: 40, height: 40)
                        .foregroundColor(.blue)
                }
            }
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(15)

            Spacer()

            Button {
                Task {
                    try? AuthenticationManager.shared.signOut()
                }
            } label: {
                Text("Log Out")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .frame(height: 55)
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(12)
                    .shadow(color: .red.opacity(0.3), radius: 5, x: 0, y: 3)
            }
        }
        .padding()
        .navigationTitle("Home")
    }
}
