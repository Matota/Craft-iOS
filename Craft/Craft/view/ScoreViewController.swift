//
//  ViewController.swift
//  Craft
//
//  Created by Hitesh Ahuja on 17/05/19.
//  Copyright © 2019 Hitesh Ahuja. All rights reserved.
//

import UIKit
import ScoreAnalyser

class ScoreViewController: UIViewController {

    @IBOutlet var scoreView: CircularProgressView!
    @IBOutlet var scoreDate: UILabel!
    
    private var interactor: ScoreAnalyserBusinessLogic?
    private var scoreAnalyser : ScoreAnalyser?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        title = "Score"
        setup()
        interactor?.getScoreDetails()
    }

    /// This function will setup all the necessary protocols required for the view controllers.
    private func setup() {
        let viewController = self
        let interactor = ScoreAnalyserInteractor()
        let presenter = ScoreAnalyserPresenter()
        viewController.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = viewController
    }
    

     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
         if segue.identifier! == "ScoreAnalysisViewController"{
            let scoreAnalysisVC = (segue.destination as! ScoreAnalysisViewController)
            if let scoreAnalyser = scoreAnalyser{
                 scoreAnalysisVC.scoreAnalyser = scoreAnalyser
            }
        }
        
     }

    

}

extension ScoreViewController : ScoreAnalyserPresenterToViewProtocol{
    func displayScoreDetails(scoreAnalyser: ScoreAnalyser) {
        
        self.scoreAnalyser = scoreAnalyser
        
        if let score = scoreAnalyser.score{
            if let minScore = score.minScore{
                scoreView.minimumScore = minScore
            }
            if let maxScore = score.maxScore{
                scoreView.maximumScore = maxScore
            }
            if let achievedScore = score.achievedscore{
                scoreView.achievedScore = achievedScore
            }
            if let date = score.date{
                scoreDate.text = "As of " + date
            }
            
            scoreView.setNeedsDisplay()
        }
    }
    
    
}
