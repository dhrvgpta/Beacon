//  LaunchView.swift
//  Beacon

//  Created by Dhruv Gupta on 20/06/22.


import SwiftUI

struct LaunchView: View {
    @EnvironmentObject var model:ContentModel
    
    var body: some View {
        if model.authorizationState == .notDetermined{
            // If undetermined, we're gonna show OnboardingView
        }
        else if model.authorizationState == .denied{
            // If undetermined, we're gonna show DeniedView
        }
        else{
            // If approved, we're gonna show the HomeView
            BusinessHomeView()
        }
    }
}

struct LaunchView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchView()
    }
}
