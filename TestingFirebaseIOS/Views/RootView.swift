import SwiftUI

struct RootView: View {
    @State private var vm = AuthViewModel()

    var body: some View {
        if vm.user != nil {
            HomeScreen()
        } else {
            AuthFlowView()
        }
    }
}
