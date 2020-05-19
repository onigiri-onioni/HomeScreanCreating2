//
//  ContentView.swift
//  HomeScreanCreating1
//
//  Created by 寺山和也 on 2020/05/16.
//  Copyright © 2020 寺山和也. All rights reserved.
//

import SwiftUI

var apps:[AppStruct] = makeApps()
var dock:[AppStruct] = makeDockApps()
var appViewRow:Int=0

struct ContentView: View {
    
    var body: some View {
        ZStack {
            Image("homeImage")
                .resizable()
                .scaleEffect(1.2)
            VStack {
                //1行4マスで6行分表示する
                ForEach(0..<24){ item in
                    //1行４マス分にする
                    if self.judgeRowLimitNum(num: item) {
                        HStack{
                            ForEach(0..<4){rowItem in
                                AppView(app: apps[item + rowItem])
                                    .padding(.horizontal)
                            }
                        }
                        .padding(.bottom, 5)
                    }
                }
                Spacer()
                //画面下部のDockっぽい画面描写
                DockView(dockApps: dock)
            }
        }
    }
    
    func judgeRowLimitNum(num:Int)->Bool{
        //CGFloatにして計算時間を短縮
        let checknum:CGFloat=CGFloat(num%4)
        return checknum==CGFloat(0) ? true:false
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

func makeApps() -> [AppStruct] {
    var tempApps:[AppStruct]=[]
    
    for x in 0...24 {
        //CGFloatでないと計算時間がかかる
        switch CGFloat(x%4){
        case 0:
            tempApps.append(AppStruct(id: x, appName: "Twitter"+String(x), appIcon: "Twitter", urlScheme: "twitter://"))
        case 1:
            tempApps.append(AppStruct(id: x, appName: "Music"+String(x), appIcon: "music", urlScheme: "music://"))
        case 2:
            tempApps.append(AppStruct(id: x, appName: ""+String(x), appIcon: "", urlScheme: ""))
        case 3:
            tempApps.append(AppStruct(id: x, appName: "Trello"+String(x), appIcon: "Trello", urlScheme: "trello:"))
        default: break
        }
    }
    
    return tempApps
}

func makeDockApps()->[AppStruct]{
    var tempDockApps:[AppStruct]=[]
    
    tempDockApps.append(AppStruct(id: 1, appName: "Twitter", appIcon: "Twitter", urlScheme: "twitter://"))
    tempDockApps.append(AppStruct(id: 2, appName: "safari", appIcon: "safari", urlScheme: "x-web-search://"))
    tempDockApps.append(AppStruct(id: 3, appName: "", appIcon: "", urlScheme: ""))
    tempDockApps.append(AppStruct(id: 4, appName: "Trello", appIcon: "Trello", urlScheme: "trello:"))
    
    return tempDockApps
}

