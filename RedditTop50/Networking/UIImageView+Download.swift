//
//  UIImageView+Download.swift
//  RedditTop50
//
//  Created by Nicolas Viegas Palermo on 09/03/2020.
//  Copyright © 2020 Nicolas Viegas Palermo. All rights reserved.
//

import UIKit

extension UIImageView {
    func load(fromURL imageUrl: URL?) {
        guard let url = imageUrl else { return }
        
        let downloadTask = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            DispatchQueue.main.async() {
                self?.image = UIImage(data: data)
            }
        }
        
        downloadTask.resume()
    }
}
