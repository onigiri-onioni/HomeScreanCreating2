//
//  OwnAppScreanView.swift
//  HomeScreanCreating1
//
//  Created by 寺山和也 on 2020/05/20.
//  Copyright © 2020 寺山和也. All rights reserved.
//

import SwiftUI

struct OwnAppScreanView: View {
    @ObservedObject var appSettingStr:AppSettingStructure
    @Binding var textR:Double
    @Binding var textG:Double
    @Binding var textB:Double
    @Binding var textO:Double
    @Binding var imageO:Double
    
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
                        }
                        .foregroundColor(Color(red: textR, green: textG, blue: textB, opacity: textO))
                        HStack{
                            Circle()
                                .foregroundColor(.red)
                                .frame(width:20, height: 20)
                            Text(String(Int(textR * 255))).frame(width:40)
                            Slider(value: $textR, in:0...1).frame(width:200)
                        }
                        HStack{
                            Circle()
                                .frame(width:20, height: 20)
                                .foregroundColor(.green)
                            Text(String(Int(textG * 255))).frame(width:40)
                            Slider(value: $textG, in:0...1).frame(width:200)
                        }
                        HStack{
                            Circle()
                                .frame(width:20, height: 20)
                                .foregroundColor(.blue)
                            Text(String(Int(textB * 255))).frame(width:40)
                            Slider(value: $textB, in:0...1).frame(width:200)
                        }
                        HStack{
                            Circle()
                                .frame(width:20, height: 20)
                                .foregroundColor(.black)
                            Text(String(Int(textO * 255))).frame(width:40)
                            Slider(value: $textO, in:0...1).frame(width:200)
                        }
                    }
                    VStack(alignment: .center){
                        HStack{
                            Text("アイコン透過度")
                                .padding(.trailing,30)
                            Image("Twitter")
                                .resizable()
                                .frame(width: 80, height: 80, alignment: .center)
                                .opacity(imageO)
                        }
                        HStack{
                            Circle()
                                .frame(width:20, height: 20)
                                .foregroundColor(.black)
                            Text(String(Int(imageO * 255))).frame(width:40)
                            Slider(value: $imageO, in:0...1).frame(width:200)
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
        OwnAppScreanView(appSettingStr: AppSettingStructure(), textR: .constant(1.0), textG: .constant(1.0), textB: .constant(1.0), textO: .constant(1.0), imageO: .constant(1.0))
    }
}

//func calcColorAndOpacity(numnum:Int)->Double{
//    //CGFloatにして計算時間を短縮
//    return Double(CGFloat(numnum%255))
//}
