//
//  EightBall.swift
//  eigth-ball
//
//  Created by Andriy Kmit on 28.01.2022.
//

import Foundation

struct EightBall {
    private(set) var answer: String = ""
    
    private(set) var answersByDefault: Array<DefaultAnswer> = Array<DefaultAnswer>()
    
    var setAnswer: String {
        didSet {
            answer = setAnswer
        }
    }
    
    mutating func addDefaultAnswer(_ answer: String) {
        answersByDefault.append(DefaultAnswer(answer: answer))
    }
    
    func getRandomAnswer() -> String? {
        if let answer = answersByDefault.randomElement()?.answer {
            return answer
        }
        
        return nil
    }
    
    init(setAnswer: String, answersByDefault: Array<String>) {
        self.setAnswer = setAnswer
        
        for answerByDefault in answersByDefault {
            self.answersByDefault.append(DefaultAnswer(answer: answerByDefault))
        }
    }
    
    struct DefaultAnswer: Identifiable {
        var id = UUID()
        var answer: String
        
    }
}


struct Answer: Codable {
    let magic: Magic
}

struct Magic: Codable {
    let question: String
    let answer: String
    let type: String
}
