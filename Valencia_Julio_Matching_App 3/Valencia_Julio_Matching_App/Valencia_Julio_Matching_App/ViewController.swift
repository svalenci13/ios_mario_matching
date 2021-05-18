//
//  ViewController.swift
//  Valencia_Julio_Matching_App
//
//  Created by Period Two on 11/26/18.
//  Copyright © 2018 Period Two. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    //Variables and Outlet
    @IBOutlet weak var playerTextTwo: UITextField!
    @IBOutlet weak var playerText: UITextField!
    var myString: String = ""
    var myStringTwo: String = ""
    var soundsTwo: AVAudioPlayer = AVAudioPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //declaring my sounds, from a mp3 file that was imported.
        let crodumb = Bundle.main.path(forResource: "Volume Alpha - 08 - Minecraft", ofType: "mp3")
        do {
            try soundsTwo = AVAudioPlayer(contentsOf: URL (fileURLWithPath: crodumb!))
        }
        catch {
            print(error)
        }
        soundsTwo.play()
        // Do any additional setup after loading the view, typically from a nib.
    }
    var change = 0
    //When a button is pressed it it changes a variable that takes the user to another Viewcontroller,
    
    @IBAction func practiceMode(_ sender: Any) {
        change = 1
        performSegue(withIdentifier: "danylo", sender: nil)
    }
    @IBAction func timedMode(_ sender: Any) {
        change = 2
        performSegue(withIdentifier: "danylo", sender: nil)
    }
    @IBAction func twoPlayerMode(_ sender: Any) {
        myString = playerText.text!
        myStringTwo = playerTextTwo.text!
        
        if myString.isEmpty || myStringTwo.isEmpty {
              let alert = UIAlertController(title: "Missing Names", message: "Names are needed for both player to continue to the game, fill in the missing name.", preferredStyle: .alert)
               alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
               present(alert, animated:true)
            
            
        } else {
       
        change = 3
        performSegue(withIdentifier: "danylo", sender: nil)
    }
    }
    
    
    //based on the variable that was changed from the button pressed it will change the title of this new Viewcontroller to the name of the button
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if change == 1 {
            segue.destination.navigationItem.title = "Practice Mode"
        } else if change == 2 {
            segue.destination.navigationItem.title = "Timed Mode"
        } else if change == 3 {
            segue.destination.navigationItem.title = "2 Player Mode"
            //Changes player1 and player 2 score to the names that where imputed in the main menu
            let jew = segue.destination as! SecondViewController
            jew.sexyAlexi = myString
            let alexi = segue.destination as! SecondViewController
            alexi.alexi = myStringTwo
            
        }
    }
}



