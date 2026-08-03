//
//  SignInView.swift
//  MeusHabitos
//
//  Created by Cristiano Ricardo Borges on 09/01/26.
//

import SwiftUI

struct SignInView: View {
  
  @ObservedObject var viewModel: SignInViewModel

  @State var action: Int? = 0
  
  @State var navigationHidden = true
  
  var body: some View {
    ZStack {
      if case SignInUIState.goToHomeScreen = viewModel.uiState {
        viewModel.homeView()
      } else {
        NavigationView {
          
          ScrollView(showsIndicators: false) {
            
            VStack(alignment: .center, spacing: 20) {
              
              Spacer(minLength: 36)
              
              VStack(alignment: .center, spacing: 8) {
                Image("logo")
                  .resizable()
                  .scaledToFit()
                  .padding(.horizontal, 48)
                
                  Text("Login")
                  .foregroundColor(.greenR)
                  .font(Font.system(.title).bold())
                  .padding(.bottom, 8)
                
                emailField
                
                passwordField
                
                enterButton
                
                registerLink
                
                Text("Copyright - CRB 2026")
                  .foregroundColor(Color.gray)
                  .font(Font.system(size: 13).bold())
                  .padding(.top, 16)
              }
              
            }
            
            if case SignInUIState.error(let value) = viewModel.uiState {
              Text("")
                .alert(isPresented: .constant(true)) {
                  Alert(title: Text("Rabbit"), message: Text(value), dismissButton: .default(Text("Ok")) {
                    // faz algo quando some o alerta
                  })
                }
            }
          }
          .frame(maxWidth:.infinity, maxHeight: .infinity)
          .padding(.horizontal, 32)
          .navigationBarTitle("Login", displayMode: .inline)
          .navigationBarHidden(navigationHidden)
        }
        .onAppear {
          self.navigationHidden = true
        }
        .onDisappear {
          self.navigationHidden = false
        }
      }
    }
  }
  
}

extension SignInView {
  var emailField: some View {
    EditTextView(text: $viewModel.email,
                 placeholder: "E-mail",
                 keyboard: .emailAddress,
                 error: "e-mail inválido",
                 failure: !viewModel.email.isEmail())
  }
}

extension SignInView {
  var passwordField: some View {
    EditTextView(text: $viewModel.password,
                 placeholder: "Senha",
                 keyboard: .emailAddress,
                 error: "senha deve ter ao menos 8 caracteres",
                 failure: viewModel.password.count < 8,
                 isSecure: true)
  }
}

extension SignInView {
  var enterButton: some View {
    LoadingButtonView(action: {
      viewModel.login()
    },
    text: "Entrar",
    showProgress: self.viewModel.uiState == SignInUIState.loading,
    disabled: !viewModel.email.isEmail() || viewModel.password.count < 8)
  }
}

extension SignInView {
  var registerLink: some View {
    VStack {
      Text("Ainda não possui um login ativo?")
        .foregroundColor(.gray)
        .padding(.top, 48)
      
      ZStack {
        NavigationLink(
          destination: viewModel.signUpView(),
          tag: 1,
          selection: $action,
          label: { EmptyView() })
        
        Button("Realize seu Cadastro") {
          self.action = 1
        }.foregroundColor(Color.greenR)
      }
      
    }
  }
}

#Preview {
    SignInView(viewModel: SignInViewModel(interactor: SignInInteractor()))
        .preferredColorScheme(.light)
}
