//
//  AppStructure.swift
//  HomeScreanCreating1
//
//  Created by 寺山和也 on 2020/05/16.
//  Copyright © 2020 寺山和也. All rights reserved.
//

import Foundation

struct AppStruct:Identifiable {
    var id:Int
    var appName:String
    var appIcon:String
    var urlScheme:String
    
    //追加するアプリをリストに追加する
    func addAppInList(app:AppStruct, apps:[AppStruct]) -> [AppStruct] {
        var appList:[AppStruct]=apps
        appList.append(app)
        return appList
    }
}



