//  BusinessListView.swift
//  Beacon

//  Created by Dhruv Gupta on 21/06/22.


import SwiftUI

struct BusinessListView: View {
    @EnvironmentObject var model: ContentModel
    
    var body: some View {
        if !model.restaurants.isEmpty || !model.sights.isEmpty{
            ScrollView(showsIndicators: false){
                LazyVStack(alignment: .leading, pinnedViews: .sectionHeaders){
                    
                    // Business Sections
                    BusinessSectionView(sectionTitle: "Restaurants", businesses: model.restaurants)
                    BusinessSectionView(sectionTitle: "Sights", businesses: model.sights)
                }
            }
        }else{
        ProgressView()
        }
    }
}

struct BusinessList_Previews: PreviewProvider {
    static var previews: some View {
        BusinessListView()
    }
}
