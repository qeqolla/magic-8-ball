//
//  ShakeController.swift
//  eigth-ball
//
//  Created by Andriy Kmit on 29.01.2022.
//

import SwiftUI
import Combine

let messagePublisher = PassthroughSubject<Void, Never>()

class ShakableViewController: UIViewController {
    override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        guard motion == .motionShake else { return }
        messagePublisher.send()
    }
}

struct ShakableViewRepresentable: UIViewControllerRepresentable {
    
    func makeUIViewController(context: Context) -> ShakableViewController {
        ShakableViewController()
    }
    func updateUIViewController(_ uiViewController: ShakableViewController, context: Context) {
        
    }
}
