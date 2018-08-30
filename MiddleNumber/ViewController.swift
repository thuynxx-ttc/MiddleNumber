//
//  ViewController.swift
//  MiddleNumber
//
//  Created by Nguyễn Xuân Thuỷ on 8/28/18.
//  Copyright © 2018 Nguyễn Xuân Thuỷ. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var lbScore: UILabel!
    
    @IBOutlet weak var lbFirstNumber: UILabel!
    @IBOutlet weak var lbSecondNumber: UILabel!
    @IBOutlet weak var lbThirdNumber: UILabel!
    
    @IBOutlet weak var lbFirstAnswer: UILabel!
    @IBOutlet weak var lbSecondAnswer: UILabel!
    
    private var firstNumber:UInt32!
    private var thirdNumber:UInt32!
    
    private var firstAnswer:UInt32!
    private var secondAnswer:UInt32!
    
    private var score = 0
    
    //MARK: -- Initdata
    private func initData() {
//        lbSecondNumber.attributedText = NSAttributedString(string: a, attributes: underlineStringAttribute)
        lbScore.text = String(score)
        generateNumber()
    }
    
    //MARK: -- Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        initData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    //MARK: -- Private method
    private func generateNumber() { //Gen radom value for first & third number
        
        firstNumber = arc4random_uniform(99)
        let firstNumberString = (firstNumber >= 10 ? "" : "0") + String(firstNumber)
        lbFirstNumber.text = firstNumberString
        
        //Except first number == second number
        repeat {
            thirdNumber = arc4random_uniform(99)
        } while (thirdNumber == firstNumber)
        let thirdNumberString = (thirdNumber >= 10 ? "" : "0") + String(thirdNumber)
        lbThirdNumber.text = thirdNumberString
        
        //Generate value for answer
        repeat{
            firstAnswer = arc4random_uniform(99)
        } while (firstAnswer == firstNumber || firstAnswer == thirdNumber)
        let firstAnswerString = (firstAnswer >= 10 ? "" : "0") + String(firstAnswer)
        lbFirstAnswer.text = firstAnswerString
        
        (firstNumber < thirdNumber) ? genSecondAnswerValue(firstNumber, thirdNumber) : genSecondAnswerValue(thirdNumber, firstNumber)
        let secondAnswerString = (secondAnswer >= 10 ? "" : "0") + String(secondAnswer)
        lbSecondAnswer.text = secondAnswerString
    }
    
    private func genSecondAnswerValue(_ lessNumber: UInt32, _ greaterNumer: UInt32) {
        //firstAnswer in range
        if ((firstAnswer > lessNumber && firstAnswer < greaterNumer)) {
            repeat{
                secondAnswer = arc4random_uniform(99)
            } while(secondAnswer >= lessNumber && secondAnswer <= greaterNumer) //Gen a value out of range for secondAnswer
        } else { // firstAnswer out of range
            repeat{
                secondAnswer = arc4random_uniform(99)
            } while(secondAnswer <= lessNumber || secondAnswer >= greaterNumer) //Gen a value in range for secondAnswer
        }
    }
    
    private func checkANumberInRange(_ valueNeedToCheck: UInt32, _ firstNumber: UInt32, _ secondNumber: UInt32) -> Bool {
        
        if ((valueNeedToCheck > firstNumber && valueNeedToCheck < secondNumber) || (valueNeedToCheck > secondNumber && valueNeedToCheck < firstNumber)) {
            return true
        }
        
        return false
    }
    
    //MARK: -- Action

    @IBAction func onClickFirstAnswer(_ sender: UITapGestureRecognizer) {
        if checkANumberInRange(firstAnswer, firstNumber, thirdNumber) {
            generateNumber()
            score += 1
            lbScore.text = String(score)
        }
    }
    
    @IBAction func onClickSecondAnswer(_ sender: UITapGestureRecognizer) {
        if checkANumberInRange(secondAnswer, firstNumber, thirdNumber) {
            generateNumber()
            score += 1
            lbScore.text = String(score)
        }
    }
    
}

