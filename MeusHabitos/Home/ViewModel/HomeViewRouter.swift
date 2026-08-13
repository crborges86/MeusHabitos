//
//  HomeViewRouter.swift
//  MeusHabitos
//
//  Created by Cristiano Ricardo Borges on 22/06/26.
//

import Foundation
import SwiftUI

enum HomeViewRouter {
    static func makeHabitView(viewModel: HabitViewModel) -> some View {
        return HabitView(viewModel: viewModel)
    }
    
    static func makeProfileView(viewModel: ProfileViewModel) -> some View {
        return ProfileView(viewModel: viewModel)
    }
}
