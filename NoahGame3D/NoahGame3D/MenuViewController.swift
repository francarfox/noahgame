//
//  MenuViewController.swift
//  NoahGame3D
//
//  Created by Franklin Fox on 7/3/16.
//  Copyright © 2016 FoxDev. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
    
    @IBOutlet weak var userName: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func didOnline(_ sender: AnyObject) {
        // login - connect with server
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "menuToGameSegue" {
            let game = segue.destination as! GameViewController
            
            if userName.text != nil {
                game.userName = userName.text
            } else {
                game.userName = "User Name"
            }
        }
    }

}
