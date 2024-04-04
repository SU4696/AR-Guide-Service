//
//  ContentView.swift
//  AR Guide Service
//
//  Created by Suyeon Cho on 25/03/24.
//

import SwiftUI

struct ContentView: View {
    @State private var color: [Color] = [.green, .red, .blue]
    @State var eyeGazeActive: Bool = false
    @State var lookAtPoint: CGPoint?
    @State var isWinking: Bool = false
    
    
    var body: some View {
        NavigationStack{
            ZStack{
                Color.iconblue.ignoresSafeArea()
                VStack (spacing: 30){
                    Image(.eye)
                        .resizable()
                        .frame(width:100, height: 100)
//                        .border(.white)
                    NavigationLink{
                        CustomARViewRepresentable()
                            .ignoresSafeArea()
                            .overlay(alignment: .bottom){
                                ScrollView(.horizontal){
                                    HStack{
                                        Button{
                                            ARManager.shared.actionStream.send(.removeAllAnchors)
                                        }label: {
                                            Image(systemName: "trash")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 40, height: 40)
                                                .padding()
                                                .background(.regularMaterial)
                                                .cornerRadius(16)
                                        }
                                        
                                        ForEach(color, id: \.self) { color in
                                            Button{
                                                ARManager.shared.actionStream.send(.placeBlock(color: color))
                                            }label: {
                                                color
                                                    .frame(width: 40, height: 40)
                                                    .padding()
                                                
                                            }
                                            
                                        }
                                        
                                    }
                                }
                            }
                    }label: {
                        Text( "Add Box")
                            .padding()
                    }
                    .foregroundColor(.iconblue)
                    .frame(maxWidth: .infinity)
                    .background(.white)
                    .clipShape(Capsule())
                    NavigationLink{
                        ZStack(alignment: .bottom) {
                                                    CustomARViewETContainer(eyeGazeActive: $eyeGazeActive, lookAtPoint: $lookAtPoint, isWinking: $isWinking)
                                                        .ignoresSafeArea()
                            Button(action: {
                                eyeGazeActive.toggle()
                            }, label: {
                                Text(eyeGazeActive ? "Stop" : "Start")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .padding()
                                
                            })
                            
                            .padding(.bottom, 50)
                            
                            if let lookAtPoint = lookAtPoint {
                                Circle()
                                    .fill(Color.pink)
                                    .frame(width: isWinking ? 100 : 40, height: isWinking ? 100 : 40)
                                    .position(lookAtPoint)
                            }
                        }
                    }label: {
                        
                        Text( "Eye Tracking View")
                            .padding()
                    }
                    .foregroundColor(.iconblue)
                    .frame(maxWidth: .infinity)
                    .background(.white)
                    .clipShape(Capsule())
                    
                }  .fixedSize(horizontal: true, vertical: false)
            }
        }
    }
}

#Preview {
    ContentView()
}
