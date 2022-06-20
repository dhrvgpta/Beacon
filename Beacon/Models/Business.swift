//  Business.swift
//  Beacon

//  Created by Dhruv Gupta on 21/06/22.

import Foundation

struct Business:Decodable, Identifiable{
    var id = "", alias: String?, name: String?, image_url: String?, is_closed: Bool, url: String?, review_count: Int, categories: [Category]?,
    rating:Double?, coordinates: Coordinates?, transactions: [String]?, price: String?, location: Location?, phone: String?, display_phone: String?,
    distance: Double?
}

struct Category: Decodable{
    var alias: String?, title: String?
}

struct Coordinates: Decodable{
    var latitude:Double?, longitude:Double?
}

struct Location:Decodable{
    var address1: String?, address2: String?, address3: String?, city: String?, zip_code: String?, country:String?, state: String?, display_address: [String]?
}
