//
//  HomeViewModel.swift
//  MeusHabitos
//
//  Created by Cristiano Ricardo Borges on 16/01/26.
//

import Foundation
import Combine
import SwiftUI

class HomeViewModel: ObservableObject {
    let viewModel = HabitViewModel(interactor: HabitInteractor())
}

extension HomeViewModel {
    func habitView() -> some View {
        return HomeViewRouter.makeHabitView(viewModel: viewModel)
    }
    
    
    func profileView() -> some View {
        return HomeViewRouter.makeProfileView()
    }
}
