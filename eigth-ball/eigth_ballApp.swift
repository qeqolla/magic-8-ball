//
//  eigth_ballApp.swift
//  eigth-ball
//
//  Created by Andriy Kmit on 28.01.2022.
//

import SwiftUI

@main
struct eigth_ballApp: App {
    let game = EightBallGame()
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: game)
        }
    }
}
