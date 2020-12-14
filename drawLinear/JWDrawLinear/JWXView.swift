//
//  JWXView.swift
//  drawLinear
//
//  Created by jiang on 2020/12/2.
//

import UIKit

class JWXView: UIView {

    var defaultSpace:CGFloat = 40
    var linColor:UIColor?
    var fontSize:CGFloat = 12
    var xElements:[String] = []
    var textColor:UIColor?
    var delegate:JWLineChartDelegate?
    var bardelegate:JWBarChartDelegate?
    var isbar = false
    override init(frame: CGRect) {
        super.init(frame: frame)
        initSubviews()
    }
    func initSubviews() {
        
    }
    func reloadXviews() {
        self.subviews.forEach { (v) in
            v.removeFromSuperview()
        }
        xElements.removeAll()
        self.xLineView.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: 1)
        self.addSubview(xLineView)
        if let arr = delegate?.titlesForXline?() {
            xElements = arr
        }else if let tarr = bardelegate?.bartitlesForXline?() {
            xElements = tarr
            isbar = true
        }
        var itemWidth = defaultSpace
        if isbar {
            itemWidth = 58
        }
        for i in 0 ..< xElements.count  {
            let item = xElements[i]
            let label = UILabel()
            label.textColor = textColor
            label.text = item
            label.font = UIFont.systemFont(ofSize: fontSize)
            label.textAlignment = .center
            label.frame = CGRect(x: CGFloat(i)*(itemWidth), y: 1, width: itemWidth, height: 30)
            self.addSubview(label)
        }
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        self.reloadXviews()
    }
    func refresh() {
        self.setNeedsLayout()
        self.layoutIfNeeded()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    lazy var xLineView:UIView = {
        let v = UIView()
        v.backgroundColor = linColor
        return v
    }()
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
