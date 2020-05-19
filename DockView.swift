//
//  DockView.swift
//  HomeScreanCreating1
//
//  Created by 寺山和也 on 2020/05/16.
//  Copyright © 2020 寺山和也. All rights reserved.
//

import SwiftUI

struct DockView: View {
    var dockApps:[AppStruct]
    let urlOpener = UIApplication.shared
    
    var body: some View {
        
        ZStack {
            RoundedRectangle(cornerRadius: 0)
                .foregroundColor(Color(.displayP3, red: 1, green: 1, blue: 1, opacity: 0.75))
                .frame(width: 400, height: 120)
            HStack {
                AppView(app: dockApps[0])
                    .padding(.horizontal)
                AppView(app: dockApps[1])
                    .padding(.horizontal)
                AppView(app: dockApps[2])
                    .padding(.horizontal)
                AppView(app: dockApps[3])
                    .padding(.horizontal)
            }
        }
    }
}

struct DockView_Previews: PreviewProvider {
    static var previews: some View {
        DockView(dockApps: makeDockApps())
            .previewLayout(.fixed(width: 400, height: 120))
    }
}
