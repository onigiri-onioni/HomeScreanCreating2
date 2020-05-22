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
    @Published var textR:Double=0.0
    @Published var textG:Double=0.0
    @Published var textB:Double=0.0
    @Published var textO:Double=1.0
    //アプリアイコンの透過度
    @Published var imageO:Double=1.0
    
}
