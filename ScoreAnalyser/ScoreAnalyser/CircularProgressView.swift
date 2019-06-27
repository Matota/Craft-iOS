//
//  CircularProgressView.swift
//  Craft
//
//  Created by Hitesh Ahuja on 17/05/19.
//  Copyright © 2019 Hitesh Ahuja. All rights reserved.
//

import UIKit

let π = CGFloat(Double.pi)

@IBDesignable public class CircularProgressView: UIView {
    
    @IBInspectable public var ringBackgroundColour: UIColor = .lightGray
    @IBInspectable public var ringForegroundColour: UIColor = .green
    @IBInspectable public var progressLabelColor: UIColor = .black
    @IBInspectable public var foreGroundArcWidth: CGFloat = 25
    @IBInspectable public var backGroundArcWidth: CGFloat = 25
    @IBInspectable public var animateProgress: Bool = false
    @IBInspectable public var displayProgressTextually: Bool = false
    
    public var minimumScore : Float = 0.0
    public var maximumScore : Float = 0.0
    public var achievedScore : Float = 0.0
    
    @IBInspectable public var selectedValue: UInt8 = 0 {
        didSet {
            let value = max(0, min(selectedValue, 100))
            animateScale = Float(value) / 100
            setNeedsDisplay()
        }
    }
    
    private var arcMargin: CGFloat = 0
    private var animateScale: Float = 0 // must be between [0,1]
    private var progressIndicatorLabel = UILabel()
    private var progressStartLabel = UILabel()
    private var progressEndLabel = UILabel()
    private var internalArcStartLocation = 20
    
    override public func draw(_ rect: CGRect) {
        backgroundArc()
        if animateProgress {
            animateArc(value: CGFloat(animateScale))
        }
    }
    

    private func centerAndRadius() -> (center: CGPoint, radius: CGFloat) {
        let center = CGPoint(x: bounds.width / 2, y: bounds.height / 2)
        let diameter = min(bounds.width - arcMargin, bounds.height - arcMargin)
        let radius = diameter / 2 - max(foreGroundArcWidth, backGroundArcWidth) / 2
        return (center, radius)
    }
    
    private func drawArc(startAngle: CGFloat, endAngle: CGFloat, lineWidth: CGFloat, ringColor: UIColor) {
        let centerNRadius = centerAndRadius()
        let center = centerNRadius.center
        let radius = centerNRadius.radius
        let path = UIBezierPath(arcCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        path.lineWidth = lineWidth
        ringColor.setStroke()
        path.stroke()
    }
    
    private func backgroundArc() {
        let startAngle: CGFloat = π / 2
        let endAngle: CGFloat =  2 * π
        drawArc(startAngle: startAngle, endAngle: endAngle, lineWidth: backGroundArcWidth, ringColor: ringBackgroundColour)
    }

    func getEndPointAngle() -> CGFloat{
       //complete angle 360 degrree
        if achievedScore <= minimumScore {
            return π / 2
        }
        if achievedScore >= maximumScore{
            return 2 * π
        }
        let totalPercentage = ((achievedScore - minimumScore) / (maximumScore - minimumScore))
        
        let completeAngle = 2 * π
        //inner circle drawn = 270 degee
        let grayCircle = (3 / 4) * completeAngle
        
        //outer circle end angle e.g 80 percent of 270 degree
        let greenEndAngle = grayCircle * CGFloat(totalPercentage)
        
        // additonal angle
        let additionalAngle = grayCircle - greenEndAngle
        let finalAngle = completeAngle - additionalAngle
        return finalAngle
    }
    
    private func animateArc(value: CGFloat) {
        let loaderValue = (value == 0) ? CGFloat(0.01) : value
        let centerNRadius = centerAndRadius()
        let center = centerNRadius.center
        let radius = centerNRadius.radius
        let startAngle = π / 2
        let endAngle = getEndPointAngle()
        let arcPath = UIBezierPath(arcCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        let ringLayer = CAShapeLayer()
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        
        animation.duration = 2
        animation.fromValue = 0
        animation.toValue = loaderValue // changed here
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        
        ringLayer.path = arcPath.cgPath
        ringLayer.strokeColor = ringForegroundColour.cgColor
        ringLayer.fillColor = UIColor.clear.cgColor
        ringLayer.lineWidth = foreGroundArcWidth
        ringLayer.strokeEnd = 0.0
        layer.addSublayer(ringLayer)
        
        ringLayer.strokeEnd = loaderValue
        ringLayer.add(animation, forKey: "animateArc")
        
        displayProgressText(forValue: loaderValue)
    }
    
    private func displayProgressText(forValue loaderValue: CGFloat) {
        progressIndicatorLabel.isHidden = !displayProgressTextually
        if !displayProgressTextually {
            return
        }
        progressIndicatorLabel.frame = CGRect(x: self.frame.size.width / 2 - 60, y: self.frame.size.height / 2 - 34, width: 120, height: 68)
        progressIndicatorLabel.textColor = .brown
        progressIndicatorLabel.textAlignment = .center
        progressIndicatorLabel.font = UIFont(name:"Futura-Bold",size:40)

        
        self.progressIndicatorLabel.text = achievedScore.shortValue
        self.addSubview(progressIndicatorLabel)
        
        let centerNRadius = centerAndRadius()
        let center = centerNRadius.center
        let radius = centerNRadius.radius
        
        progressStartLabel.frame = CGRect(x: center.x + 10, y: center.y + radius - 10, width: 35, height: 20)
        progressStartLabel.textColor = progressLabelColor
        progressStartLabel.textAlignment = .center
        self.progressStartLabel.text = String(minimumScore.shortValue)
        self.addSubview(progressStartLabel)
        
        progressEndLabel.frame = CGRect(x: center.x + radius - 15 , y: radius + 50, width: 35, height: 20)
        progressEndLabel.textColor = progressLabelColor
        progressEndLabel.textAlignment = .center
        self.progressEndLabel.text = String(maximumScore.shortValue)
        self.addSubview(progressEndLabel)
        
    }
}

extension Float {
    var shortValue: String {
        return String(format: "%g", self)
    }
}
