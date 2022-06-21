//  BusinessHeaderView.swift
//  Beacon

//  Created by Dhruv Gupta on 21/06/22.

import SwiftUI

struct BusinessHeaderView: View {
    var title: String
    
    var body: some View {
        ZStack(alignment: .leading){
            Rectangle()
                .foregroundColor(.white)
            Text(title)
                .font(.headline)
        }
            
    }
}

