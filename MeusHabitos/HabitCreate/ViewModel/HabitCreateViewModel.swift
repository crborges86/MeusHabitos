//
//  HabitCreateViewModel.swift
//  MeusHabitos
//
//  Created by Cristiano Ricardo Borges on 08/09/26.
//

import Foundation
import SwiftUI
import Combine

class HabitCreateViewModel: ObservableObject {
    
    @Published var uiState: HabitDetailUIState = .none
    @Published var name = ""
    @Published var label = ""
    
    @Published var image: Image? = Image(systemName: "camera.fill")
    
    @Published var imageData: Data? = nil
    
    private var cancellable: AnyCancellable?
    var cancellables = Set<AnyCancellable>()
    var habitPublisher: PassthroughSubject<Bool, Never>?
    
    let interactor: HabitDetailInteractor
    
    init(interactor: HabitDetailInteractor) {
        self.interactor = interactor
    }
    
    deinit{
        cancellable?.cancel()
        for cancellable in cancellables {
            cancellable.cancel()
        }
    }
    func save() {
        self.uiState = .loading
    }
    
}
