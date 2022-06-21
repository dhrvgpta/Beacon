//  BusinessHomeView.swift
//  Beacon

//  Created by Dhruv Gupta on 21/06/22.


import SwiftUI

struct BusinessHomeView: View {
    @EnvironmentObject var model: ContentModel
    @State var showMapView = false
    @State var selectedBusiness: Business?
    
    var body: some View {
        if model.restaurants.count != 0 && model.sights.count != 0 {
            NavigationView{
                if !showMapView{
                    // Show ListView
                    VStack(alignment: .leading){
                        HStack{
                            Image(systemName: "building.2.crop.circle.fill")
                            Text("Las Vegas")
                            Spacer()
                            Button(action: {
                                showMapView = true
                            }, label: {
                               Image(systemName: "map.circle.fill")
                            })
                           
                        }
                        Divider()
                        BusinessListView()
                    }.padding([.horizontal, .top])
                     .accentColor(.black)
                     .navigationBarHidden(true)
                }else{
                    ZStack(alignment: .top){
                        BusinessMapView(selectedBusiness: $selectedBusiness)
                            .ignoresSafeArea()
                            .sheet(item: $selectedBusiness) { business in
                                BusinessDetailView(business: business)
                            }
                        // The rounded rectangle over the MapView
                        ZStack{
                            Rectangle()
                                .foregroundColor(.white)
                                .cornerRadius(10)
                                .frame(height: 48)
                            HStack{
                                Image(systemName: "building.2.crop.circle.fill")
                                Text("Las Vegas")
                                Spacer()
                                Button(action: {
                                    showMapView = false
                                }, label: {
                                   Image(systemName: "list.bullet.circle.fill")
                                })
                            }.padding()
                        }.padding()
                    }
                    .navigationBarHidden(true)
                }
            }
        }else{

            // Still waiting for data, until show a spinner
            ProgressView()
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        BusinessHomeView()
    }
}
