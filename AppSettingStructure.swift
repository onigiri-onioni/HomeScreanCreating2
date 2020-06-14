//
//  AppSettingStructure.swift
//  HomeScreanCreating1
//
//  Created by 寺山和也 on 2020/05/22.
//  Copyright © 2020 寺山和也. All rights reserved.
//

import Foundation

class AppSettingStructure: ObservableObject {
    //初期値
    //アプリ名文字色RGB,opacity
    @Published var textR:Double=UserDefaults.standard.double(forKey: "textR")
    @Published var textG:Double=UserDefaults.standard.double(forKey: "textG")
    @Published var textB:Double=UserDefaults.standard.double(forKey: "textB")
    @Published var textO:Double=UserDefaults.standard.double(forKey: "textO")
    //アプリアイコンの透過度
    @Published var imageO:Double=UserDefaults.standard.double(forKey: "imageO")
    
}
