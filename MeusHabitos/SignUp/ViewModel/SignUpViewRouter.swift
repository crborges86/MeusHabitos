//
//  SignUpViewRouter.swift
//  MeusHabitos
//
//  Created by Cristiano Ricardo Borges on 28/01/26.
//

import SwiftUI

enum SignUpViewRouter {
  
  static func makeHomeView() -> some View {
    let viewModel = HomeViewModel()
    return HomeView(viewModel: viewModel)
  }
  
}
