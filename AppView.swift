//
//  AppView.swift
//  HomeScreanCreating1
//
//  Created by 寺山和也 on 2020/05/16.
//  Copyright © 2020 寺山和也. All rights reserved.
//

import SwiftUI


struct AppView: View {
    var app:AppStruct
    let urlOpener = UIApplication.shared
    
    var body: some View {
        
        ZStack{
            Image(app.appIcon)
                .resizable()
                .frame(width: 50, height: 50, alignment: .center)
                .clipShape(RoundedRectangle(cornerRadius: 10.5))
                .offset(x: 0, y: -13)
            Button(action: {
                print("test")
                //アプリが設定されていない場合はボタンを押しても無反応にする
                if !self.app.urlScheme.isEmpty {
                    let url=URL(string: self.app.urlScheme)
                    if self.urlOpener.canOpenURL(url!){
                        self.urlOpener.open(url!)
                    }
                }
            }) {
                VStack{
                    Image(app.appIcon)
                        .resizable()
                        .frame(width: 50, height: 50, alignment: .center)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    Text(app.appName)
                        .font(.footnote)
                        .foregroundColor(Color(red: 0.0, green: 0.0, blue: 0.0, opacity: 1))
                }.accentColor(.init(.displayP3, red: 1, green: 0, blue: 0, opacity: 0))
            }
        }
    }
}

struct AppView_Previews: PreviewProvider {
    static var previews: some View {
        AppView(app: AppStruct(id: 1, appName: "Twitter", appIcon: "Twitter", urlScheme: "twitter:"))
            .previewLayout(.fixed(width: 80, height: 80))
    }
}
