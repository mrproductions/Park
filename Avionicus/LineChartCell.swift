//
//  LineChartCell.swift
//  Avionicus
//
//  Created by Фамил Гаджиев on 15.05.17.
//  Copyright © 2017 Park Team. All rights reserved.
//

import UIKit
import Charts

class LineChartCell: UITableViewCell {
    
    
    @IBOutlet weak var lineChartView: LineChartView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    
        self.lineChartView.delegate = self as? ChartViewDelegate
        self.lineChartView.chartDescription?.text = "Altitude chart"
        self.lineChartView.gridBackgroundColor = .gray

        let x: [Double] = [1,1,2,3]
        let y: [Double] = [1,3,2,2]

        updateChart(x: x, y: y)
    }

    
    func updateChart(x: [Double], y:[Double]){
        
        var Coordinate: [ChartDataEntry] = [ChartDataEntry]()
        
        let x: [Double] = [1,1,2,3]
        let y: [Double] = [1,3,2,2]
        
        for i in 0..<x.count{
            Coordinate.append(ChartDataEntry(x: Double(i), y: y[i]))
        }
        
        let setForChart: LineChartDataSet = LineChartDataSet(values: Coordinate, label: "Altitude Chart")
        
        
        setForChart.axisDependency = .left
        setForChart.setColor(UIColor.whiteTrack)
        setForChart.formLineWidth = 2.0
        setForChart.circleHoleColor = .darkGray
        setForChart.highlightColor = .green
        setForChart.drawValuesEnabled = true
        
        var chartDataSet:[LineChartDataSet] = [LineChartDataSet]()
        
        chartDataSet.append(setForChart)
        
        let data: BarChartData = BarChartData(dataSets: chartDataSet)
        
        self.lineChartView.data = data
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
