//
//  AuthenticatedView.swift
//  LMessenger
//
//

import SwiftUI

struct AuthenticatedView: View {
    @EnvironmentObject var container: DIContainer
    @StateObject var authViewModel: AuthenticationViewModel
    
    var body: some View {
        VStack {
            switch authViewModel.authenticationState {
            case .unauthenticated:
                LoginIntroView()
                    .environmentObject(authViewModel)
            case .authenticated:
                MainTabView()
                    .environment(\.managedObjectContext, container.searchDataController.persistantContainer.viewContext)
                    .environmentObject(authViewModel)
                    .onAppear {
                        authViewModel.send(action: .requestPushNotification)
                    }
            }
        }
        .onAppear {
             authViewModel.send(action: .checkAuthenticationState)
        }
        .preferredColorScheme(container.appearanceController.appearance.colorScheme)
    }
}

struct AuthenticatedView_Previews: PreviewProvider {
    static let container: DIContainer = .stub
    
    static var previews: some View {
        AuthenticatedView(authViewModel: .init(container: Self.container))
            .environmentObject(Self.container)
    }
}
