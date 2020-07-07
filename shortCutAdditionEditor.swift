//
//  shortCutAdditionEditor.swift
//  HomeScreanCreating1
//
//  Created by 寺山和也 on 2020/06/23.
//  Copyright © 2020 寺山和也. All rights reserved.
//

import SwiftUI
import Combine
import UIKit

struct shortCutAdditionEditor: View {
	@Environment(\.managedObjectContext) var viewContext
	@State var shortcutName:String
	@State var URLscheme:String
	
	@State var showAlert=false
	
	@State var imageSelected: UIImage? = nil
	@State var showGetImageView = false
	
	var body: some View {
		ZStack{
			VStack {
				Spacer()
				VStack {
					HStack() {
						Text("ショートカット名")
							.padding(.horizontal)
						Spacer()
					}
					HStack {
						Spacer()
							.frame(width: 150.0)
						TextField("", text: $shortcutName)
							.textFieldStyle(RoundedBorderTextFieldStyle())
							.padding(.trailing)
					}
				}
				VStack {
					HStack {
						Text("ショートカットURL")
							.padding(.horizontal)
						Spacer()
					}
					HStack {
						Spacer()
							.frame(width: 150.0)
						TextField("", text: $URLscheme)
							.textFieldStyle(RoundedBorderTextFieldStyle())
							.padding(.trailing)
					}
				}
				VStack{
					HStack{
						Text("アイコン登録")
							.padding(.horizontal)
						Spacer()
					}
					HStack{
						Button(action: {
							self.showGetImageView.toggle()
						}) {
							VStack {
								Image(systemName: "camera")
									.resizable()
									.aspectRatio(contentMode: .fit)
									.frame(width: 30, height: 30)
								Text("アイコン登録")
							}
						}

//						imageSelected?.resizable()
//							.frame(width: 100, height: 100)
//							.clipShape(RoundedRectangle(cornerRadius: 10))
						if (imageSelected == nil) {
							Rectangle()
							.frame(width: 100, height: 100)
							.clipShape(RoundedRectangle(cornerRadius: 10))
						}else{
							Image(uiImage: imageSelected!)
							.resizable()
							.frame(width: 100, height: 100)
							.clipShape(RoundedRectangle(cornerRadius: 10))
						}
						
					}
				}
				Spacer()
				
				Button(action: {
					//登録処理
					//新規idを取得するコードが必要
					
					Application.create(in: self.viewContext, id: 100, appName: self.shortcutName, urlScheme: self.URLscheme, appIcon: self.imageSelected)
					//ダイアログの表示
					self.showAlert.toggle()
				}) {
					Text("ショートカットを登録")
						.font(.title)
				}
					.padding(.all)
					.overlay(
						RoundedRectangle(cornerRadius: 15)
							.stroke(Color.blue, lineWidth: 2)
					)
					.alert(isPresented: $showAlert){
						//登録フォーマットのチェック
						Alert(title: Text(setAlertText(shortcutName: shortcutName, URLscheme: URLscheme, imageSelected: imageSelected)))
					}
			}
		}
		.sheet(isPresented: $showGetImageView){
			ImagePickerView(image: self.$imageSelected)
		}
	}
}

struct shortCutAdditionEditor_Previews: PreviewProvider {
	static var previews: some View {
		shortCutAdditionEditor(shortcutName: "testName", URLscheme: "nothing")
	}
}


func setAlertText(shortcutName: String, URLscheme:String, imageSelected:UIImage?) -> String {
	let alertFlg: Bool = checkRegistFormat(shortcutName: shortcutName, URLscheme: URLscheme, imageSelected: imageSelected)
	if alertFlg {
		return "登録完了"
	}else {
		return "データが入力されていない\nフォーマットがあるため\n登録出来ませんでした"
	}
}

func checkRegistFormat(shortcutName: String, URLscheme:String, imageSelected:UIImage?) -> Bool {
	let shortcutNameFlg:Bool = shortcutName.isEmpty ? false : true
	let URLschemeFlg:Bool = URLscheme.isEmpty ? false : true
	let shortcutIconNameFlg:Bool = imageSelected==nil ? false : true
	
	return (shortcutNameFlg && URLschemeFlg && shortcutIconNameFlg) ? true : false
}
