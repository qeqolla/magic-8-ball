//
//  ContentView.swift
//  eigth-ball
//
//  Created by Andriy Kmit on 28.01.2022.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: EightBallGame
    @State public var showGameScreen: Bool = true
    
    var body: some View {
        VStack {
            HStack {
                if showGameScreen {
                    GameView(viewModel: viewModel)
                } else {
                    SettingsView(viewModel: viewModel)
                }
            }
            .padding(.vertical)
            HStack {
                Button {
                    withAnimation {
                        showGameScreen = true
                    }
                } label: {
                    VStack {
                        Image(systemName: "8.circle")
                        Text(" Game")
                        
                    }.font(.title)
                }
                
                Spacer()
                
                Button {
                    withAnimation {
                        showGameScreen = false
                    }
                } label: {
                    VStack {
                        Image(systemName: "gear.circle")
                        Text("Settings ")
                    }.font(.title)
                }
            }.font(.largeTitle)
                .transition(.move(edge: .leading))
        }
    }
    
}


struct GameView: View {
    @ObservedObject var viewModel: EightBallGame
    
    var body: some View {
        ZStack {
            ShakableViewRepresentable()
                .allowsHitTesting(false)
            VStack {
                ZStack {
                    Text("Ask a question and shake your phone!")
                        .padding(.bottom, 50)
                    Text(viewModel.answer)
                }
                
            }
            .padding(.horizontal)
            .onReceive(messagePublisher) {
                Task {
                    await viewModel.fetchAnswer()
                }
            }
        }
    }
    
}

struct HardcodedAnswerView: View {
    let text: String
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .leading) {
                Text(text)
            }
            .frame(width: geometry.size.width,
                   height: nil,
                   alignment: .center)
            .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: 1)
            
        }.padding(.bottom, 10)
        
    }
}

struct SettingsView: View {
    @ObservedObject var viewModel: EightBallGame
    @State var newAnswer: String = ""
    
    var body: some View {
        VStack {
            Text("Settings")
            Spacer()
            ScrollView {
                LazyVGrid(columns: [GridItem()]) {
                    ForEach(viewModel.defaultAnswers) { answer in
                        HardcodedAnswerView(text: answer.answer)
                        
                    }
                }
            }
            
            TextField("Enter new answer...", text: $newAnswer, onCommit: {
                viewModel.addDefaultAnswer(newAnswer)
                newAnswer = ""
            })
        }.padding(.horizontal)
    }
}



struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        let game = EightBallGame()
        
        ContentView(viewModel: game)
        SettingsView(viewModel: game)
        ContentView(viewModel: game)
            .preferredColorScheme(.dark)
    }
}


