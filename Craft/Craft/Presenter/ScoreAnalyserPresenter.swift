//
//  ScoreAnalyserPresenter.swift
//  Craft
//
//  Created by Hitesh Ahuja on 18/05/19.
//  Copyright © 2019 Hitesh Ahuja. All rights reserved.
//


import Foundation

protocol ScoreAnalyserPresenterToViewProtocol: NSObjectProtocol {
    func displayScoreDetails(scoreAnalyser: ScoreAnalyser)
}


/// This protocol will be conform by the presenter and it will make sure it passes the data in the form of model classes to the viewcontrollers.
protocol ScoreAnalyserPresentationLogic {
     func presentScoreDetails(data: Data)
}

/// This class is just to support the protocol to convert api response to the model class and pass it along to the view controller
class ScoreAnalyserPresenter: ScoreAnalyserPresentationLogic {
    weak var viewController: ScoreAnalyserPresenterToViewProtocol?

    func presentScoreDetails(data: Data) {
        do {
             let scoreDetails = try ScoreAnalyser(data: data)
                viewController?.displayScoreDetails(scoreAnalyser: scoreDetails)
        } catch {
            print("Catch error when parsing score")
        }
    }
}

