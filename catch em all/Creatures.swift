//
//  creatures.swift
//  catch em all
//
//  Created by Matthew  Sustaita on 11/24/22.
//

import Foundation

class Creatures {
    private struct Returned: Codable {
        var count: Int
        var next: String?
        var results: [Creature]
        
    }
    
   
    var count = 0
    var urlString = "https://pokeapi.co/api/v2/pokemon/?offset=0&limit=20"
    var creatureArray: [Creature] = []
    var isFetching = false
    
    func getData(completed: @escaping ()->()) {
        print("accessing URL")
        //does not get data if already fetching data, avoids double fetching.
        guard !isFetching else {
            return
        }
        isFetching = true
        
        isFetching = true
        
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
                self.creatureArray = self.creatureArray + returned.results
                self.urlString = returned.next ?? ""
                self.count = returned.count
            } catch {
                print("thrown when tried to decode from Returned.self with data")
            }
            self.isFetching = false
            completed()
        }
        
        task.resume()
    }
}
