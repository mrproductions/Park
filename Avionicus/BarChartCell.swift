//
//  BarChartCell.swift
//  Avionicus
//
//  Created by Фамил Гаджиев on 15.05.17.
//  Copyright © 2017 Park Team. All rights reserved.
//

import UIKit
import Charts

class BarChartCell: UITableViewCell {
    
    
    @IBOutlet weak var barChartView: BarChartView!
    
    var chartItem: [TrackDetails]?
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        
        //self.barChartView.delegate = self as? ChartViewDelegate
        //self.barChartView.descriptionText = "Altitude chart"
        //self.barChartView.gridBackgroundColor = .gray
        
        let x: [Double] = [1,1,2,3,23]
        let y: [Double] = [12,3,213,23]
        
        
        //updateChart(x: x, y: y)
        
        
    }
    
    func updateChart(x: [Double], y:[Double]){
        
        var xCoordinate: [ChartDataEntry] = [ChartDataEntry]()
        
        for i in 0..<x.count{
            xCoordinate.append(ChartDataEntry(x: Double(i), y: y[i]))
        }
        
        let setForChart: BarChartDataSet = BarChartDataSet(values: xCoordinate, label: "Altitude Chart")
        
        
        setForChart.axisDependency = .left
        setForChart.setColor(UIColor.whiteTrack)
        setForChart.formLineWidth = 2.0
        setForChart.barBorderColor = .darkGray
        setForChart.highlightColor = .green
        setForChart.drawValuesEnabled = true
        
        var chartDataSet:[BarChartDataSet] = [BarChartDataSet]()
        
        chartDataSet.append(setForChart)
        
        let data: BarChartData = BarChartData(dataSets: chartDataSet)
        
        self.barChartView.data = data
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
