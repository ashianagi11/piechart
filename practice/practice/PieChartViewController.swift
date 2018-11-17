//
//  PieChartViewController.swift
//  practice
//
//  Created by Ashia Nagi on 11/17/18.
//  Copyright © 2018 Ashia Nagi. All rights reserved.
//

import UIKit
import Charts

class PieChartViewController: UIViewController {
    
    
    @IBOutlet weak var hello: UILabel!
    
    
    @IBOutlet weak var piechart: PieChartView!
    
    @IBOutlet weak var stepper1: UIStepper!
    
    @IBOutlet weak var stepper2: UIStepper!
    
    var steppers = PieChartDataEntry(value: 0)
    var stepperss = PieChartDataEntry(value: 0)
    
    var downloads = [PieChartDataEntry]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        piechart.chartDescription?.text = ""
        //8.30 to add the values
        
        steppers.value = stepper1.value
        steppers.label = "ios"
        
        stepperss.value = stepper2.value
        stepperss.label = "mac"
        
        downloads = [stepperss, steppers]
        
        updateChartData()
    }
    
    
    @IBAction func change(_ sender: UIStepper) {
        steppers.value = sender.value
        updateChartData()
    }
    
    @IBAction func changed(_ sender: UIStepper) {
        stepperss.value = sender.value
        updateChartData()
    }
    
    func updateChartData() {
        
        let chartDataSet = PieChartDataSet(values: downloads, label: nil)
        let chartData = PieChartData(dataSet: chartDataSet)
        
        //colors
    
        let colors = [UIColor.red, UIColor.blue]
        
        chartDataSet.colors = colors
        
        piechart.data = chartData

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
