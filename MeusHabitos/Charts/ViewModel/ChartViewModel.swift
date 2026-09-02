//
//  C hartViewModel.swift
//  MeusHabitos
//
//  Created by Cristiano Ricardo Borges on 27/08/26.
//

import SwiftUI
import Charts
import Combine

class ChartViewModel: ObservableObject {
    
    @Published var uiState = ChartUIState.loading
    
    @Published var entries: [ChartDataEntry] = []
    
    @Published var dates: [String] = []
    
    private var cancellable: AnyCancellable?
    
    private let habitID: Int
    private let interactor: ChartInteractor
    
    init(habitId: Int, interactor: ChartInteractor) {
        self.habitID = habitId
        self.interactor = interactor
    }
    
    deinit {
        cancellable?.cancel()
    }
    
    func onAppear() {
        cancellable = interactor.fetchHabitValues(habitId: habitID)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let appError):
                    self.uiState = .error(appError.message)
                case .finished:
                    break
                }
            }, receiveValue: { res in
                print(res)
            })
    }
    
}
