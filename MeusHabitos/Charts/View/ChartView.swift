//
//  ChartView.swift
//  MeusHabitos
//
//  Created by Cristiano Ricardo Borges on 24/08/26.
//

import SwiftUI
import Charts

struct ChartView: View {
    
    @ObservedObject var viewModel: ChartViewModel
    
    var body: some View {
        BoxChartView(entries: $viewModel.entries, dates: $viewModel.dates)
            .frame(maxWidth: .infinity, maxHeight: 350)
    }
}
//teste

#Preview {
    ChartView(viewModel: ChartViewModel())
}
