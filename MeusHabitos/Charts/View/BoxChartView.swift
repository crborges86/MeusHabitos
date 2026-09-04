//
//  BoxChartView.swift
//  MeusHabitos
//
//  Created by Cristiano Ricardo Borges on 27/08/26.
//

import Foundation
import SwiftUI
import Charts

struct BoxChartView: UIViewRepresentable {
   typealias UIViewType = LineChartView
    
    @Binding var entries: [ChartDataEntry]
    @Binding var dates: [String]
    
    func makeUIView(context: Context) -> LineChartView {
        let uiView = LineChartView()
        
        uiView.legend.enabled = false
        uiView.chartDescription.enabled = false
        uiView.xAxis.granularity = 1
        uiView.xAxis.labelPosition = .bottom
        uiView.rightAxis.enabled = false
        uiView.xAxis.valueFormatter = DateAxisValueFormatter(dates: dates)
        uiView.leftAxis.axisLineColor = .green
        uiView.animate(yAxisDuration: 1.0)
        
        uiView.data = addData()
        
        return uiView
    }
    
    private func addData() -> LineChartData {

        let colors = [UIColor.white.cgColor, UIColor.greenR.cgColor]
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let colorLocations: [CGFloat] = [0.0, 1.0]

        let gradient = CGGradient(colorsSpace: colorSpace,
                                  colors: colors as CFArray,
                                  locations: colorLocations)

        let dataSet = LineChartDataSet(entries: entries, label: "")
        dataSet.mode = .cubicBezier
        dataSet.lineWidth = 2
        dataSet.circleRadius = 4
        dataSet.setColor(.greenR)
        dataSet.circleColors = [.red]
        dataSet.drawFilledEnabled = true
        dataSet.valueColors = [.red]
        dataSet.drawHorizontalHighlightIndicatorEnabled = false

        if let gradient {
            dataSet.drawFilledEnabled = true
            #if canImport(UIKit)
            dataSet.fillAlpha = 1.0
            dataSet.fill = LinearGradientFill(gradient: gradient, angle: 90.0)
            #endif
        } else {
            dataSet.drawFilledEnabled = false
        }

        return LineChartData(dataSet: dataSet)
    }
    
    func updateUIView(_ uiView: LineChartView, context: Context) {
        uiView.data = addData()
        uiView.notifyDataSetChanged()
    }
}

class DateAxisValueFormatter: AxisValueFormatter {
    
    let dates: [String]
    
    init(dates: [String]) {
        self.dates = dates
    }
    
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        let position = Int(value)
        let df = DateFormatter()
        df.locale = Locale(identifier: "en_US_POSIX")
        df.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        
        if position > 0 && position < dates.count {
            let date = df.date(from: dates[ position])
            
            guard let date = date else {
                return ""
            }
            
            let df = DateFormatter()
            df.dateFormat = "dd/MM"
            let createdAt = df.string(from: date)
            
            return createdAt
        } else {
            return ""
        }
    }
}

#Preview {
    BoxChartView(
        entries: .constant([
            ChartDataEntry(x: 1.0, y: 2.0),
            ChartDataEntry(x: 2.0, y: 4.0),
            ChartDataEntry(x: 4.0, y: 3.0)
        ]),
        dates: .constant([
            "01/01/2026",
            "02/01/2026",
            "03/01/2026"
        ]))
    .frame(maxWidth: .infinity, maxHeight: 350)
}
