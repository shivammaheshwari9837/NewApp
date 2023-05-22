//
//  ViewController.swift
//  NewApp
//
//  Created by Shivam Maheshwari on 22/05/23.
//

import UIKit

class ViewController: UIViewController {
    

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "News"
        view.backgroundColor = .systemBackground
        APICaller.shared.getTopStories { result in
            
        }
        // Do any additional setup after loading the view.
    }


}

