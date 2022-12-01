//
//  CreatureDetail.swift
//  catch em all
//
//  Created by Matthew  Sustaita on 11/30/22.
//

import Foundation

class CreatureDetail {
    
    private struct Returned: Codable{
        var height: Double
        var weight: Double
        var sprites: Sprites
    }
    private struct Sprites: Codable {
        var front_default: String?
    }
    var height = 0.0
    var weight = 0.0
    var imageURL = ""
    var urlString = ""
    
    func getData(completed: @escaping ()->()) {
        print("accessing URL")
        
        //create URL
        guard let url = URL(string: urlString) else {
            print("error Could not print a URL from \(urlString)")
            return
        }
        //create a session
        let session = URLSession.shared
        
        //get data with .dataTask method
        let task = session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("error:\(error.localizedDescription)")
            }
            do{
                let returned = try JSONDecoder().decode(Returned.self, from: data!)
                print("here is what was returned \(returned)")
                self.height = returned.height
                self.weight = returned.weight
                self.imageURL = returned.sprites.front_default ?? ""
              
            } catch {
                print("thrown when tried to decode from Returned.self with data")
            }
            completed()
        }
        
        task.resume()
    }
}
