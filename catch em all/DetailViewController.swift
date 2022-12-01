//
//  DetailViewController.swift
//  catch em all
//
//  Created by Matthew  Sustaita on 11/30/22.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    var creature: Creature!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = creature.name
        
        let creatureDetail = CreatureDetail()
        creatureDetail.urlString = creature.url
        creatureDetail.getData {
            DispatchQueue.main.async {
                self.weightLabel.text = "\(creatureDetail.weight)"
                self.heightLabel.text = "\(creatureDetail.height)"
                guard let url = URL(string: creatureDetail.imageURL) else {return}
                do {
                    let data = try Data(contentsOf: url)
                    self.imageView.image = UIImage(data:data)
                } catch {
                    print("error thrown trying to get image from url \(url)")
                }
                
            }
            
        }
        
    }

}
