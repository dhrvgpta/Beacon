//  BusinessSearch.swift
//  Beacon

//  Created by Dhruv Gupta on 21/06/22.


import Foundation

struct BusinessSearch: Decodable{
    var businesses = [Business](), total = 0, region = Region()
}

struct Region: Decodable{
    var center = Coordinates()
}

