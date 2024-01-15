//
//  NewJobTableViewController.swift
//  GoodJob_Prototype
//
//  Created by JeongTaek Han on 1/15/24.
//

import UIKit

class NewJobTableViewController: UITableViewController {

    @IBOutlet weak var testTypeMenuButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let popUpButtonClosure = { (action: UIAction) in
            print("Pop-up action")
        }
        
        testTypeMenuButton.menu = UIMenu(children: [
            UIAction(title: "First Entry", handler: popUpButtonClosure),
            UIAction(title: "Second Entry", handler: popUpButtonClosure)
        ])
        
        testTypeMenuButton.showsMenuAsPrimaryAction = true
    }

}
