//  BusinessRowView.swift
//  Beacon

//  Created by Dhruv Gupta on 21/06/22.


import SwiftUI

struct BusinessRowView: View {
    @ObservedObject var business:Business
    
    var body: some View {
        HStack{
            
            // Image
            let uiImage = UIImage(data: business.imageData ?? Data())
            Image(uiImage: uiImage ?? UIImage())
                .resizable()
                .frame(width: 58, height: 58)
                .cornerRadius(10)
            
            // Name and distance
            VStack(alignment: .leading){
                Text(business.name!)
                Text(String(format: "%.2f kms away", (business.distance ?? 0)/1000))
                    .font(.caption)
            }
            Spacer()
            
            // Star rating & no. of reviews
            VStack(alignment: .leading){
                Image("regular_\(business.rating ?? 0.0)")
                Text("\(business.reviewCount ?? 0) reviews")
                    .font(.caption)
                
            }
        }
    }
}
