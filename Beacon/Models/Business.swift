//  Business.swift
//  Beacon

//  Created by Dhruv Gupta on 21/06/22.

import Foundation

class Business: Decodable, Identifiable, ObservableObject{
    
    @Published var imageData: Data?
    
    var id: String?, alias: String?, name: String?, imageURL: String?, isClosed: Bool?, url: String?, reviewCount: Int? , categories: [Category]?,
    rating:Double?, coordinates: Coordinates?, transactions: [String]?, price: String?, location: Location?, phone: String?, displayPhone:    String?, distance: Double?
    
    enum CodingKeys: String, CodingKey{
        case id
        case alias
        case name
        case imageURL = "image_url"
        case isClosed = "is_closed"
        case url
        case reviewCount = "review_count"
        case categories
        case rating
        case coordinates
        case transactions
        case price
        case location
        case phone
        case displayPhone = "display_phone"
        case distance
    }
    
    func getImageData() {
        guard imageURL != nil else{
            return
        }
        
        let url = URL(string: imageURL!)
        guard url != nil else {
            return
        }
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: url!) { imageData, response, error in
            guard error == nil else{
                return
            }
            DispatchQueue.main.async {
                self.imageData = imageData!
            }
        }
        dataTask.resume()
    }
}

struct Category: Decodable{
    var alias: String?, title: String?
}

struct Coordinates: Decodable{
    var latitude:Double?, longitude:Double?
}

struct Location: Decodable{
    
    var address1: String?, address2: String?, address3: String?, city: String?, zipCode: String?, country:String?, state: String?, displayAddress: [String]?
    
    enum CodingKeys: String, CodingKey{
        case address1
        case address2
        case address3
        case city
        case zipCode = "zip_code"
        case country
        case state
        case displayAddress = "display_address"
    }
}
