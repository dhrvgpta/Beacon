//  BusinessMapView.swift
//  Beacon

//  Created by Dhruv Gupta on 21/06/22.


import SwiftUI
import MapKit

struct BusinessMapView: UIViewRepresentable {
    
    @EnvironmentObject var model: ContentModel
    @Binding var selectedBusiness: Business?
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
        mapView.delegate = context.coordinator
    
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
    
    // MARK: - Coordinator Class
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(parentMapView: self)
    }
    
    class Coordinator: NSObject, MKMapViewDelegate{
        
        var parentMapView: BusinessMapView
        
        init(parentMapView: BusinessMapView) {
            self.parentMapView = parentMapView
        }
        
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            
            // Skip the user location annotation
            if annotation is MKUserLocation{
                return nil
            }
            
            // If there exists reusable annotation view, use that
            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "beacon")
            if annotationView == nil {
                annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: "beacon")
                annotationView!.canShowCallout = true
                annotationView!.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
                return annotationView
            }else{
                
                // We got a reusable one
                annotationView!.annotation = annotation
                return annotationView
            }
        }
        func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
           
            // Loop through all businesses to find a match with the title
            for business in parentMapView.model.restaurants + parentMapView.model.sights{
                if business.name == view.annotation!.title{
                    
                    // Set the selected business which is going to update the binding and hence trigger the sheet
                    parentMapView.selectedBusiness = business
                }
            }
        }
    }
}



