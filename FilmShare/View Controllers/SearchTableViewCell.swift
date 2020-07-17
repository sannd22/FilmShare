//
//  SearchTableViewCell.swift
//  FilmShare
//
//  Created by David Sann on 7/14/20.
//  Copyright © 2020 David Sann. All rights reserved.
//

import UIKit

class SearchTableViewCell: UITableViewCell {

    @IBOutlet weak var posterImage: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var yearLabel: UILabel!
    
    @IBOutlet weak var actorsLabel: UILabel!
    
    func setMovie(title: String, year: String, image: String) {
        titleLabel.text = title
        yearLabel.text = year
        downloadImage(from: URL(string: image)!)
        
    }
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    func downloadImage(from url: URL) {
        print("Download Started")
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            DispatchQueue.main.async() { [weak self] in
                self?.posterImage.image = UIImage(data: data)
            }
        }
    }
    
    
}
