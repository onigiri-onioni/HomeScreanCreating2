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
    @State var isHomeScreenView:Bool = false
    @ObservedObject var appSettingStr: AppSettingStructure
    @State var textR:Double=0.0
    @State var textG:Double=0.0
    @State var textB:Double=0.0
    @State var textO:Double=1.0
    @State var imageO:Double=1.0
    
    
    var body: some View {
        
        ZStack{
            Image(app.appIcon)
                .resizable()
                .frame(width: 50, height: 50, alignment: .center)
                .clipShape(RoundedRectangle(cornerRadius: 10.5))
                .offset(x: 0, y: -13)
                .opacity(appSettingStr.imageO)
            VStack {
                Button(action: {
                    print("test")
                    //自アプリの場合は、アプリを開かず、設定画面へ遷移する
                    if self.app.id==0{
                        self.isHomeScreenView=true
                    }
                    //アプリが設定されていない場合はボタンを押しても無反応にする
                    else if !self.app.urlScheme.isEmpty {
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
                        
                    }.accentColor(Color( red: 0.0, green: 0.0, blue: 0.0, opacity: 0.0))
                        .sheet(isPresented: $isHomeScreenView, onDismiss: {
                            ////OwnAppScreanView()のSheetが閉じられた際に実行する処理(Coredataへの設定値保存)
                            self.appSettingStr.textR=self.textR
                            self.appSettingStr.textG=self.textG
                            self.appSettingStr.textB=self.textB
                            self.appSettingStr.textO=self.textO
                            self.appSettingStr.imageO=self.imageO
                            print("textR:"+String(self.appSettingStr.textR))
                            print("textG:"+String(self.appSettingStr.textG))
                            print("textB:"+String(self.appSettingStr.textB))
                            print("textO:"+String(self.appSettingStr.textO))
                            print("imageO:"+String(self.appSettingStr.imageO))
                        }) {
                            //sheetを開いた先の画面指定
                            OwnAppScreanView(appSettingStr : self.appSettingStr, textR: self.$textR, textG: self.$textG, textB: self.$textB, textO: self.$textO, imageO: self.$imageO)
                    }
                }
                Text(app.appName)
                    .font(.footnote)
                    .foregroundColor(Color(red: self.appSettingStr.textR, green: self.appSettingStr.textG, blue: self.appSettingStr.textB, opacity: self.appSettingStr.textO))
                    .lineLimit(1)
                    .frame(width: 50, height: 20, alignment: .center)
                
            }
        }
    }
}

struct AppView_Previews: PreviewProvider {
    static var previews: some View {
        AppView(app: AppStruct(id: 1, appName: "Twitter", appIcon: "Twitter", urlScheme: "twitter:"),  appSettingStr: AppSettingStructure()
        )
            .previewLayout(.fixed(width: 80, height: 80))
    }
}
