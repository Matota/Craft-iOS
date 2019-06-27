//
//  ScorePlacement.swift
//  Craft
//
//  Created by Hitesh Ahuja on 17/05/19.
//  Copyright © 2019 Hitesh Ahuja. All rights reserved.
//

import UIKit
import Foundation

@IBDesignable public class ScorePlacement: UIView {
    
    @IBOutlet var firstPlaceScoreView: UIView!
    @IBOutlet var firstPlaceScoreLimitLabel: UILabel!
    @IBOutlet var firstPlaceArrowView: UIView!
    @IBOutlet var firstPlacePercentageLabel: UILabel!
    @IBOutlet var firstPlaceScoreLabel: UILabel!
    
    @IBOutlet var secondPlaceScoreView: UIView!
    @IBOutlet var secondPlaceScoreLimitLabel: UILabel!
    @IBOutlet var secondPlaceArrowView: UIView!
    @IBOutlet var secondPlacePercentageLabel: UILabel!
    @IBOutlet var secondPlaceScoreLabel: UILabel!
    
    @IBOutlet var thirdPlaceScoreView: UIView!
    @IBOutlet var thirdPlaceScoreLimitLabel: UILabel!
    @IBOutlet var thirdPlaceArrowView: UIView!
    @IBOutlet var thirdPlacePercentageLabel: UILabel!
    @IBOutlet var thirdPlaceScoreLabel: UILabel!
    
    @IBOutlet var fourthPlaceScoreView: UIView!
    @IBOutlet var fourthPlaceScoreLimitLabel: UILabel!
    @IBOutlet var fourthPlaceArrowView: UIView!
    @IBOutlet var fourthPlacePercentageLabel: UILabel!
    @IBOutlet var fourthPlaceScoreLabel: UILabel!
    
    @IBOutlet var fifthPlaceScoreView: UIView!
    @IBOutlet var fifthPlaceScoreLimitLabel: UILabel!
    @IBOutlet var fifthPlaceArrowView: UIView!
    @IBOutlet var fifthPlacePercentageLabel: UILabel!
    @IBOutlet var fifthPlaceScoreLabel: UILabel!
    
    public var score = 0
    public var scoreInfo = [ScoreInfo]()
    public var scoreLevel = ScoreLevelKey.level1
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        guard let view = loadViewFromNib() else { return }
        view.frame = bounds
        addSubview(view)
    }
    
    private func loadViewFromNib() -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "ScorePlacement", bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        
        updateUI(level: scoreLevel)
        
    }
    
    private func updateUI(level: ScoreLevelKey){
    
        firstPlaceArrowView.isHidden = true
        secondPlaceArrowView.isHidden = true
        thirdPlaceArrowView.isHidden = true
        fourthPlaceArrowView.isHidden = true
        fifthPlaceArrowView.isHidden = true
        firstPlaceScoreLabel.isHidden = true
        secondPlaceScoreLabel.isHidden = true
        thirdPlaceScoreLabel.isHidden = true
        fourthPlaceScoreLabel.isHidden = true
        firstPlaceScoreLabel.isHidden = true
        firstPlaceArrowView.dropShadow()
        secondPlaceArrowView.dropShadow()
        thirdPlaceArrowView.dropShadow()
        fourthPlaceArrowView.dropShadow()
        fifthPlaceArrowView.dropShadow()
        
        firstPlaceScoreLimitLabel.text = scoreInfo[0].levelInfo
        firstPlacePercentageLabel.text = scoreInfo[0].percentage
        
        secondPlaceScoreLimitLabel.text = scoreInfo[1].levelInfo
        secondPlacePercentageLabel.text = scoreInfo[1].percentage
        
        thirdPlaceScoreLimitLabel.text = scoreInfo[2].levelInfo
        thirdPlacePercentageLabel.text = scoreInfo[2].percentage
        
        fourthPlaceScoreLimitLabel.text = scoreInfo[3].levelInfo
        fourthPlacePercentageLabel.text = scoreInfo[3].percentage
        
        fifthPlaceScoreLimitLabel.text = scoreInfo[4].levelInfo
        fifthPlacePercentageLabel.text = scoreInfo[4].percentage
        
        
        
        switch level {
        case .level1:
            firstPlaceArrowView.isHidden = false
            firstPlaceScoreLabel.isHidden = false
            firstPlaceScoreLabel.text = String(score)
            
        case .level2:
            secondPlaceArrowView.isHidden = false
            secondPlaceScoreLabel.isHidden = false
            secondPlaceScoreLabel.text = String(score)
        case .level3:
            thirdPlaceArrowView.isHidden = false
            thirdPlaceScoreLabel.isHidden = false
            thirdPlaceScoreLabel.text = String(score)
        case .level4:
            fourthPlaceArrowView.isHidden = false
            fourthPlaceScoreLabel.isHidden = false
            fourthPlaceScoreLabel.text = String(score)
        case .level5:
            fifthPlaceArrowView.isHidden = false
            fifthPlaceScoreLabel.isHidden = false
            fifthPlaceScoreLabel.text = String(score)
        }
        
        layoutIfNeeded()
    }

}

extension UIView {
    
    func dropShadow() {
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize(width: 15, height: 15)
        self.layer.shadowRadius = 1
        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
        
    }
}
