//  BusinessSectionView.swift
//  Beacon

//  Created by Dhruv Gupta on 21/06/22.


import SwiftUI

struct BusinessSectionView: View {
    var sectionTitle:String
    var businesses: [Business]
    
    var body: some View {
        Section(header: BusinessHeaderView(title: sectionTitle)){
            ForEach(businesses){ business in
                BusinessRowView(business: business)
            }
        }
    }
}


