//
//  ScoreAnalyserInteractor.swift
//  Craft
//
//  Created by Hitesh Ahuja on 18/05/19.
//  Copyright © 2019 Hitesh Ahuja. All rights reserved.
//

import Foundation

protocol ScoreAnalyserBusinessLogic {
    func getScoreDetails()
}

class ScoreAnalyserInteractor: ScoreAnalyserBusinessLogic {
   
    // This variable is to pass the data of the api response to the presenter class.
    var presenter: ScoreAnalyserPresentationLogic?
    
    func getScoreDetails(){
        if let path = Bundle.main.path(forResource: "Score", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                self.presenter?.presentScoreDetails(data: data)
            } catch {
                // handle error
            }
        }
    }

}
