//
//  Score.swift
//  Craft
//
//  Created by Hitesh Ahuja on 18/05/19.
//  Copyright © 2019 Hitesh Ahuja. All rights reserved.
//

import Foundation

struct ScoreAnalyser: Codable {
    let score: Score?
    let levelScore: [LevelScore]?
}

struct LevelScore: Codable {
    let minScore, maxScore, percentage: Float?
}

struct Score: Codable {
    let minScore, maxScore, achievedscore: Float?
    let date: String?
    
    enum CodingKeys: String, CodingKey {
        case minScore, maxScore
        case achievedscore = "Achievedscore"
        case date
    }
}

// MARK: Convenience initializers and mutators

extension ScoreAnalyser {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(ScoreAnalyser.self, from: data)
    }
    
    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }
}


fileprivate func newJSONDecoder() -> JSONDecoder {
    let decoder = JSONDecoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        decoder.dateDecodingStrategy = .iso8601
    }
    return decoder
}

