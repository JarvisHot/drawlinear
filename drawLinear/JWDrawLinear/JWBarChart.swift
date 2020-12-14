//
//  JWBarChart.swift
//  drawLinear
//
//  Created by jiang on 2020/12/2.
//

import UIKit
@objc protocol JWBarChartDelegate {
    func baryValuesForLineChart() -> [CGFloat]
    @objc optional func bartitlesForXline() -> [String]
    func barmaxYValuesForY() -> CGFloat
}

class JWBarChart: UIView {

    var delegate:JWBarChartDelegate? {
        didSet {
            self.xView.bardelegate = delegate
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        initSubviews()
    }
    
    func initSubviews() {
        self.addSubview(self.scrollView)
        self.scrollView.addSubview(self.xView)
        
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        self.loadScrollViewContent()
    }
    private func loadScrollViewContent() {
        scrollView.subviews.forEach { (vi) in
            vi.removeFromSuperview()
        }
        if let arr = delegate?.baryValuesForLineChart() {
            self.scrollView.contentSize = CGSize(width: CGFloat(58) * CGFloat(arr.count) - CGFloat(21), height: 0.0)
            self.xView.frame = CGRect(x: 0, y: self.scrollView.frame.height - 40, width: self.scrollView.contentSize.width, height: 40)
            self.scrollView.addSubview(self.xView)
            let maxv = delegate!.barmaxYValuesForY()
            for i in 0 ..< arr.count {
                let bar = JWBarChartDetail(frame: CGRect(x: 21 + i*(58), y: 20, width: 16, height: Int(self.scrollView.frame.height) - 60))
                bar.tag = 10 + i
                bar.barcolor = UIColor.green
                scrollView.addSubview(bar)
               let label = UILabel()
                label.font = UIFont.systemFont(ofSize: 8)
                label.textAlignment = .center
                label.textColor = UIColor.green
                let money = "¥\(arr[i])" as NSString
                label.text = money as String
                let size = money.boundingRect(with: CGSize(width: 300, height: 10), options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font:UIFont.systemFont(ofSize: 8)], context: nil)
                let barheight = CGFloat(1 - arr[i]/maxv)*bar.frame.height
                label.frame = CGRect(x: 0, y: barheight + 5 , width: size.width, height: size.height)
                label.center.x = bar.center.x
                scrollView.addSubview(label)
                
            }
            
        }
        
    }
    func reloaData() {
        self.setNeedsDisplay()
        self.layoutIfNeeded()
        self.xView.refresh()
        if let arr = delegate?.baryValuesForLineChart() {
            let maxv = delegate!.barmaxYValuesForY()
            for i in 0 ..< arr.count {
                let va = arr[i]
                if let bar = scrollView.viewWithTag(i + 10) as? JWBarChartDetail {
                    bar.percent = va/maxv
                    bar.money = va
                    bar.refresh()
                }
                
            }
        }
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var xView:JWXView = {
        let x = JWXView()
        x.linColor = UIColor.green
        return x
    }()
    lazy var scrollView:UIScrollView = {
        let sc = UIScrollView()
        sc.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height - 15)
        sc.showsHorizontalScrollIndicator = false
        sc.layer.masksToBounds = false
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
