//
//  CyclingDistanceViewController.swift
//  Bikemate
//
//


import UIKit

class CyclingDistanceViewController : UIViewController {

    @IBOutlet weak var graphImageViewForTheAverage: UIImageView!
    @IBOutlet weak var graphImageViewForTheTotal: UIImageView!

    @IBOutlet weak var averageDistanceButton: UIButton!
    @IBOutlet weak var totalDistanceButton: UIButton!


    override func viewDidLoad() {
        super.viewDidLoad()

        let buttonsArray = [averageDistanceButton, totalDistanceButton]

        for button in buttonsArray {
            button!.layer.masksToBounds = false
            button!.layer.shadowOffset = CGSize(width: 0, height: 0)
            button!.layer.shadowOpacity = 0.28
            button!.layer.shadowRadius = 8
        }

        let graphImage : UIImage? = UIImage(named: "graphImage.png")
        graphImageViewForTheAverage.image = graphImage
        graphImageViewForTheTotal.image = graphImage
    }
}
