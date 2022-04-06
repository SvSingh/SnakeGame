//
//  ContentView.swift
//  Snake
//
//  Created by SV Singh on 2022-03-22.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var Logic = logic()

    @State var Direction = "Right"
    
    @State var end = false
    
    func drawSnake(){
        
        var speed = (Double(1)/Double(Logic.speed))
        
        if(Logic.speed > 6){
            speed = speed*Double(2)
        }
        
        Logic.direction(Direction: Direction)
        Timer.scheduledTimer(withTimeInterval: speed, repeats: false) { timer in
            if(Logic.killed){
                end = true
            }
            else {
                drawSnake()
            }
            
        }
        
    }
    
    var body: some View {
        VStack {
            
            HStack {
                Text("Score : \(Logic.Score)")
                Spacer()
                Text("Speed : \(Logic.speed/3)")
            }
            .padding(.horizontal)
            
            Canvas { Context, size in
                
                
                for Snake in Logic.snake{
                    
                    Context.fill(Path(CGRect(x: Snake.x, y: Snake.y, width: Snake.width, height: Snake.height)), with: .color(Snake.color))
                        
                }
                
                Context.fill(Path(CGRect(x: Logic.Food.x, y: Logic.Food.y, width: Logic.Food.width, height: Logic.Food.height)), with: .color(Logic.Food.color))
                
                                    
            }.frame(width: 340,height : 600)
                .border(.red)
        }.onAppear(){
            
            drawSnake()
        }
        
        
        HStack {
            Button(action: {
                if(self.Direction == "Right"){
                     self.Direction = "UP"
                }
                else if(self.Direction == "UP"){
                    self.Direction = "Left"
                }
                else if(self.Direction == "Left"){
                    self.Direction = "Down"
                   }
                else if(self.Direction == "Down"){
                    self.Direction = "Right"
                  }
                
                
            }, label: {
                Image(systemName: "arrowtriangle.left.fill")
                    .foregroundColor(.white)
                    .padding()
                    .background(.red)
            })
            
            Spacer()
            
            Button(action: {
                
                if(self.Direction == "Right"){
                    self.Direction = "Down"
                  }
                else if(self.Direction == "UP"){
                    self.Direction = "Right"
                }
                else if(self.Direction == "Left"){
                    self.Direction = "UP"
                }
                else if(self.Direction == "Down"){
                    self.Direction = "Left"
                }
                
            }, label: {
                Image(systemName: "arrowtriangle.right.fill")
                    .foregroundColor(.white)
                    .padding()
                    .background(.red)
            })
            .alert("Snake Died", isPresented: $end) {
                        Button("Play Again") {
                            
                            Logic.restart()
                             drawSnake()
                        
                        }
                        Button("Cancel") {
                            DispatchQueue.main.asyncAfter(deadline: .now()) {
                                
                                Logic.restart()
                                drawSnake()
                                
                                UIApplication.shared.perform(#selector(NSXPCConnection.suspend))
                                          }
                            
                        }
                    }
        }.padding(.horizontal)
            
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
