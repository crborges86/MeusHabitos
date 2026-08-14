//
//  ProfileView.swift
//  MeusHabitos
//
//  Created by Cristiano Ricardo Borges on 06/08/26.
//

import Foundation
import SwiftUI

struct ProfileView: View {
    
    @ObservedObject var viewModel: ProfileViewModel
    
    var disableDone: Bool {
        viewModel.fullNameValidation.failure || viewModel.phoneValidation.failure || viewModel.birthdayValidation.failure
    }
    
    var body: some View {
        
        ZStack {
            
            if case ProfileUIState.loading = viewModel.uiState {
                ProgressView()
            } else {
                
                NavigationView {
                    VStack {
                        Form {
                            
                            Section(header: Text("Dados Cadastrais")) {
                                HStack {
                                    Text("Nome")
                                    Spacer()
                                    TextField("Digite o nome", text: $viewModel.fullNameValidation.value)
                                        .keyboardType(.alphabet)
                                        .multilineTextAlignment(.trailing)
                                }
                                
                                if viewModel.fullNameValidation.failure{
                                    Text("Nome deve ter mais de 3 caracteres")
                                        .foregroundColor(.red)
                                }
                                
                                HStack {
                                    Text("E-mail")
                                    Spacer()
                                    TextField("", text: $viewModel.email)
                                        .disabled(true)
                                        .foregroundColor(Color.gray)
                                        .multilineTextAlignment(.trailing)
                                }
                                
                                HStack {
                                    Text("CPF")
                                    Spacer()
                                    TextField("", text: $viewModel.document)
                                        .disabled(true)
                                        .foregroundColor(Color.gray)
                                        .multilineTextAlignment(.trailing)
                                }
                                
                                HStack {
                                    Text("Telefone")
                                    Spacer()
                                    TextField("Digite o telefone", text: $viewModel.phoneValidation.value)
                                        .keyboardType(.numberPad)
                                        .multilineTextAlignment(.trailing)
                                }
                                
                                if viewModel.phoneValidation.failure{
                                    Text("Entre com DDD + 8 ou 9 digitos")
                                        .foregroundColor(.red)
                                }
                                
                                HStack {
                                    Text("Data de nascimento")
                                    Spacer()
                                    TextField("Digite a sua data de nascimento", text: $viewModel.birthdayValidation.value)
                                        .multilineTextAlignment(.trailing)
                                }
                                
                                if viewModel.birthdayValidation.failure{
                                    Text("Data deve ser dd/MM/yyyy")
                                        .foregroundColor(.red)
                                }
                                
                                NavigationLink(
                                    destination: GenderSelectorView(selectedGender: $viewModel.gender, genders: Gender.allCases, title: "Escolha o gênero"),
                                    label: {
                                        HStack {
                                            Text("Gênero")
                                            Spacer()
                                            Text(viewModel.gender?.rawValue ?? "")
                                        }
                                    })
                            }
                            
                        }
                    }
                    .navigationBarTitle(Text("Editar Perfil"), displayMode: .automatic)
                    .navigationBarItems(trailing: Button(action: {}, label: {
                        Image(systemName: "checkmark")
                            .foregroundColor(.greenR)
                    })
                        .opacity(disableDone ? 0 : 1)
                                        
                    )
                }
            }
                if case ProfileUIState.fetchError(let value) = viewModel.uiState {
                    Text("")
                        .alert(isPresented: .constant(true)) {
                            Alert(title: Text("Rabbit"),
                                  message: Text(value),
                                  dismissButton: .default(Text("Ok")) {
                            })
                        }
                }
                
            }.onAppear(perform: viewModel.fetchUser)
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(viewModel: ProfileViewModel(interactor: ProfileInteractor()))
    }
}
