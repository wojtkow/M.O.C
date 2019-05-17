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
	
	//MARK: - View Controller
	init() {
		super.init(nibName: "MapViewController", bundle: nil)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init?(coder:) is not supported")
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		mapView.settings.myLocationButton = true
		mapView.settings.compassButton = true
		mapView.mapType = .satellite
		
		mapView.delegate = self
	}
	
	//MARK: - Actions
	
}


extension MapViewController: GMSMapViewDelegate {
	
}

