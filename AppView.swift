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
	@State var textR:Double=UserDefaults.standard.double(forKey: "textR")
	@State var textG:Double=UserDefaults.standard.double(forKey: "textG")
	@State var textB:Double=UserDefaults.standard.double(forKey: "textB")
	@State var textO:Double=UserDefaults.standard.double(forKey: "textO")
	@State var imageO:Double=UserDefaults.standard.double(forKey: "imageO")
	@Environment(\.managedObjectContext) var viewContext
	
	//アイコン長押しに表示される編集ボタン
	@State var editor = false
	
	var body: some View {
		
		ZStack{
			Image(app.appIcon)
				.resizable()
				.frame(width: 50, height: 50, alignment: .center)
				.clipShape(RoundedRectangle(cornerRadius: 10.5))
				.offset(x: 0, y: -13)
				.opacity(appSettingStr.imageO)
			VStack {
				Image(app.appIcon)
					.resizable()
					.frame(width: 50, height: 50, alignment: .center)
					.clipShape(RoundedRectangle(cornerRadius: 10))
					.accentColor(Color( red: 0.0, green: 0.0, blue: 0.0, opacity: 0.0))
					.sheet(isPresented: $isHomeScreenView, onDismiss: {
						//OwnAppScreanView()のSheetが閉じられた際に実行する処理(Coredataへの設定値保存)
						self.appSettingStr.textR=self.textR
						self.appSettingStr.textG=self.textG
						self.appSettingStr.textB=self.textB
						self.appSettingStr.textO=self.textO
						self.appSettingStr.imageO=self.imageO
						UserDefaults.standard.synchronize()
					}) {
						//sheetを開いた先の画面指定
						OwnAppScreanView(textR: self.$textR, textG: self.$textG, textB: self.$textB, textO: self.$textO, imageO: self.$imageO)
						.environment(\.managedObjectContext, self.viewContext)
					}
					.gesture(
						//HomeOverlayViewの表示
						LongPressGesture(minimumDuration: 0.5, maximumDistance: 1)
							.onEnded({_ in
								self.editor.toggle()
							})
					)
					.gesture(
						//ショートカットの実行
						LongPressGesture(minimumDuration: 0, maximumDistance: 0.5)
							.onEnded({_ in
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
							})
					)
				Text(app.appName)
					.font(.footnote)
					.foregroundColor(Color(red: self.appSettingStr.textR, green: self.appSettingStr.textG, blue: self.appSettingStr.textB, opacity: self.appSettingStr.textO))
					.lineLimit(1)
					.frame(width: 50, height: 20, alignment: .center)
			}
			.onLongPressGesture(minimumDuration: 0.5, maximumDistance: 10, perform: {
				self.editor.toggle()
			})
			if (editor && self.app.id != 0 && !self.app.appName.isEmpty) {
				HomeOverlayView(editor: $editor)
					.offset(x: -25, y: -35)
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

