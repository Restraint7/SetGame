//
//  Card.swift
//  SetGame
//
//  Created by 凯琦牟 on 2018/8/7.
//  Copyright © 2018年 凯琦牟. All rights reserved.
//

import Foundation

struct Card {
    var numbers : Int
    var symbols : Int
    var shadings : Int
    var colors : Int
    var isMatched = false
    var selected = false
    var sequenceOnTheDesk = 0
    
    init(numbers:Int,symbols:Int,shadings:Int,colors:Int){
        self.numbers = numbers
        self.symbols = symbols
        self.shadings = shadings
        self.colors = colors
    }
}

let voidCard = Card(numbers: 4, symbols: 4, shadings: 4, colors: 4)

struct CardDeck{
    private(set) var cards = [Card]()
    
    init(){
        for number in 1...3 {
            for symbol in 1...3 {
                for shading in 1...3 {
                    for color in 1...3 {
                        cards.append(Card(numbers: number, symbols: symbol, shadings: shading, colors: color))
                    }
                }
            }
        }
    }
    
    mutating func giveOutOneCard() -> Card? {
        if cards.count > 0 {
            return cards.remove(at: cards.count.arc4random)
        }else {
            return nil
        }
    }
}

extension Int {
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        }else if self < 0 {
            return -Int(arc4random_uniform(UInt32(self)))
        }else {
            return 0
        }
    }
}
