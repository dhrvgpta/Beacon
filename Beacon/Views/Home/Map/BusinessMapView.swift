//  BusinessMapView.swift
//  Beacon

//  Created by Dhruv Gupta on 21/06/22.


import SwiftUI
import MapKit

struct BusinessMapView: UIViewRepresentable {
    
    @EnvironmentObject var model: ContentModel
    var locations: [MKPointAnnotation] {
        
        var annotations = [MKPointAnnotation]()
    
        // Create a set of annotations from our list of businesses
        for business in model.restaurants + model.sights{
            
            // If the business has both lat and long, only then create annotations
            if let lat = business.coordinates?.latitude, let long = business.coordinates?.longitude{
                let ann = MKPointAnnotation()
                ann.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
                ann.title = business.name ?? ""
                annotations.append(ann)
            }
        }
        return annotations
    }

   
    func makeUIView(context: Context) -> MKMapView {
        
        let mapView = MKMapView()
    
        // Show user's location
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .followWithHeading
        
        // TODO: - Set the region
        
        return mapView
    }
    
    func updateUIView(_ mapView: MKMapView, context: Context) {
        
        // Remove the annotations
        mapView.removeAnnotations(mapView.annotations)
        
        // Add the ones based upon arrary of businesses
        mapView.showAnnotations(self.locations, animated: true)
    }
    
    static func dismantleUIView(_ mapView: MKMapView, coordinator: ()) {
        mapView.removeAnnotations(mapView.annotations)
    }
}



