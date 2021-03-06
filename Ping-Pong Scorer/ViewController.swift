//
//  ViewController.swift
//  Ping-Pong Scorer
//
//  Created by Stuart McClintock on 12/15/19.
//  Copyright © 2019 Stuart McClintock. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
   var p1Score: Int = 0
   var p2Score: Int = 0
   var p1JustScored: Bool = false
   var isActive: Bool = true

   var del: AppDelegate!

   @IBOutlet weak var serveLabel: UILabel!
   @IBOutlet weak var p1ScoreLabel: UILabel!
   @IBOutlet weak var p2ScoreLabel: UILabel!
   @IBOutlet weak var p1ScoreBtn: UIButton!
   @IBOutlet weak var p2ScoreBtn: UIButton!
   @IBOutlet weak var resetBtn: UIButton!
   @IBOutlet weak var settingsBtn: UIButton!
   
   func findWinner() -> Int{ // Returns 0 if nobody won, 1 for player 1 and 2 for player 2
      if del.getMustBeAheadBy2(){
         if p1Score-p2Score >= 2 && p1Score >= del.getWinningScore(){
            return 1
         }
         if p2Score-p1Score >= 2 && p2Score >= del.getWinningScore(){
            return 2
         }
      }
      else{
         if p1Score == del.getWinningScore(){
            return 1
         }
         if p2Score == del.getWinningScore(){
            return 2
         }
      }
      return 0
   }

   func updateServeLabel(){
      let winner: Int = findWinner()
      if (winner==0){
         var server1: Bool = false
         switch del.getServeChange(){
         case .everyTwoScores:
            let totalPoints: Int = p1Score+p2Score
            server1 = totalPoints%4 == 0 || totalPoints%4 == 1
         case .winnerServes:
            server1 = p1JustScored
         case .loserServes:
            server1 = !p1JustScored
         }

         if server1{
            serveLabel.text = "Player 1 to Serve"
         }
         else{
            serveLabel.text = "Player 2 to Serve"
         }
      }
      else if (winner==1){
         serveLabel.text = "Player 1 to Wins!"
         isActive=false
      }
      else{
         serveLabel.text = "Player 2 to Wins!"
         isActive=false
      }
   }

   @IBAction func p1PointScored(_ sender: Any) {
      if isActive{
         p1Score+=1
         p1ScoreLabel.text = "Player 1: \(p1Score)"
         p1JustScored = true
         updateServeLabel()
      }
   }
   @IBAction func p2PointScored(_ sender: Any) {
      if isActive{
         p2Score+=1
         p2ScoreLabel.text = "Player 2: \(p2Score)"
         p1JustScored = false
         updateServeLabel()
      }
   }

   func reset(){
      isActive = true
      p1Score = 0
      p2Score = 0
      p1ScoreLabel.text = "Player 1: 0"
      p2ScoreLabel.text = "Player 2: 0"
      serveLabel.text = "Player 1 to Serve"
   }

   @IBAction func resetTapped(_ sender: Any) {
      reset()
   }

   override func viewDidLoad() {
      super.viewDidLoad()
      let app = UIApplication.shared
      del = app.delegate as? AppDelegate

      p1ScoreBtn.backgroundColor = UIColor(red: 0.11, green: 0.11, blue: 0.11, alpha: 1)
      p1ScoreBtn.layer.cornerRadius = 15
      p2ScoreBtn.backgroundColor = UIColor(red: 0.11, green: 0.11, blue: 0.11, alpha: 1)
      p2ScoreBtn.layer.cornerRadius = 15

      settingsBtn.backgroundColor = .black //UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
      settingsBtn.layer.cornerRadius = 10
      resetBtn.backgroundColor = .black //UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
      resetBtn.layer.cornerRadius = 10

      self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
      self.navigationController?.navigationBar.shadowImage = UIImage()
      self.navigationController?.navigationBar.isTranslucent = true

      self.navigationController?.navigationBar.barStyle = .black

      // Do any additional setup after loading the view.
   }

   override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
      self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
      self.navigationController?.navigationBar.shadowImage = UIImage()
      self.navigationController?.navigationBar.isTranslucent = true
      self.navigationController?.navigationBar.barStyle = .black
   }

   override func viewWillDisappear(_ animated: Bool) {
      super.viewWillDisappear(animated)
      self.navigationController?.navigationBar.barStyle = .default
      self.navigationController?.navigationBar.shadowImage = nil
      self.navigationController?.navigationBar.isTranslucent = true
   }

}

