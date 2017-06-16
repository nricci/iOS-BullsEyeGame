//
//  ViewController.swift
//  Bull's Eye Game
//
//  Created by Nicolas Ricci on 15/6/17.
//  Copyright © 2017 Nicolas Ricci. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var currentValue: Int = 0
    var targetValue: Int = 0
    var score: Int = 0
    var roundCount: Int = 0
    
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var targetValueLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var roundCountLabel: UILabel!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeGame()
        startRound()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func initializeGame() {
        currentValue = 0
        targetValue = 0
        score = 0
        roundCount = 0
    }
    
    // Starts a new round: generate slider and target values randomly.
    // Updates UI accordingly.
    func startRound() {
        roundCount += 1
        currentValue = 1 + Int(arc4random_uniform(100))
        targetValue = 1 + Int(arc4random_uniform(100))
        
        slider.value = Float(currentValue)
        targetValueLabel.text = "\(targetValue)"
        roundCountLabel.text = "\(roundCount)"
        scoreLabel.text = "\(score)"
    }
    
    @IBAction func hitMePressed() {
        let scoredPoints = 100 - abs(targetValue - currentValue)
        
        let myMessage = "You just hit \(currentValue)" +
                        "\nThe target value is \(targetValue)" +
                        "\nYou scored \(scoredPoints) points."
        
        var title:String
        switch scoredPoints {
        case 0...60:
            title = "Not even close..."
        case 61...80:
            title = "Pretty good"
        case 80...99:
            title = "Almost!"
        case 100:
            title = "Perfect!!!"
        default:
            title = ""
        }
        
        let alert = UIAlertController(title:title,
                                      message:myMessage,
                                      preferredStyle: .alert)
        
        let action = UIAlertAction(title: "OK",
                                   style: .default,
                                   handler: {
                                                action in self.score += scoredPoints
                                                self.startRound()
                                            })
        
        alert.addAction(action)
        present(alert, animated:true, completion:nil) 
    }
    
    @IBAction func startOverPressed() {
        initializeGame()
        startRound()
    }
    
    @IBAction func sliderMoved(_ slider: UISlider) {
        currentValue = lroundf(slider.value)
        //print("The value of the slider is now: \(currentValue)")
    }

}

