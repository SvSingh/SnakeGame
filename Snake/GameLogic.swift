//
//  GameLogic.swift
//  Snake
//
//  Created by SV Singh on 2022-03-22.
//

import Foundation
import SwiftUI


struct SnakePiece : Identifiable {
    
    var id = UUID()
    var x : Int
    var y : Int
    var width : Int
    var height : Int
    var color : Color
    
}



class logic : ObservableObject {
    
    func restart() {
        
    snake = [SnakePiece(x:20,y:0,width: 17,height: 17, color: .yellow)]
    
    Food = SnakePiece(x:(Int.random(in: 1..<17)*20),y:(Int.random(in: 1..<30)*20),width: 17,height: 17, color: .red)
    
    speed = 3
    
    Score = 5
    
    killed = false
        
        
    }
    
    
    @Published  var snake: [SnakePiece] = [SnakePiece(x:20,y:0,width: 17,height: 17, color: .yellow)]
    
    @Published var Food = SnakePiece(x:(Int.random(in: 1..<17)*20),y:(Int.random(in: 1..<30)*20),width: 17,height: 17, color: .red)
    
    @Published var speed = 3
    
    @Published var Score = 5
    
    @Published var killed = false
    
    func makeFood(){
        
        
        Food.x = (Int.random(in: 1..<17)*20)
        Food.y = (Int.random(in: 1..<30)*20)
        
        for i in 0..<snake.count {
            if(Food.x == snake[i].x && Food.y == snake[i].y){
                makeFood()
            }
        }
        
        levelUp()
        
        
    }
    

   
    func direction (Direction : String){
        
        killMe()
        
         switch Direction {
            
            
        case "Right":
            
            
            if(snake[0].x == Food.x && snake[0].y == Food.y){
                self.snake.append(SnakePiece(x: (snake[snake.count - 1].x - 20), y: snake[snake.count - 1].y, width: snake[snake.count - 1].width, height: snake[snake.count - 1].height, color: .green))
                makeFood()
                
            }
            bigTail()
            snake[0].x += 20
            if(snake[0].x > 340){
                    snake[0].x = 0
                }
            
            
        case "Left":
            
            if(snake[0].x == Food.x && snake[0].y == Food.y){
                self.snake.append(SnakePiece(x: (snake[snake.count - 1].x + 20), y: snake[snake.count - 1].y, width: snake[snake.count - 1].width, height: snake[snake.count - 1].height, color: .green))
                makeFood()
                
            }
            bigTail()
            snake[0].x -= 20
            if(snake[0].x < 0){
                    snake[0].x = 340
                }
            
        case "UP":
            
            if(snake[0].x == Food.x && snake[0].y == Food.y){
                self.snake.append(SnakePiece(x: (snake[snake.count - 1].x), y: snake[snake.count - 1].y + 20, width: snake[snake.count - 1].width, height: snake[snake.count - 1].height, color: .green))
                makeFood()
                
            }
            bigTail()
            snake[0].y -= 20
            if(snake[0].y < 0){
                    snake[0].y = 600
                }
            
        
        default:
            
            if(snake[0].x == Food.x && snake[0].y == Food.y){
                self.snake.append(SnakePiece(x: (snake[snake.count - 1].x), y: snake[snake.count - 1].y - 20, width: snake[snake.count - 1].width, height: snake[snake.count - 1].height, color: .green))
                
                makeFood()
                
            }
            bigTail()
            snake[0].y += 20
            if(snake[0].y > 600){
                    snake[0].y = 0
                }
            
        }
        
        
        
    }
    
    func bigTail (){
        if(snake.count > 1) {
            for i in (1..<snake.count).reversed() {
                snake[i].x = snake[i-1].x
                snake[i].y = snake[i-1].y
                 
                
            }
        }
    }
    
    func levelUp(){
        speed += 3
        Score += 5
        
    }
    
    func killMe(){
        
         if snake.count > 1 {
            for i in (1..<snake.count - 1) {
                
                if(snake[i].x == snake[0].x && snake[i].y == snake[0].y){
                    killed = true
                }
                
            }
        }
        
        
    }
    
    
    
}
