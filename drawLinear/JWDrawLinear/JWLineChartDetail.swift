//
//  JWLineChartDetail.swift
//  drawLinear
//
//  Created by jiang on 2020/12/2.
//

import UIKit

class JWLineChartDetail: UIView {

    var lineColor:UIColor?
    var lineType:lineChartType = .straightLine
    var delegate:JWLineChartDelegate?
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.drawlines()
    }
    func refresh() {
        self.setNeedsDisplay()
    }
    private func drawlines() {
        self.layer.sublayers?.forEach({ (la) in
            la.removeFromSuperlayer()
        })
        if let points = delegate?.yValuesForLineChart() {
            let maxy = delegate!.maxYValuesForY()
            let bezierPath = UIBezierPath()
            let linePath = UIBezierPath()
            linePath.lineCapStyle   = .round
            linePath.lineJoinStyle  = .miter
            linePath.miterLimit = 0.1
            linePath.flatness = 2
            for i in 0 ..< points.count {
                let y = CGFloat(1 - points[i]/maxy)*self.frame.height
                if i == 0 {
                    bezierPath.move(to: CGPoint(x: 0, y: y))
                    linePath.move(to: CGPoint(x: 0, y: y))
                }else {
                    if lineType == .straightLine {
                        bezierPath.addLine(to: CGPoint(x:  CGFloat(i)*40.0, y: y))
                        linePath.addLine(to: CGPoint(x:  CGFloat(i)*40.0 , y: y ))
                    }else {
                        
                        let prepoint = CGPoint(x: CGFloat(i-1)*40.0, y: CGFloat(1 - points[i-1]/maxy)*self.frame.height)
                        let nowpoint = CGPoint(x:  CGFloat(i)*40.0, y: y)
                        bezierPath.addCurve(to:nowpoint, controlPoint1: CGPoint(x: (nowpoint.x + prepoint.x)/2, y: prepoint.y), controlPoint2: CGPoint(x: (nowpoint.x + prepoint.x)/2, y: nowpoint.y))
                        linePath.addCurve(to:nowpoint, controlPoint1: CGPoint(x: (nowpoint.x + prepoint.x)/2, y: prepoint.y), controlPoint2: CGPoint(x: (nowpoint.x + prepoint.x)/2, y: nowpoint.y))
                    }
                    
                    
                    if i == points.count - 1 {
                        bezierPath.addLine(to: CGPoint(x: CGFloat(i)*40.0, y: self.frame.height))
                        bezierPath.addLine(to: CGPoint(x: 0, y: self.frame.height))
                        
                    }
                }
               
            }

            bezierPath.close()
            let animation = CABasicAnimation(keyPath: "strokeEnd")
            animation.fromValue = 0
            animation.toValue = 1
            animation.duration = 1
            self.lineLayer.add(animation, forKey: "strokeEnd")
            self.lineLayer.path = linePath.cgPath
            self.layer.addSublayer(self.lineLayer)
            
            let frame = self.gradientLayer.frame
            let animation1 = CABasicAnimation(keyPath: "bounds")
            
            animation1.fromValue = NSValue(cgRect: CGRect(x: 0, y: 0, width: 0, height: frame.height))
            
            animation1.toValue = NSValue(cgRect: CGRect(x: 0, y: 0, width: frame.width, height: frame.height))
            
            self.shapLayer.path = bezierPath.cgPath
            let anchorpointAni = CABasicAnimation(keyPath: "anchorPoint")
            anchorpointAni.fromValue = CGPoint(x: 0.5, y: 0)
            anchorpointAni.toValue = CGPoint(x: 0.5, y: 0.5)
            let anim = CABasicAnimation(keyPath: "position")
            anim.fromValue = CGPoint(x: 0, y: 0)
            anim.toValue = CGPoint(x: frame.width/2, y: frame.height/2)
            let animgroup = CAAnimationGroup()
            animgroup.animations = [animation1,anchorpointAni,anim]
            animgroup.duration = 1
            animgroup.fillMode = .forwards
            self.layer.addSublayer(self.shapLayer)
            
            self.layer.addSublayer(self.gradientLayer)
            self.gradientLayer.add(animgroup, forKey: "move")
            self.gradientLayer.mask = shapLayer
            
            
        }
        
        
    }
    lazy var lineLayer:CAShapeLayer = {
        let la =  CAShapeLayer()
        la.fillColor = UIColor.white.cgColor
        la.strokeColor = lineColor?.cgColor
        la.lineWidth = 2
        la.masksToBounds = true
        la.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height + 10)
        return la
    }()
    lazy var shapLayer:CAShapeLayer = {
        let la =  CAShapeLayer()
        la.frame = self.bounds
//        la.fillColor = UIColor.white.cgColor
//        la.strokeColor = lineColor?.cgColor
//        la.lineWidth = 0
        return la
        
    }()
    lazy var gradientLayer:CAGradientLayer = {
        let gra = CAGradientLayer()
        gra.backgroundColor = UIColor.white.cgColor
        gra.frame = self.bounds
        gra.masksToBounds = true
        gra.colors = [UIColor(red: 237/255.0, green: 243/255.0, blue: 1, alpha: 1).cgColor,UIColor(red: 237/255.0, green: 243/255.0, blue: 1, alpha: 1).cgColor]
        gra.startPoint = CGPoint(x: 0, y: 0)
        gra.endPoint = CGPoint(x: 0, y: 1)
        
        self.layer.addSublayer(gra)
        return gra
    }()
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
