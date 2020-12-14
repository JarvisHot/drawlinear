//
//  JWLineChart.swift
//  drawLinear
//
//  Created by jiang on 2020/12/2.
//

import UIKit

enum lineChartType {
    case circleLine
    case straightLine
}
@objc protocol JWLineChartDelegate {
    func yValuesForLineChart() -> [CGFloat]
    @objc optional func titlesForXline() -> [String]
    @objc optional func titlesForYLine() -> [String]
    func maxYValuesForY() -> CGFloat
}
class JWLineChart: UIView {

    var lineType:lineChartType? {
        didSet {
            if lineType != nil {
                self.chartV.lineType = lineType!
            }
        }
    }
    var delegate:JWLineChartDelegate? {
        didSet {
            self.xView.delegate = delegate
            self.yView.delegate = delegate
            self.chartV.delegate = delegate
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initSubviews()
        self.yView.frame = CGRect(x: 0, y: 0, width: 40, height: self.frame.height - 40)
        
        
    }
    
    func initSubviews() {
        self.addSubview(self.scrollView)
        self.scrollView.addSubview(self.xView)
        self.addSubview(self.yView)
        self.scrollView.addSubview(self.chartV)
        
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        self.loadScrollViewContent()
    }
    private func loadScrollViewContent() {
        if let arr = delegate?.yValuesForLineChart() {
            self.scrollView.contentSize = CGSize(width: CGFloat(40.0) * CGFloat(arr.count), height: 0.0)
            self.xView.frame = CGRect(x: 0, y: self.scrollView.frame.height - 40, width: self.scrollView.contentSize.width, height: 40)
            self.chartV.frame = CGRect(x: 0, y: 0, width: self.scrollView.contentSize.width, height: self.scrollView.frame.height - 40)
        }
        
    }
    func reloaData() {
        self.setNeedsDisplay()
        self.layoutIfNeeded()
        self.xView.refresh()
        self.yView.refresh()
        self.chartV.refresh()
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    lazy var chartV:JWLineChartDetail = {
        let cha = JWLineChartDetail()
        cha.lineColor = UIColor.green
        return cha
    }()
    lazy var xView:JWXView = {
        let x = JWXView()
        return x
    }()
    lazy var yView:JWYView = {
        let y = JWYView()
        return y
    }()
    lazy var scrollView:UIScrollView = {
        let sc = UIScrollView()
        sc.frame = CGRect(x: 40, y: 0, width: self.frame.width - 40, height: self.frame.height)
        sc.showsHorizontalScrollIndicator = false
        return sc
    }()
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
