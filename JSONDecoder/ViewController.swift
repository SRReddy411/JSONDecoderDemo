//
//  ViewController.swift
//  JSONDecoder
//
//  Created by volive solutions on 16/11/18.
//  Copyright © 2018 volive solutions. All rights reserved.
//

import UIKit



struct MyGitHub: Codable {
    
    let name: String?
    let location: String?
    let followers: Int?
    let avatarUrl: URL?
    let repos: Int?
    
    private enum CodingKeys: String, CodingKey {
        case name
        case location
        case followers
        case repos = "public_repos"
        case avatarUrl = "avatar_url"
        
    }
}

struct Person: Decodable {
    let id: Int
    let name: String
    let image_url: String
}

class ViewController: UIViewController {
    
    
    var people = [Person]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let gitUrl = URL(string: "https://api.github.com/users/shashikant86") else { return }
        URLSession.shared.dataTask(with: gitUrl) { (data, response
            , error) in
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                let gitData = try decoder.decode(MyGitHub.self, from: data)
                print(gitData.name)
                
            } catch let err {
                print("Err", err)
            }
            }.resume()

    }
    
    func parseJSON(data: Data){
        do {
            let decoder = JSONDecoder()
             
            self.people = try decoder.decode([Person].self, from: data)
        } catch let error {
            print(error as? Any)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }


}

