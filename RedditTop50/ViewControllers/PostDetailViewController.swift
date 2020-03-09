//
//  PostDetailViewController.swift
//  RedditTop50
//
//  Created by Nicolas Viegas Palermo on 09/03/2020.
//  Copyright © 2020 Nicolas Viegas Palermo. All rights reserved.
//

import UIKit

class PostDetailViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}

extension PostDetailViewController: SelectionDelegate {
    func didSelectPost(withId id: String) {
        title = "\(id) Details"
    }
}
