//
//  SearchViewController.swift
//  FilmShare
//
//  Created by David Sann on 7/12/20.
//  Copyright © 2020 David Sann. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var searchBar: UITextField!
    
    @IBOutlet weak var dataTable: UITableView!
    
    var results: [Item] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func keyType(_ sender: Any) {
        let search: String = searchBar.text!
        if search != "" {
            gatherMovies(search) { (movies) in
                //print(movies)
                self.results = movies.d
            }
        } else { results = [] }
        dataTable.reloadData()
        
    }
    
    func createArray(_ movies: Response) -> [Response] {
        return [movies]
    }
    
    
    struct Response: Decodable {
        var v: Int
        var q: String
        var d: [Item]
    }
    
    struct Item: Decodable {
        let l: String
        let id: String
        let s: String
        let url: String
        let width: Int?
        let height: Int?
        
        enum CodingKeys: CodingKey {
            case l, id, s, i
        }
        
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            l = try container.decode(String.self, forKey: .l)
            id = try container.decode(String.self, forKey: .id)
            s = try container.decode(String.self, forKey: .s)
            var nestedContainer = try container.nestedUnkeyedContainer(forKey: .i)
            url = try nestedContainer.decode(String.self)
            width = try nestedContainer.decodeIfPresent(Int.self)
            height = try nestedContainer.decodeIfPresent(Int.self)
        }
    }
    
    func gatherMovies(_ userSearch: String, completion: @escaping(Response) -> ()) {
        //let apiKey = "4e30c883"
        //let movieURL = "http://www.omdbapi.com/?apikey=" + apiKey + "&t=" + userSearch
        if userSearch.count != 0 {
            let firstL = String(Array(userSearch)[0])
            let movieURL = "https://sg.media-imdb.com/suggests/" + firstL.lowercased() + "/" + userSearch.lowercased() + ".json"
            print("start")
            if let url = URL(string: movieURL) {
                URLSession.shared.dataTask(with: url) { data, res, err in
                    if let data = data {
                        print("hey")
                        let decoder = JSONDecoder()
                        let str = String(String(decoding: data, as: UTF8.self).dropLast())
                        let index = (str.range(of: "(")?.upperBound)
                        let cleanJSON = Data(String(str.suffix(from: index!)).utf8)
                        if let json = try? decoder.decode(Response.self, from: cleanJSON) {
                            completion(json)
                        }
                    }
                }.resume()
            }
        }
    }
}

extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = results[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchTableViewCell") as! SearchTableViewCell
        cell.setMovie(title: item.l, year: item.s, image: item.url)
        return cell
    }
}

