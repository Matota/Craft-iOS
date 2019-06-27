//
//  CraftManager.swift
//  Craft
//
//  Created by Hitesh Ahuja on 18/05/19.
//  Copyright © 2019 Hitesh Ahuja. All rights reserved.
//

import UIKit

public enum ScoreLevelKey: CaseIterable {
   
    case level1
    case level2
    case level3
    case level4
    case level5
    

    func getColor() -> UIColor {
        switch self {
        case .level1:
            return .green
        case .level2:
            return .yellow
        case .level3:
            return .orange
        case .level4:
            return .red
        case .level5:
            return .purple
        }
    }

}


public struct ScoreInfo {
    public init(levelInfo :String, percentage: String) {
        self.levelInfo = levelInfo
        self.percentage = percentage
    }
    public var levelInfo: String = ""
    public var percentage: String = ""
}
