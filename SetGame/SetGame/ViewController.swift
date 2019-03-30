//
//  ViewController.swift
//  SetGame
//
//  Created by 凯琦牟 on 2018/8/7.
//  Copyright © 2018年 凯琦牟. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var cardDeck = CardDeck()
    var cardsOnTheDesk = [Card]()
    var CardsSelected = [Card]()
    var maxNumberOfCard = 12
    var currentCardNumber = 0
    
    @IBOutlet var CardButtons: [UIButton]! {
        didSet {
            startaNewGame()
            if existASet(cardOnTheDesk: cardsOnTheDesk) == nil {
                deal3MoreCards.isSelected = true
            }
        }
    }
    
    @IBAction func TouchCard(_ sender: UIButton) {
        if let cardNumber = CardButtons.index(of: sender) {
            if cardsOnTheDesk[cardNumber].numbers != 4 {
                let result = chooseCard(at: &cardsOnTheDesk[cardNumber], whenThereAre: &CardsSelected)
                if result == nil {
                    sender.isSelected = !sender.isSelected
                }else {
                    if result == true {
                        for index in 0 ..< CardsSelected.count {
                            cardsOnTheDesk[CardsSelected[index].sequenceOnTheDesk] = voidCard
                            drawCard(card: voidCard, button: CardButtons[CardsSelected[index].sequenceOnTheDesk])
                            CardButtons[CardsSelected[index].sequenceOnTheDesk].isSelected = false
                            currentCardNumber -= 1
                            if existASet(cardOnTheDesk: cardsOnTheDesk) == nil {
                                deal3MoreCards.isSelected = true
                            }
                        }
                    }else {
                        for index in 0 ..< CardsSelected.count {
                            cardsOnTheDesk[CardsSelected[index].sequenceOnTheDesk].selected = false
                            CardButtons[CardsSelected[index].sequenceOnTheDesk].isSelected = false
                        }
                    }
                    CardsSelected.removeAll()
                }
            }
        }
    }
    @IBOutlet weak var deal3MoreCards: UIButton!
    
    func startaNewGame (){
        for indexNumber in 0..<12 {
            if let card = cardDeck.giveOutOneCard(){
                cardsOnTheDesk.append(card)
                cardsOnTheDesk[indexNumber].sequenceOnTheDesk = indexNumber
                drawCard(card:card, button: CardButtons[indexNumber])
                currentCardNumber += 1
            }
        }
        
    }
    
    @IBAction func deal3MoreCards(_ sender: UIButton) {
        if sender.isSelected == true {
            sender.isSelected = false
        }
        var addCardsNumber = 0
        if currentCardNumber < maxNumberOfCard {
            for index in 0 ..< maxNumberOfCard {
                if addCardsNumber < 3 {
                    if cardsOnTheDesk[index].numbers == 4 {
                        cardsOnTheDesk[index] = cardDeck.giveOutOneCard() ?? voidCard
                        cardsOnTheDesk[index].sequenceOnTheDesk = index
                        drawCard(card: cardsOnTheDesk[index], button: CardButtons[index])
                        addCardsNumber += 1
                        currentCardNumber += 1
                    }
                }
            }
        }else {
            while addCardsNumber < 3 {
                cardsOnTheDesk.append(cardDeck.giveOutOneCard() ?? voidCard)
                cardsOnTheDesk[cardsOnTheDesk.endIndex - 1].sequenceOnTheDesk = cardsOnTheDesk.count - 1
                maxNumberOfCard += 1
                drawCard(card: cardsOnTheDesk[cardsOnTheDesk.endIndex - 1], button: CardButtons[maxNumberOfCard - 1])
                addCardsNumber += 1
                currentCardNumber += 1
            }
        }
        if existASet(cardOnTheDesk: cardsOnTheDesk) == nil {
            deal3MoreCards.isSelected = true
        }
    }
    
    @IBAction func getHint(_ sender: UIButton) {
        if existASet(cardOnTheDesk: cardsOnTheDesk) != nil{
            CardButtons[existASet(cardOnTheDesk: cardsOnTheDesk)!.indexofFirstCard].isHighlighted = true
            CardButtons[existASet(cardOnTheDesk: cardsOnTheDesk)!.indexofSecondCard].isHighlighted = true
            CardButtons[existASet(cardOnTheDesk: cardsOnTheDesk)!.indexofThridCard].isHighlighted = true
            print(existASet(cardOnTheDesk: cardsOnTheDesk) ?? "nil")
        }
    }
    
    func drawCard(card:Card,button:UIButton) {
        var string = ""
        let color = cardColor[card.colors] ?? #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        for _ in 1...card.numbers {
            string += cardSymbol[card.symbols] ?? ""
        }
        var attributes = attributesStyle
        if card.shadings == 1 {
            attributes[.foregroundColor] = color
        }else if card.shadings == 2 {
            attributes[.strokeColor] = color
            attributes[.strokeWidth] = 2
        }else if card.shadings == 3 {
            attributes[.foregroundColor] = color.withAlphaComponent(0.15)
        }
        
        let attributedString = NSAttributedString(string: string, attributes: attributes)
        button.setAttributedTitle(attributedString, for: UIControlState.normal)
        button.layer.borderColor = color.cgColor
        button.layer.borderWidth = 2
    }
    
    let cardColor = [1:#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1),2:#colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1),3:#colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1),4:#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)]
    let cardSymbol = [1:"▲",2:"■",3:"●",4:""]
    let attributesStyle : [NSAttributedStringKey:Any] = [
        .font : UIFont.systemFont(ofSize: 32)
    ]

}

