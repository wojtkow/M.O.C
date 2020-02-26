//
//  MapViewController.swift
//  M.O.C
//
//  Created by Tomasz Wojtkowiak on 16/05/2019.
//  Copyright © 2019 Peritum.Net. All rights reserved.
//

import UIKit
import GoogleMaps

class MapViewController: UIViewController {

	@IBOutlet weak var mapView: GMSMapView!
	@IBOutlet weak var mapTypeButton: UIButton!
	
	//MARK: - View Controller
	init() {
		super.init(nibName: "MapViewController", bundle: nil)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init?(coder:) is not supported")
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()
		self.title = "M.O.C"
		
		mapView.settings.myLocationButton = true
		mapView.settings.compassButton = true
		mapView.mapType = .satellite
		
		mapView.delegate = self
		
		setupViewElements()
	}
	
	//MARK: - Actions
	@IBAction func changeMapeTypeAction(_ sender: Any) {
		if mapView.mapType == .satellite {
			mapView.mapType = .normal
		}
		else {
			mapView.mapType = .satellite
		}
	}
	
	//MARK: - Private
	private func setupViewElements() {
		mapTypeButton.layer.cornerRadius = 24
		mapTypeButton.layer.borderColor = UIColor.darkGray.cgColor
		mapTypeButton.layer.borderWidth = 1.0
		mapTypeButton.backgroundColor = .white
	}
}


extension MapViewController: GMSMapViewDelegate {
	
}

