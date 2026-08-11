//
//  ProfileView.swift
//  MeusHabitos
//
//  Created by Cristiano Ricardo Borges on 06/08/26.
//

import Foundation
import SwiftUI

struct ProfileView: View {
    
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
                            TextField("Digite o nome", text: $fullName)
                                .keyboardType(.alphabet)
                                .multilineTextAlignment(.trailing)
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
                            TextField("Digite o telefone", text: $phone)
                                .keyboardType(.numberPad)
                                .multilineTextAlignment(.trailing)
                        }
                        
                        HStack {
                            Text("Data de nascimento")
                            Spacer()
                            TextField("Digite a sua data de nascimento", text: $birthDate)
                                .multilineTextAlignment(.trailing)
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
        ProfileView()
    }
}
