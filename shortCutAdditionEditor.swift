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
	@Environment(\.presentationMode) var presentationMode
	@Environment(\.managedObjectContext) var viewContext
	@State var shortcutName:String
	@State var URLscheme:String
	
	//coredataへの保存フォーマットチェックフラグ
	@State var coredataFormatFlg: Bool=false
	//coredataへの保存アラートフラグ
	@State var alertFlg:Bool = false
	//coredataへの保存が正常完了するときのアラート
	@State var showAlertDone=false
	//coredataへの保存ができなかったときのアラート
	@State var showAlertFault=false
	//保存できない場合のメッセージ
	@State var alertMessage:String = ""
	
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
					//登録処理//
					//登録フォーマットのチェック
					self.coredataFormatFlg = checkRegistFormat(shortcutName: self.shortcutName, URLscheme: self.URLscheme, imageSelected: self.imageSelected)
					
					if self.coredataFormatFlg {
						//登録フォーマットに沿っていた場合の処理
						//新規id(と共にsortOrder)を取得するコードが必要
						
						Application.create(in: self.viewContext, appName: self.shortcutName, urlScheme: self.URLscheme, appIcon: self.imageSelected, sortOrder: 100)
						//ダイアログの表示
						self.showAlertDone.toggle()
						self.alertMessage = "登録が完了しました"
					} else {
						//登録フォーマットに沿っていなかった場合の処理
						self.showAlertFault.toggle()
						self.alertMessage = judgeInputData(shortcutName: self.shortcutName, URLscheme: self.URLscheme, imageSelected: self.imageSelected)
						
					}
					self.alertFlg.toggle()
				}) {
					Text("ショートカットを登録")
						.font(.title)
				}
					.padding(.all)
					.overlay(
						RoundedRectangle(cornerRadius: 15)
							.stroke(Color.blue, lineWidth: 2)
					)
					.alert(isPresented: $alertFlg){
						//登録完了のポップアップ表示
						Alert(title: Text("メッセージ"), message: Text(alertMessage), dismissButton: .default(Text("OK"), action: {
							if self.showAlertDone {
								print("done")
								self.presentationMode.wrappedValue.dismiss()
							}else if self.showAlertFault {
								//何もしない
								print("nothing")
							}
						}))
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

func judgeInputData(shortcutName: String, URLscheme:String, imageSelected:UIImage?) -> String {
	var alertText:String = ""
	if shortcutName.isEmpty {
		alertText += "ショートカット名が入力されていません\n"
	}
	if URLscheme.isEmpty {
		alertText += "ショートカットURLが入力されていません\n"
	}
	if imageSelected == nil {
		alertText += "アイコン画像が選択されていません"
	}
	return alertText
}
