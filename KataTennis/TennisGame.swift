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

enum TennisGame: Printable {
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

infix operator <<< { associativity left precedence 140 }
func <<< (result: TennisGame, player: Player) -> TennisGame {
    switch result {
    case .OnGoing(var aScore, var bScore):
        if player == .A {
            ++aScore
        } else {
            ++bScore
        }

        if aScore == .Win {
            return .AWin
        } else if bScore == .Win {
            return .BWin
        } else if aScore == .Forty && bScore == .Forty {
            return .Deuce
        } else {
            return .OnGoing(aScore, bScore)
        }
    case .Deuce:
        return player == .A ? .AAdvantage : .BAdvantage
    case .AAdvantage:
        return player == .A ? .AWin : .Deuce
    case .BAdvantage:
        return player == .A ? .Deuce : .BWin
    case .AWin, .BWin:
        return result
    }
}
