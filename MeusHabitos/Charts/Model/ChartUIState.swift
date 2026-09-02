//
//  ChartUIState.swift
//  MeusHabitos
//
//  Created by Cristiano Ricardo Borges on 02/09/26.
//

import Foundation

enum ChartUIState: Equatable {
    case loading
    case emptyChart
    case fullChart
    case error(String)
}
