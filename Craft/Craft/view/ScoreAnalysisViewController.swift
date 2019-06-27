//
//  ScoreAnalysisViewController.swift
//  Craft
//
//  Created by Hitesh Ahuja on 18/05/19.
//  Copyright © 2019 Hitesh Ahuja. All rights reserved.
//

import UIKit
import ScoreAnalyser

class ScoreAnalysisViewController: UIViewController {

    @IBOutlet var scoreAnalysisView: ScorePlacement!
    
    var scoreAnalyser : ScoreAnalyser?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = "Score Analyser"
    
        if let score = scoreAnalyser?.score?.achievedscore {
             scoreAnalysisView.score = Int(score)
        }
       
        for (level, score) in ((scoreAnalyser?.levelScore?.enumerated())!) {
           
            //append score info
            scoreAnalysisView.scoreInfo.append(ScoreInfo(levelInfo: "\(Int(score.minScore!)) - \(Int(score.maxScore!))", percentage: "\(Int(score.percentage!))%"))
          
            //find level
            if (Int(score.minScore!) ... Int(score.maxScore!)).contains(Int((scoreAnalyser?.score?.achievedscore)!)){
               
                scoreAnalysisView.scoreLevel = ScoreLevelKey.allCases[level]
            }
            
        }
    }
    


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
