//  BusinessDetailView.swift
//  Beacon

//  Created by Dhruv Gupta on 21/06/22.

import SwiftUI

struct BusinessDetailView: View {
    var business: Business
    
    var body: some View {
        VStack(alignment: .leading){
            
            // Cover Image
            VStack(alignment: .leading, spacing: 0){
                GeometryReader{geometry in
                    let uiImage = UIImage(data: business.imageData ?? Data())
                    Image(uiImage: uiImage ?? UIImage())
                        .resizable()
                        .scaledToFill()
                        .frame(width: geometry.size.width, height: geometry.size.height, alignment: .top)
                        .clipped()
                }.ignoresSafeArea(.all, edges: .top)
                
                // Open or closed - horizontal bar
                ZStack(alignment: .leading){
                    Rectangle()
                        .foregroundColor(business.isClosed! ? .gray: .blue)
                        .frame(height: 42)
                    Text(business.isClosed! ? "Closed": "Open")
                        .bold()
                        .foregroundColor(.white)
                        .padding(.leading)
                }
            }
           
            
            // Using group container to get around the limit of having 10 items in a container; here, VStack.
            Group{
                
                // Business Name
                Text(business.name!).font(.largeTitle).padding(.horizontal)
                
                // Looping through each address line
                if business.location?.displayAddress != nil{
                    ForEach(business.location!.displayAddress!, id: \.self){ addressElement in
                        Text(addressElement).padding(.horizontal)
                    }
                }
                
                // Rating
                Image("regular_\(business.rating ?? 0.0)").padding(.leading)
                Text("Based on \(business.reviewCount ?? 0) reviews").padding(.leading)
                
                Divider()
                
                //Phone
                HStack{
                    Text("Phone: ")
                        .bold()
                    Text(business.displayPhone ?? "")
                    Spacer()
                    Link(destination: URL(string: "tel:\(business.phone ?? "")")!) {
                        Image(systemName: "phone.and.waveform.fill")
                    }
                }.padding(.horizontal)
                    
                Divider()
                
                // Website
                HStack{
                    Text("Website: ")
                        .bold()
                    Text(business.url ?? "").lineLimit(1)
                    Spacer()
                    Link(destination: URL(string: "\(business.url ?? "")")!) {
                        Image(systemName: "globe.badge.chevron.backward")
                    }
                }.padding()
                
                // Directions Button
                    Button {
                        // TODO: - Directions Task
                    } label: {
                        ZStack{
                            Rectangle()
                                .frame(height:48)
                                .foregroundColor(.blue)
                                .cornerRadius(10)
                            Text("Get Directions")
                                .foregroundColor(.white)
                                .bold()
                        }.padding(.horizontal)
                }
            }
        }
    }
}


