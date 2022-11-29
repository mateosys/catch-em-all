//
//  ViewController.swift
//  catch em all
//
//  Created by Matthew  Sustaita on 11/24/22.
//

import UIKit

class ListViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var creatures = Creatures()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate  = self
        tableView.dataSource = self
        
        creatures.getData {
            DispatchQueue.main.async {
                self.navigationItem.title = "\(self.creatures.creatureArray.count) of \(self.creatures.count) Pkmn"
                self.tableView.reloadData()

            }
            
        }
    }
    
    func loadAll() {
        if creatures.urlString.hasPrefix("http"){
            creatures.getData {
                DispatchQueue.main.async {
                    self.navigationItem.title = "\(self.creatures.creatureArray.count) of \(self.creatures.count)Pkmn"
                    self.tableView.reloadData()
                    
                }
                self.loadAll()
            }
        } else {
            print("all done all loaded total pkmn : \(creatures.creatureArray.count)")
        }
    }

    @IBAction func loadAllButtonPressed(_ sender: Any) {
    }
    
}
extension ListViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return creatures.creatureArray.count
    }
    
 
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        if indexPath.row == creatures.creatureArray.count-1 && creatures.urlString.hasPrefix("http") {
            creatures.getData {
                DispatchQueue.main.async {
                    self.navigationItem.title = "\(self.creatures.creatureArray.count) of \(self.creatures.count)Pkmn"
                    self.tableView.reloadData()

                }
                
            }
        }
        cell.textLabel?.text = "\(indexPath.row+1). \(creatures.creatureArray[indexPath.row].name)"
        return cell
    }
    
    
}
