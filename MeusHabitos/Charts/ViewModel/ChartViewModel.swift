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
    
    @Published var entries: [ChartDataEntry] = [
        ChartDataEntry(x: 1.0, y: 2.0),
        ChartDataEntry(x: 2.0, y: 5.0),
        ChartDataEntry(x: 3.0, y: 6.0),
        ChartDataEntry(x: 4.0, y: 7.0),
        ChartDataEntry(x: 5.0, y: 8.0),
        ChartDataEntry(x: 6.0, y: 10.0),
        ChartDataEntry(x: 7.0, y: 2.0),
        ChartDataEntry(x: 8.0, y: 5.0),
        ChartDataEntry(x: 9.0, y: 6.0),
        ChartDataEntry(x: 10.0, y: 7.0),
    ]
    @Published var dates = [
        "01/08/2026",
        "02/08/2026",
        "03/08/2026",
        "04/08/2026",
        "05/08/2026",
        "06/08/2026",
        "07/08/2026",
        "08/08/2026",
        "09/08/2026",
        "10/08/2026",
    ]
    
}
