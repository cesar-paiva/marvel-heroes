//
//  ViewController.swift
//  MarvelHeroes
//
//  Created by Cesar Paiva.
//  Copyright © Cesar Paiva. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textFieldName: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        textFieldName.resignFirstResponder()
        guard let viewController = segue.destination as? HeroesTableViewController else { return }
        viewController.name = textFieldName.text
    }

}

