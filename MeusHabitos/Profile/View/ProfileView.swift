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
    
    @State var fullName = ""
    @State var email = "jobs@gmail.com"
    @State var cpf = "123.456.789-0"
    @State var phone = "(19) 98787-7878"
    @State var birthDate = "10/10/1970"
    @State var selectedGender: Gender? = .male
    
    var body: some View {
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
                            TextField("", text: $email)
                                .disabled(true)
                                .foregroundColor(Color.gray)
                                .multilineTextAlignment(.trailing)
                        }
                        
                        HStack {
                            Text("CPF")
                            Spacer()
                            TextField("", text: $cpf)
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
                            destination: GenderSelectorView(selectedGender: $selectedGender, genders: Gender.allCases, title: "Escolha o gênero"),
                            label: {
                                HStack {
                                    Text("Gênero")
                                    Spacer()
                                    Text(selectedGender?.rawValue ?? "")
                                }
                            })
                    }
                    
                }
            }
            .navigationBarTitle(Text("Editar Perfil"), displayMode: .automatic)
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(viewModel: ProfileViewModel())
    }
}
