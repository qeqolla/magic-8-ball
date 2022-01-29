//
//  EightBallGame.swift
//  eigth-ball
//
//  Created by Andriy Kmit on 28.01.2022.
//

import Foundation
import SystemConfiguration

class EightBallGame: ObservableObject {
    
    static func createModel() -> EightBall {
        return EightBall(setAnswer: "", answersByDefault: ["Yes", "No", "Probably"])
    }
    
    @Published private var model: EightBall = createModel()
    
    var answer: String {
        model.answer
    }
    
    var defaultAnswers: Array<EightBall.DefaultAnswer> {
        model.answersByDefault
    }
    
    func addDefaultAnswer(_ answer: String) {
        model.addDefaultAnswer(answer)
    }
    
    
    func fetchAnswer() async {
        var flags = SCNetworkReachabilityFlags()
        SCNetworkReachabilityGetFlags(Network().reachability!, &flags)
        
        if Network().isNetworkReachable(with: flags) {
            if let magicAnswer = try? await Network().getAnswer()  {
                model.setAnswer = magicAnswer
            } else {
                if let randomAnswer = model.getRandomAnswer() {
                    model.setAnswer = randomAnswer
                }
            }
        } else {
            if let randomAnswer = model.getRandomAnswer() {
                model.setAnswer = randomAnswer
            }
        }
    }
}
