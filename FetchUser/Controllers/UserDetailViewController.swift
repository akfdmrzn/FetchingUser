//
//  UserDetailViewController.swift
//  FetchUser
//
//  Created by Akif Demirezen on 23.01.2020.
//  Copyright © 2020 akif. All rights reserved.
//

import UIKit
import MapKit

class UserDetailViewController: BaseViewController {

    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelEmail: UILabel!
    @IBOutlet weak var labelPhone: UILabel!
    @IBOutlet weak var labelWebsite: UILabel!
    @IBOutlet weak var labelCompanyName: UILabel!
    @IBOutlet weak var labelCompanyCatch: UILabel!
    @IBOutlet weak var labelBs: UILabel!
    @IBOutlet weak var labelAdressStreet: UILabel!
    @IBOutlet weak var labelAdressSuite: UILabel!
    @IBOutlet weak var labelAdressCity: UILabel!
    @IBOutlet weak var labelZipcode: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    
    
    var user : UserModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let user = self.user else {
          return
        }
        self.setInfo(user: user)
        
    }
    
    func setInfo(user : UserModel){
        self.labelName.text = user.name
        self.labelEmail.text = user.email
        self.labelPhone.text = user.phone
        self.labelWebsite.text = user.website
        self.labelCompanyName.text = user.company.name
        self.labelCompanyCatch.text = user.company.catchPhrase
        self.labelBs.text = user.company.bs
        self.labelAdressStreet.text = user.address.street
        self.labelAdressSuite.text = user.address.suite
        self.labelAdressCity.text = user.address.city
        self.labelZipcode.text = user.address.zipcode
        let location = CLLocationCoordinate2D(latitude: self.user?.address.geo.lat.toDouble() ?? 0.0,
                                              longitude: self.user?.address.geo.lng.toDouble() ?? 0.0)
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: location, span: span)
            mapView.setRegion(region, animated: true)
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        annotation.title = self.user?.address.suite
        annotation.subtitle = self.user?.address.city
        mapView.addAnnotation(annotation)
    }
}
