//
//  CyclingSpeedViewController.swift
//  Bikemate
//
//

import UIKit

class CyclingSpeedViewController : UIViewController {
    
    @IBOutlet weak var graphImageViewForTheAverage: UIImageView!
    @IBOutlet weak var graphImageViewForTheHighest: UIImageView!
    
    @IBOutlet weak var averageSpeedButton: UIButton!
    @IBOutlet weak var highestSpeedButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let buttonsArray = [averageSpeedButton, highestSpeedButton]
        
        for button in buttonsArray {
            button!.layer.masksToBounds = false
            button!.layer.shadowOffset = CGSize(width: 0, height: 0)
            button!.layer.shadowOpacity = 0.28
            button!.layer.shadowRadius = 8
        }
        
        let graphImage : UIImage? = UIImage(named: "graphImage.png")
        graphImageViewForTheAverage.image = graphImage
        graphImageViewForTheHighest.image = graphImage
    }
    
}

