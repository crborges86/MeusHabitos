//
//  SplashView.swift
//  MeusHabitos
//
//  Created by Cristiano Ricardo Borges on 07/01/26.
//

import SwiftUI

struct SplashView: View {
    
    @ObservedObject var viewModel: SplashViewModel
    
    var body: some View{
        Group {
            switch viewModel.uiState {
            case .loading:
                loadingView()
            case .goToSignInScreen:
                viewModel.signInView()
            case .goToHomeScreen:
                viewModel.homeView()
            case .error(let msg):
                loadingView(error: msg)
          }
        }.onAppear(perform: {
            viewModel.onAppear()
        })
    }
}

extension SplashView {
    func loadingView(error: String? = nil) -> some View{
        ZStack{
            Image("logo")
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding(20)
                .ignoresSafeArea()
            
            if let error = error {
                Color.clear
                    .alert("Meus Hábitos", isPresented: .constant(true), actions: {
                        Button("Ok", role: .cancel) {}
                    }, message: {
                        Text(error)
                    })
            }
        }
    }
}

#Preview {
    SplashView(viewModel: SplashViewModel(interactor: SplashInteractor()))
        .preferredColorScheme(.light)
}
