//
//  SplashViewModel.swift
//  MeusHabitos
//
//  Created by Cristiano Ricardo Borges on 08/01/26.
//

import Foundation
import Combine
import SwiftUI

final class SplashViewModel: ObservableObject {
    
    @Published var uiState: SplashUIState = .loading
    
    private var cancellableAuth: AnyCancellable?
    private var cancellableRefresh: AnyCancellable?
    
    private let interactor: SplashInteractor
    
      init(interactor: SplashInteractor) {
      self.interactor = interactor
    }
    
    deinit {
      cancellableAuth?.cancel()
      cancellableRefresh?.cancel()
    }
    
    func onAppear() {
        cancellableAuth = interactor.fetchAuth()
            .receive(on: DispatchQueue.main)
            .sink { userAuth in
                
                if userAuth == nil {
                    self.uiState = .goToSignInScreen
                } else if (Date().timeIntervalSince1970 > Double(userAuth!.expires)){
                    print("token expirado")
                    let request = RefreshRequest(token: userAuth!.refreshToken)
                    self.cancellableRefresh = self.interactor.refreshToken(refreshRequest: request)
                        .receive(on: DispatchQueue.main)
                        .sink(receiveCompletion: { completion in
                            switch(completion){
                            case.failure(_):
                                self.uiState = .goToSignInScreen
                                break
                            default:
                                break
                            }
                        },receiveValue: { sucess in
                                let auth = UserAuth(idToken: sucess.acessToken,
                                                    refreshToken: sucess.refreshToken,
                                                    expires: Date().timeIntervalSince1970 + Double(sucess.expires),
                                                    tokenType: sucess.tokenType)
                                
                                self.interactor.insertAuth(userAuth: auth)
                                
                                    self.uiState = .goToHomeScreen
                        })
                    
                } else {
                    self.uiState = .goToHomeScreen
                }
            }
    }
}

    extension SplashViewModel {
    func signInView () -> some View {
        return SplashViewRouter.makeSignInView()
    }
        func homeView() -> some View {
            return SplashViewRouter.makeHomeView()
        }
}
