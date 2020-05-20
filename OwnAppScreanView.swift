//
//  OwnAppScreanView.swift
//  HomeScreanCreating1
//
//  Created by 寺山和也 on 2020/05/20.
//  Copyright © 2020 寺山和也. All rights reserved.
//

import SwiftUI

struct OwnAppScreanView: View {
    //アプリ名文字色RGB,opacity
    @State var textR:Double=0
    @State var textG:Double=0
    @State var textB:Double=0
    @State var textO:Double=255
    //アプリアイコンの透過度
    @State var imageO:Double=255
    
    var body: some View {
        NavigationView{
            ScrollView {
                VStack(){
                    VStack(alignment: .center){
                        HStack{
                            Text("文字色設定")
                                .padding(.trailing,30)
                            Circle()
                                .frame(width:100, height: 100)
                                .padding()
                                .foregroundColor(Color(red: textR/255, green: textG/255, blue: textB/255, opacity: textO/255))
                        }
                        HStack{
                            Circle()
                                .foregroundColor(.red)
                                .frame(width:20, height: 20)
                            Text(String(Int(textR))).frame(width:40)
                            Slider(value: $textR, in:0...255).frame(width:200)
                        }
                        HStack{
                            Circle()
                                .frame(width:20, height: 20)
                                .foregroundColor(.green)
                            Text(String(Int(textG))).frame(width:40)
                            Slider(value: $textG, in:0...255).frame(width:200)
                        }
                        HStack{
                            Circle()
                                .frame(width:20, height: 20)
                                .foregroundColor(.blue)
                            Text(String(Int(textB))).frame(width:40)
                            Slider(value: $textB, in:0...255).frame(width:200)
                        }
                        HStack{
                            Circle()
                                .frame(width:20, height: 20)
                                .foregroundColor(.black)
                            Text(String(Int(textO))).frame(width:40)
                            Slider(value: $textO, in:0...255).frame(width:200)
                        }
                    }
                    VStack(alignment: .center){
                        HStack{
                            Text("アイコン透過度")
                                .padding(.trailing,30)
                            Image("Twitter")
                                .resizable()
                                .frame(width: 80, height: 80, alignment: .center)
                                .opacity(imageO/255)
                        }
                        HStack{
                            Circle()
                                .frame(width:20, height: 20)
                                .foregroundColor(.black)
                            Text(String(Int(imageO))).frame(width:40)
                            Slider(value: $imageO, in:0...255).frame(width:200)
                        }
                    }
                }
                .navigationBarItems(
                    leading: Text("設定画面")
                        .font(.largeTitle))
            }
        }
    }
}

struct OwnAppScreanView_Previews: PreviewProvider {
    static var previews: some View {
        OwnAppScreanView()
    }
}
