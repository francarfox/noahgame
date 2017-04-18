//
//  GameController.swift
//  NoahGame
//
//  Created by Technorides on 4/16/17.
//  Copyright © 2017 francarfox. All rights reserved.
//

import UIKit

class GameController: UIViewController {
    
    @IBOutlet var username1: UILabel!
    @IBOutlet var username2: UILabel!
    @IBOutlet var skills: [UIButton]!
    
    var messages = [Message]()
    var challenge: Challenge?
    
    var user: User? {
        didSet {
            navigationItem.title = user?.name
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpPersonages()
        createChallenge()
    }
    
    func setUpPersonages() {
        if let name1 = UserDefaults.standard.string(forKey: "user_name"),
            let name2 = user?.name {
            
            GameManager.shared.createPersonage1(name: name1)
            GameManager.shared.createPersonage2(name: name2)
            
            let pj1 = GameManager.shared.pj1
            let pj2 = GameManager.shared.pj2
            
            username1.text = "\(name1) h:\(pj1.health) e:\(pj1.energy)"
            username2.text = "\(name2) h:\(pj2.health) e:\(pj2.energy)"
            
        }
        
        GameManager.shared.delegate = self
    }
    
    func createChallenge() {
        let pj1 = GameManager.shared.pj1
        let pj2 = GameManager.shared.pj2
        
        NoahService.shared.createChallenge(personage1: pj1, personage2: pj2, completion: { challenge in
            self.challenge = challenge
        })
    }
    
    @IBAction func activateSkill(_ sender: UIButton) {
        
        let index = skills.index(of: sender) ?? 0
        var skill: SkillName
        
        switch index {
        case 1:
            skill = .thunder
        case 2:
            skill = .final
        case 3:
            skill = .electrons
        case 4:
            skill = .immunity
        case 5:
            skill = .current
        default:
            skill = .flames
        }
        
        let target = GameManager.shared.pj2
        GameManager.shared.pj1.activateSkill(skill, target: target)
        
    }
    
    
    func observeMessages() {
        NoahService.shared.observeMessages { (message) in
            self.messages.append(message)
        }
    }

    func sendMessage() {
        let message = "Hello World!!!"
        
        if let toId = user?.id {
            NoahService.shared.sendMessage(message, toId: toId, completion: {
                print("didSendMessage")
            })
        }
    }
    
}

extension GameController: AttackableDelegate {
    
    /*
    @IBAction func didUp(_ sender: Any) {
        GameManager.shared.movePersonage1(direction: .left)
    }
    
    @IBAction func didLeft(_ sender: Any) {
        GameManager.shared.movePersonage1(direction: .down)
    }
    
    @IBAction func didRight(_ sender: Any) {
        GameManager.shared.movePersonage1(direction: .up)
    }
    
    @IBAction func didDown(_ sender: Any) {
        GameManager.shared.movePersonage1(direction: .right)
    }*/
    
    func updateStatus(_ health: Int, energy: Int) {
        print("pj h:\(health) e:\(energy)")
    }
    
    func updateLocation(_ location: Vector) {
        print("location x:\(location.x) y:\(location.y)")
        
        //pj1.frame.origin = CGPoint(x: CGFloat(location.x), y: CGFloat(location.y))
    }
    
}
