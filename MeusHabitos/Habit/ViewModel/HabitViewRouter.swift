//
//  HabitViewRouter.swift
//  MeusHabitos
//
//  Created by Cristiano Ricardo Borges on 08/09/26.
//

import Foundation
import Combine
import SwiftUI

enum HabitViewRouter {
    static func makeHabitCreateView(habitPublisher: PassthroughSubject<Bool, Never>) -> some View {
        let viewModel = HabitCreateViewModel(interactor: HabitDetailInteractor())
        viewModel.habitPublisher = habitPublisher
        return HabitCreateView(viewModel: viewModel)
    }
}
