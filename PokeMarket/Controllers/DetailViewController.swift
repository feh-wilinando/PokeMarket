//
//  DetailViewController.swift
//  PokeMarket
//
//  Created by Nando on 03/10/17.
//  Copyright © 2017 Nando. All rights reserved.
//

import UIKit
import AlamofireImage


class DetailViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    var card:Card?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let actualCard = card {
            nameLabel.text = actualCard.name
            priceLabel.text = "U$ \(actualCard.price)"
            imageView.af_setImage(withURL: URL(string: actualCard.imageURL)!)
        }
        
        
        navigationItem.title = "Details"
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
