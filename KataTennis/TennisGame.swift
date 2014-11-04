//
//  TennisGame.swift
//  KataTennis
//
//  Created by Guanshan Liu on 04/11/2014.
//  Copyright (c) 2014 guanshanliu. All rights reserved.
//

import Foundation

enum Player {
    case A
    case B
}

enum Score:Int, Printable {
    case Love, Fifteen, Thirty, Forty, Win

    var description: String {
        let names = ["Love", "Fifteen", "Thirty", "Forty", "Win"]
        return names[self.rawValue]
    }
}

extension Score {
    static var allCases: [Score] {
        return Array(
            SequenceOf {
                () -> GeneratorOf<Score> in
                var cur = 0
                return GeneratorOf<Score> {
                    return self(rawValue: cur++)
                }
            }
        )
    }
}

extension Score {
    static var maximumRawValue: Int {
        var max: Int = 0
        while let _ = self(rawValue: ++max) {}
        return max
    }

    static func randomCase() -> Score {
        let randomValue = Int(arc4random_uniform(UInt32(maximumRawValue)))
        return self(rawValue: randomValue)!
    }
}

prefix operator ++ { }
prefix func ++ (inout score: Score) -> Score {
    var value = score.rawValue
    if value < Score.maximumRawValue {
        ++value
    }
    score = Score(rawValue: value)!
    return score
}

enum GameResult: Printable {
    case OnGoing(Score, Score)
    case Deuce
    case AAdvantage
    case BAdvantage
    case AWin
    case BWin

    var description: String {
        switch self {
        case .OnGoing(let aScore, let bScore):
            return aScore.description + " " + bScore.description
        case .Deuce:
            return "Deuce"
        case .AAdvantage:
            return "A advantage"
        case .BAdvantage:
            return "B advantage"
        case .AWin:
            return "A wins!"
        case .BWin:
            return "B wins!"
        }
    }
}

struct TennisGame {

    var result: GameResult = .OnGoing(.Love, .Love)

    mutating func playerScored(player: Player) {
        switch result {
        case .OnGoing(var aScore, var bScore):
            if player == .A {
                ++aScore
            } else {
                ++bScore
            }

            if aScore == .Win {
                result = .AWin
            } else if bScore == .Win {
                result = .BWin
            } else if aScore == .Forty && bScore == .Forty {
                result = .Deuce
            } else {
                result = .OnGoing(aScore, bScore)
            }
        case .Deuce:
            result = player == .A ? .AAdvantage : .BAdvantage
        case .AAdvantage:
            result = player == .A ? .AWin : .Deuce
        case .BAdvantage:
            result = player == .A ? .Deuce : .BWin
        case .AWin, .BWin:
            return
        }
    }

    mutating func playerScored(players: [Player]) {
        for player in players {
            playerScored(player)
        }
    }

    func showScore() -> String {
        return result.description
    }
}