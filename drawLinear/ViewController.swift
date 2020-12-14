//
//  ViewController.swift
//  drawLinear
//
//  Created by jiang on 2020/12/2.
//111

import UIKit

class ViewController: UIViewController,JWLineChartDelegate,JWBarChartDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        chart.delegate = self
        chart.lineType = .circleLine
        chart.reloaData()
        self.view.addSubview(chart)
        //tmd wnm
        self.view.addSubview(barchart)
        barchart.delegate = self
       
        // Do any additional setup after loading the view.
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let tou = touches.first
        
        if CGRect(x: 0, y: 300, width: 200, height: 200).contains( tou!.location(in: self.view)) {
            self.chart.reloaData()
            barchart.reloaData()
        }
        
    }
    lazy var  barchart = {JWBarChart(frame: CGRect(x: 13, y: 399, width: self.view.frame.width - 26, height: 220))}()
    lazy var  chart:JWLineChart = {JWLineChart(frame: CGRect(x: 13, y: 0, width: self.view.frame.width - 26, height: 280))}()
    func yValuesForLineChart() -> [CGFloat] {
        return [10000,20000,3000,0,1000,189,1000,19998,40000,30000,0,9000]
    }
     func titlesForXline() -> [String] {
        return ["10-1","10-2","10-3","10-4","10-5","10-6","10-7","10-8","10-9","10-10","10-11","10-12"]
    }
    func titlesForYLine() -> [String] {
        return ["0","10k","20k","30k","40k","50k"]
    }
    func maxYValuesForY() -> CGFloat {
        return  100000
    }
    func baryValuesForLineChart() -> [CGFloat] {
        return [10000,20000,3000,0,1000,189,1000,19998,40000,30000,0,9000]
    }
    func bartitlesForXline() -> [String] {
        return ["xxx","xxx","xxx","xxx","xxx","xxx","xxx","xxx","xxx","xxx","xxx","10-12"]
    }
    func barmaxYValuesForY() -> CGFloat {
        40000
    }

}

