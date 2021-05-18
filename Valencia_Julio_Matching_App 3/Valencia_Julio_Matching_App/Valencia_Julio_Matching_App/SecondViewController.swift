//
//  SecondViewController.swift
//  Valencia_Julio_Matching_App
//
//  Created by Period Two on 11/27/18.
//  Copyright © 2018 Period Two. All rights reserved.
//

import UIKit
import AVFoundation

class SecondViewController: UIViewController {
    // Variables and Outlets used later
    @IBOutlet weak var starTimerImage: UIImageView!
    
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet var bucktee: [UIButton]!
    @IBOutlet weak var playerScore: UILabel!
    @IBOutlet weak var startTimerLabel: UIButton!
    @IBOutlet weak var newGameLabel: UIButton!
    
    @IBOutlet weak var giveUp: UIButton!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var playerTwoScore: UILabel!
    @IBOutlet weak var playerTwoScoreLabel: UILabel!
    var sexyAlexi: String = ""
    var alexi: String = ""
    var sounds: AVAudioPlayer = AVAudioPlayer()
    var deathSounds: AVAudioPlayer = AVAudioPlayer()
        override func viewDidLoad() {
        super.viewDidLoad()
        //calling up my shuffle function
        shuffle()
            //My sound do, try catch statement, that takes the mp3 file that I imported into the project and turn it into a constant that I used later
            let peadumb = Bundle.main.path(forResource: "Volume Alpha - 08 - Minecraft", ofType: "mp3")
            do {
                try sounds = AVAudioPlayer(contentsOf: URL (fileURLWithPath: peadumb!))
            }
            catch {
                print(error)
            }
            sounds.play(atTime: 20)
            //When playing a certain game mode, some labels and buttons disapear. And different alerts appear for each Gamemode when you load in.
            if navigationItem.title == "Practice Mode" {
                timerLabel.isHidden = true
                startTimerLabel.isHidden = true
                playerTwoScore.isHidden = true
                playerTwoScoreLabel.isHidden = true
                starTimerImage.isHidden = true
                let alert = UIAlertController(title: "Practice Mode", message: "This is Practice Mode, you are able to play by yourself and have as much time as you need> Try and get a High Score!!", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                present(alert, animated:true)
            } else if navigationItem.title == "Timed Mode" {
                timerLabel.isHidden = false
                startTimerLabel.isHidden = false
                playerTwoScore.isHidden = true
                playerTwoScoreLabel.isHidden = true
                let alert = UIAlertController(title: "Timed Mode", message: "This is Timed Mode you are given 60 seconds to complete the game, press Start Timer when you want to start", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                present(alert, animated:true)
                } else if navigationItem.title == "2 Player Mode" {
                timerLabel.isHidden = true
                starTimerImage.isHidden = true
                startTimerLabel.isHidden = true
                scoreLabel.text = "\(sexyAlexi) Score:"
                playerTwoScoreLabel.text = "\(alexi) Score:"
                let alert = UIAlertController(title: "2 Player Mode", message: "This is 2 Player Mode, the player with the most points at the end of the game wins.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                present(alert, animated:true)
                
            }
            }
    //Variables
    var unshuffledArray: [UIImage] = [#imageLiteral(resourceName: "cow2"),#imageLiteral(resourceName: "cow2"),#imageLiteral(resourceName: "sheep10"),#imageLiteral(resourceName: "sheep10"),#imageLiteral(resourceName: "cutmypic"),#imageLiteral(resourceName: "cutmypic"),#imageLiteral(resourceName: "chicken2"),#imageLiteral(resourceName: "chicken2"),#imageLiteral(resourceName: "mooshrom2"),#imageLiteral(resourceName: "mooshrom2"),#imageLiteral(resourceName: "vilager2"),#imageLiteral(resourceName: "vilager2"),#imageLiteral(resourceName: "steve2"),#imageLiteral(resourceName: "steve2"),#imageLiteral(resourceName: "pig2"),#imageLiteral(resourceName: "pig2")]
    var firstButton = -1
    var secondButton = -1
    var totalScore = 0
    var totalScoreTwo = 0
    var matchCounter: Int = 0
    var match = false
    var myTimer = Timer()
    var myTime = 60
    var playerTwoTurn = false
    var playerOneTurn = true
    var startingTimer = 0
    var changeTurns = false
    var amountOfMatches = 0
    var playerOneWin = false
    var playerTwoWin = false
    
    
    //Two player function I made that uses bool values from my matching. Which decides who's turn it is and changes turns when the changeTurns = true along with whos turn it is presently.
    func twoPlayMode () {
        if changeTurns == true  && playerOneTurn == true{
            playerTwoTurn = true
            playerOneTurn = false
            changeTurns = false
            
            
        } else if changeTurns == true && playerTwoTurn == true {
            playerTwoTurn = false
            playerOneTurn = true
            changeTurns = false
                }
    }
    // Timer function
    func timerBegins () {
        myTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block:{_ in self.codeTwoBeRun()})
    }
    //Timer goes down by 1 second, when the time equals zero, it will invalidate meaning it stops.
    func codeTwoBeRun () {
        myTime -= 1
        timerLabel.text = "Time \(myTime)"
        if myTime == 0 {
            myTimer.invalidate()
            
        }
        
    }
    //function that allows me to disable my 16 buttons, I added a for in loop to make it more effecient
    func disableButtons () {
        for index in 0...15 {
        bucktee[index].isUserInteractionEnabled = false
        }
    }
    //my flip card fuction that sets the imagine for the button.
    func flipCard(button: UIButton, image: UIImage) {
        button.setImage(image, for: .normal)
    }
    //Shuffle Function
    func shuffle() {
        unshuffledArray.shuffle()
        }
    //Scoring function that varies for each game mode, The title  decides which scoring to use.
    func score() {
        //A match give you two, but if you get multiple matches in a row the number will be increased by a power of 2
        if navigationItem.title == "Practice Mode" && match == true {
            totalScore += Int(pow(2, Double(matchCounter)))
            playerScore.text = String(totalScore)
        }// At the amount of time you have left when you got the match will be the amount that is added to your score, I used for in loops for this
        else if navigationItem.title == "Timed Mode" && match == true {
            for index in 0...60 {
                switch myTime {
            case index: totalScore += index
            default: print("HI")
                
            }
            playerScore.text = String(totalScore)
        }//Scoring for 2 player that decides which player will get the score added based on who turn it presently is.
        } else if navigationItem.title == "2 Player Mode" && match == true && playerOneTurn == true {
            totalScore += Int(pow(2, Double(matchCounter)))
            playerScore.text = String(totalScore)
        } else if navigationItem.title == "2 Player Mode" && match == true && playerTwoTurn == true {
            totalScoreTwo += Int(pow(2, Double(matchCounter)))
            playerTwoScore.text = String(totalScoreTwo)
        }
    }
    //Matching. I assign an image to a each button that is pressed, which also has a int value that will never change, so that the two buttons clicked will always be compared due to an if statement. The buttons are also assigned an image in my shuffled array of images. if the two buttons pressed are the same image than then you will get a match which will trigger the score function. If you do not get a match then the two tiles will flip back .
    func matching (button: Int) {
        if firstButton == -1 {
            firstButton = button
            self.bucktee[self.firstButton].isUserInteractionEnabled = false
        } else if secondButton == -1 {
            secondButton = button
            self.bucktee[self.secondButton].isUserInteractionEnabled = false
        }
        if firstButton != -1 && secondButton != -1 {
            if bucktee[firstButton].currentImage == bucktee[secondButton].currentImage {
                matchCounter += 1
                firstButton = -1
                secondButton = -1
                match = true
                amountOfMatches += 1
                changeTurns = false
                score()
            } else {
                self.view.isUserInteractionEnabled = false
                matchCounter = 0
                changeTurns = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    UIView.transition(with: self.bucktee[self.firstButton], duration: 0.5, options: .transitionFlipFromLeft, animations: nil, completion: nil)
                    UIView.transition(with: self.bucktee[self.secondButton], duration: 0.5, options: .transitionFlipFromLeft, animations: nil, completion: nil)
                    self.bucktee[self.firstButton].setImage(#imageLiteral(resourceName: "jackemo.png"), for: .normal)
                    self.bucktee[self.secondButton].setImage(#imageLiteral(resourceName: "jackemo.png"), for: .normal)
                    self.bucktee[self.firstButton].isUserInteractionEnabled = true
                    self.bucktee[self.secondButton].isUserInteractionEnabled = true
                    self.view.isUserInteractionEnabled = true
                    self.firstButton = -1
                    self.secondButton = -1
                    self.match = false
              }
           }
        }
    }
    //A button to start the timer for my timed mode, it contains my timer function.
    @IBAction func startTimer(_ sender: Any) {
        timerBegins()
        startTimerLabel.isEnabled = false
    }
    //When a button is pressed it sends whatever button is pressed as a UIButton
    @IBAction func allButtonsPressed(_ sender: UIButton) {
        var image: UIImage = #imageLiteral(resourceName: "580b57fcd9996e24bc43c2f4.png")
        var buttonNumber: Int = 0
        // I made a switch statement inside a for in loop that holds the value of the button
        for index in 0...15 {
        switch sender {
        case bucktee[index]:
            image = unshuffledArray[index]
            buttonNumber = index
        default:
            print("jack is gay")
            }
           
        }
        
        UIView.transition(with: bucktee[buttonNumber], duration: 0.5, options: .transitionFlipFromLeft, animations: nil, completion: nil)
        flipCard(button: sender, image: image)
        matching(button: buttonNumber)
        twoPlayMode()
        //Once I reach the maximum amount of matches then I will get an alert that will tell you that you finished the game, it will also tell you what score you got, and tell you that if you want to play a new game then you must press the new game button
        if amountOfMatches == 8 && navigationItem.title == "Practice Mode"{
            let alert = UIAlertController(title: "Game Over", message: "You finished the game with a score of \(totalScore)", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            present(alert, animated:true)
            
        } else if amountOfMatches == 8 && navigationItem.title == "Timed Mode" {
            let alert = UIAlertController(title: "Game Over", message: "You finished the game with a score of \(totalScore) with \(myTime) left. Press new game to play again.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            present(alert, animated:true)
            
        } else if amountOfMatches == 8 && navigationItem.title == "2 Player Mode" && totalScore > totalScoreTwo {
                    let alert = UIAlertController(title: "Game Over", message: "\(sexyAlexi) won with a score of \(totalScore) against \(alexi) who finished with a score of \(totalScoreTwo). Press new game to play again.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                    present(alert, animated:true)
        } else if amountOfMatches == 8 && navigationItem.title == "2 Player Mode" && totalScoreTwo > totalScore {
            let alert = UIAlertController(title: "Game Over", message: "\(alexi) won with a score of \(totalScoreTwo) against \(sexyAlexi) who finished with a score of \(totalScore). Press new game to play again ", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            present(alert, animated:true)
        }
        }
    // The give up button, when pressed it will reveal the images, disable the buttons, and also stop the timer, if it is timedMode
    @IBAction func giveUp(_ sender: Any) {
        for index in 0...15{
        bucktee[index].setImage(unshuffledArray[index], for: .normal)
        disableButtons()
        playerScore.text = "0"
        matchCounter = 0
        totalScore = 0
            for index in 0...15 {
            UIView.transition(with: bucktee[index], duration: 0.5, options: .transitionFlipFromLeft, animations: nil, completion: nil)
            }
        }
        newGameLabel.isEnabled = true
        giveUp.isEnabled = false
        myTimer.invalidate()
    }
    //New game button, that resets everything that was changed along the course of the game back to their orignal values.
    @IBAction func newGame(_ sender: Any) {
        for index in 0...15 {
            bucktee[index].setImage(#imageLiteral(resourceName: "jackemo.png"), for: .normal)
            bucktee[index].isUserInteractionEnabled = true
            matchCounter = 0
            totalScore = 0
            playerScore.text = "0"
            startTimerLabel.isEnabled = true
            myTime = 60
            timerLabel.text = "Timer: 60"
            playerTwoScore.text = "0"
            totalScoreTwo = 0
            amountOfMatches = 0
            for index in 0...15 {
                UIView.transition(with: bucktee[index], duration: 0.5, options: .transitionFlipFromLeft, animations: nil, completion: nil)
            }
            newGameLabel.isEnabled = false
            giveUp.isEnabled = true
            
            shuffle()
        }
    }
    
}
