//
//  SetGame.swift
//  SetGame
//
//  Created by 凯琦牟 on 2018/8/8.
//  Copyright © 2018年 凯琦牟. All rights reserved.
//

import Foundation

func isSet (firstCard:Card,secondCard:Card,thirdCard:Card) -> Bool {
    if ((firstCard.numbers != 4) && (secondCard.numbers != 4 )) && (thirdCard.numbers != 4) {
        let firstBool = (((firstCard.numbers == secondCard.numbers) && (firstCard.numbers == thirdCard.numbers)) || (firstCard.numbers + secondCard.numbers + thirdCard.numbers == 6))
        let secondBool = (((firstCard.symbols == secondCard.symbols) && (firstCard.symbols == thirdCard.symbols)) || (firstCard.symbols + secondCard.symbols + thirdCard.symbols == 6))
        let thirdBool = (((firstCard.shadings == secondCard.shadings) && (firstCard.shadings == thirdCard.shadings)) || (firstCard.shadings + secondCard.shadings + thirdCard.shadings == 6))
        let forthBool = (((firstCard.colors == secondCard.colors) && (firstCard.colors == thirdCard.colors)) || (firstCard.colors + secondCard.colors + thirdCard.colors == 6))
        return (firstBool && secondBool) && (thirdBool && forthBool)
    }
    else {
        return false
    }
}

func chooseCard (at card: inout Card, whenThereAre cards : inout [Card]) -> Bool? {
    if  cards.count != 2 {
        if card.selected {
            card.selected = false
            cards.removeLast()
        }else {
            card.selected = true
            cards.append(card)
        }
    }else {
        if card.selected {
            card.selected = false
            cards.removeLast()
        }else {
            card.selected = true
            cards.append(card)
            return isSet(firstCard: cards[0], secondCard: cards[1], thirdCard: card)
        }
    }
    return nil
}

func existASet (cardOnTheDesk:[Card]) -> (indexofFirstCard:Int,indexofSecondCard:Int,indexofThridCard:Int)? {
    for indexOfFirstCard in 0...(cardOnTheDesk.count - 3) {
        for indexOfSecondCard in (indexOfFirstCard + 1)...(cardOnTheDesk.count - 2) {
            for indexOfThirdCard in (indexOfSecondCard + 1)...(cardOnTheDesk.count - 1) {
                if isSet(firstCard: cardOnTheDesk[indexOfFirstCard], secondCard: cardOnTheDesk[indexOfSecondCard], thirdCard: cardOnTheDesk[indexOfThirdCard]){
                    return (indexOfFirstCard,indexOfSecondCard,indexOfThirdCard)
                }
            }
        }
    }
    return nil
}
