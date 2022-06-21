//  BusinessHomeView.swift
//  Beacon

//  Created by Dhruv Gupta on 21/06/22.


import SwiftUI

struct BusinessHomeView: View {
    @EnvironmentObject var model: ContentModel
    @State var showMapView = false
    
    var body: some View {
        if model.restaurants.count != 0 || model.sights.count != 0 {
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
                    BusinessMapView().ignoresSafeArea()
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
