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

struct TennisGame {

    typealias Scores = (A: Score, B: Score)
    typealias Advantage = (A: Bool, B: Bool)

    var scores: Scores = (.Love, .Love)
    var advantage: Advantage = (false, false)

    mutating func playerScored(player: Player) {
        switch scores {
        case (.Forty, .Forty):
            if player == .A {
                if advantage.A {
                    advantage = (false, false)
                    ++scores.A
                } else if advantage.B {
                    advantage = (false, false)
                } else {
                    advantage = (true, false)
                }
            } else {
                if advantage.B {
                    advantage = (false, false)
                    ++scores.B
                } else if advantage.A {
                    advantage = (false, false)
                } else {
                    advantage = (false, true)
                }
            }
            return
        case (.Win, _), (_, .Win):
            return
        case (_, _):
            break
        }

        switch player {
        case .A:
            ++scores.A
        case .B:
            ++scores.B
        }
    }

    mutating func playerScored(players: [Player]) {
        for player in players {
            playerScored(player)
        }
    }

    func showScore() -> String {
        switch scores {
        case (.Forty, .Forty):
            switch advantage {
            case (true, _): return "A advantage"
            case (_, true): return "B advantage"
            case (_, _): return "Deuce"
            }
        case (.Win, _):
            return "A wins!"
        case (_, .Win):
            return "B wins!"
        case (_, _):
            return scores.A.description + " " + scores.B.description
        }
    }
}