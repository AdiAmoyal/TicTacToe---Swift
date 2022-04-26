//
//  ViewController.swift
//  TicTacToe
//
//  Created by Adi Amoyal on 24/04/2022.
//

import UIKit

class ViewController: UIViewController {
    
    enum Turn {
        case O
        case X
    }

    @IBOutlet weak var a1Btn: UIButton!
    @IBOutlet weak var a2Btn: UIButton!
    @IBOutlet weak var a3Btn: UIButton!
    @IBOutlet weak var b1Btn: UIButton!
    @IBOutlet weak var b2Btn: UIButton!
    @IBOutlet weak var b3Btn: UIButton!
    @IBOutlet weak var c1Btn: UIButton!
    @IBOutlet weak var c2Btn: UIButton!
    @IBOutlet weak var c3Btn: UIButton!
    
    @IBOutlet weak var turnLabel: UILabel!
    @IBOutlet weak var oScoreLabel: UILabel!
    @IBOutlet weak var xScoreLable: UILabel!
    
    var board = [UIButton]()
    
    var firstTurn = Turn.X
    var currentTurn = Turn.X
    
    var O = "O"     // Nought
    var X = "X"     // Cross
    
    var XScore = 0
    var OScore = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initBoard()
        xScoreLable.text = "0"
        oScoreLabel.text = "0"
    }
    
    func initBoard() {
        board.append(a1Btn)
        board.append(a2Btn)
        board.append(a3Btn)
        board.append(b1Btn)
        board.append(b2Btn)
        board.append(b3Btn)
        board.append(c1Btn)
        board.append(c2Btn)
        board.append(c3Btn)
    }
    
    @IBAction func newGameBtn(_ sender: UIButton) {
        resetGame()
    }
    
    @IBAction func boardTapAction(_ sender: UIButton) {
        addToBoard(sender)
        
        if(isWinner()) {
            if (currentTurn == Turn.X) {
                resultAlert(title: "O Win!")
                OScore += 1
                oScoreLabel.text = String(OScore)
            } else {
                resultAlert(title: "X Win!")
                XScore += 1
                xScoreLable.text = String(XScore)
            }
        }
        
        if(isFullBoard()) {
            resultAlert(title: "Draw")
        }
    }
    
    func isFullBoard() -> Bool {
        for btn in board {
            if (btn.title(for: .normal) == nil || btn.title(for: .normal) == "") {
                return false
            }
        }
        return true
    }
    
    func addToBoard(_ btn: UIButton) {
        if(btn.title(for: .normal) == nil || btn.title(for: .normal) == "") {
            if(currentTurn == Turn.O) {
                btn.setTitle(O, for: .normal)
                currentTurn = Turn.X
                turnLabel.text = X
            } else if (currentTurn == Turn.X){
                btn.setTitle(X, for: .normal)
                currentTurn = Turn.O
                turnLabel.text = O
            }
        }
        btn.isEnabled = false
    }
    
    func isWinner() -> Bool {
        if(isSameSymbol(a1Btn, a2Btn) && isSameSymbol(a2Btn, a3Btn)) {
            return true
        }
        if(isSameSymbol(b1Btn, b2Btn) && isSameSymbol(b2Btn, b3Btn)) {
            return true
        }
        if(isSameSymbol(c1Btn, c2Btn) && isSameSymbol(c2Btn, c3Btn)) {
            return true
        }
        
        
        if(isSameSymbol(a1Btn, b1Btn) && isSameSymbol(b1Btn, c1Btn)) {
            return true
        }
        if(isSameSymbol(a2Btn, b2Btn) && isSameSymbol(b2Btn, c2Btn)) {
            return true
        }
        if(isSameSymbol(a3Btn, b3Btn) && isSameSymbol(b3Btn, c3Btn)) {
            return true
        }
        
        
        if(isSameSymbol(a3Btn, b2Btn) && isSameSymbol(b2Btn, c1Btn)) {
            return true
        }
        if(isSameSymbol(a1Btn, b2Btn) && isSameSymbol(b2Btn, c3Btn)) {
            return true
        }
        return false
    }
    
    func isSameSymbol(_ btn1: UIButton, _ btn2: UIButton) -> Bool {
        if (btn1.title(for: .normal) == "" || btn2.title(for: .normal) == "") {
            return false
        }
        return btn1.title(for: .normal) != nil && btn1.title(for: .normal) == btn2.title(for: .normal)
    }
    
    func resetGame() {
        for btn in board {
            btn.setTitle("", for: .normal)
            btn.isEnabled = true
        }
        
        
        if(firstTurn == Turn.O) {
            firstTurn = Turn.X
            turnLabel.text = X
        } else if(firstTurn == Turn.X) {
            firstTurn = Turn.O
            turnLabel.text = O
        }
        currentTurn = firstTurn
    }
    
    func resultAlert(title: String) {
        let message = "\nO Score " + String(OScore) + "\n\nX Score " + String(XScore)
        let ac = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        ac.addAction(UIAlertAction(title: "Reset", style: .default, handler: { (_) in self.resetGame()}))
        self.present(ac, animated: true)
    }

}

