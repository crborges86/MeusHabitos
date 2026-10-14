//
//  SplashViewRouter.swift
//  MeusHabitos
//
//  Created by Cristiano Ricardo Borges on 09/01/26.
//

import SwiftUI

enum SplashViewRouter {
    
    static func makeSignInView() -> some View {
        let homeViewModel = HomeViewModel()
        
        let viewModel = SignInViewModel(interactor: SignInInteractor(), homeViewModel: homeViewModel)
        return SignInView(viewModel: viewModel)
    }
    
    static func makeHomeView() -> some View {
        let viewModel = HomeViewModel()
        return HomeView(viewModel: viewModel)
    }
    
}
