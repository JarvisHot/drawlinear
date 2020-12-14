//
//  JWYView.swift
//  drawLinear
//
//  Created by jiang on 2020/12/2.
//

import UIKit

class JWYView: UIView {

    var defaultSpace:CGFloat = 30
    var linColor:UIColor?
    var fontSize:CGFloat = 12
    var yElements:[String] = []
    var textColor:UIColor?
    var delegate:JWLineChartDelegate?
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func reloadYviews() {
        self.subviews.forEach { (v) in
            v.removeFromSuperview()
        }
        yElements.removeAll()
        
        if let arr = delegate?.titlesForYLine?() {
            yElements = arr
//            let maxY = delegate!.maxYValuesForY()
            let itemWidth = CGFloat(40)
            for i in 0 ..< yElements.count  {
                let item = yElements[i]
                let label = UILabel()
                label.textColor = textColor
                label.text = item
                label.font = UIFont.systemFont(ofSize: fontSize)
                label.frame = CGRect(x: 0, y: self.frame.size.height - 6 - defaultSpace*CGFloat(i), width: itemWidth, height: 12)
                self.addSubview(label)
            }
        }
        
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        self.reloadYviews()
    }
    func refresh() {
        self.setNeedsLayout()
        self.layoutIfNeeded()
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
