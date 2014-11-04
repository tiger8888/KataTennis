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
    case Love = 0
    case Fifteen = 1
    case Thirty = 2
    case Forty = 3
    case Win = 4

    var description: String {
        get {
            switch self {
            case .Love: return "Love"
            case .Fifteen: return "Fifteen"
            case .Thirty: return "Thirty"
            case .Forty: return "Forty"
            case .Win: return "Win"
            }
        }
    }

    func advance() -> Score {
        if self == .Win {
            return .Win
        } else {
            return Score(rawValue: self.rawValue + 1)!
        }
    }
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
                    scores.A = scores.A.advance()
                } else if advantage.B {
                    advantage = (false, false)
                } else {
                    advantage = (true, false)
                }
            } else {
                if advantage.B {
                    advantage = (false, false)
                    scores.B = scores.B.advance()
                } else if advantage.A {
                    advantage = (false, false)
                } else {
                    advantage = (false, true)
                }
            }
            return
        case (_, _):
            break
        }

        switch player {
        case .A:
            scores.A = scores.A.advance()
        case .B:
            scores.B = scores.B.advance()
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