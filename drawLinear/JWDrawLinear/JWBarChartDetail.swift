//
//  JWBarChartDetail.swift
//  drawLinear
//
//  Created by jiang on 2020/12/2.
//

import UIKit

class JWBarChartDetail: UIView {

    var barcolor:UIColor?
    var percent:CGFloat?
    var money:CGFloat = 0
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        if percent != nil {
            self.layer.sublayers?.forEach({ (la) in
                la.removeFromSuperlayer()
            })
            let linepath = UIBezierPath()
            let  y = (1 - percent!)*(self.frame.height)

            
            linepath.move(to: CGPoint(x: self.frame.width/2, y: self.frame.height))
            linepath.addLine(to: CGPoint(x: self.frame.width/2, y:y  ) )
            linepath.lineWidth = 10
            linepath.lineCapStyle = .square
            let la = CAShapeLayer()
            la.fillColor = barcolor?.cgColor
            la.frame = self.bounds
            la.strokeColor = barcolor?.cgColor
            la.lineWidth = self.frame.width
            la.path = linepath.cgPath
            let animation = CABasicAnimation(keyPath: "strokeEnd")
            animation.fromValue = 0
            animation.toValue = 1
            animation.duration = 1
            la.add(animation, forKey: "sss")
            self.layer.addSublayer(la)
            
            self.layer.masksToBounds = false
        }
    }
    func refresh() {
        self.setNeedsDisplay()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
