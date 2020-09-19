	//
	//  HomeView.swift
	//  HomeScreanCreating1
	//
	//  Created by 寺山和也 on 2020/08/26.
	//  Copyright © 2020 寺山和也. All rights reserved.
	//
	
	import SwiftUI
	
	struct HomeView: View {
		@ObservedObject var appSettingStr:AppSettingStructure
		@Environment(\.managedObjectContext) var viewContext

		var applications: FetchedResults<Application>
		@Binding var textR:Double//=UserDefaults.standard.double(forKey: "textR")
		@Binding var textG:Double//=UserDefaults.standard.double(forKey: "textG")
		@Binding var textB:Double//=UserDefaults.standard.double(forKey: "textB")
		@Binding var textO:Double//=UserDefaults.standard.double(forKey: "textO")
		@Binding var imageO:Double//=UserDefaults.standard.double(forKey: "imageO")
		
		var body: some View {
			NavigationView{
				ZStack {
					//				Image("homeImage")
					//					.resizable()
					//					.scaleEffect(1.2)
					VStack {
						List{
							//1行4マスで6行分表示する
							ForEach(applications, id: \.id){ application in
								//1行４マス分にする
								//                    if self.judgeRowLimitNum(num: columCounter) {
								//                        HStack{
								//                            ForEach(0..<4){rowItem in
								//					HStack{
								AppView(app: application, appSettingStr: self.appSettingStr, textR: self.$textR, textG: self.$textG, textB: self.$textB, textO: self.$textO, imageO: self.$imageO
								)
									.padding(.horizontal)
								//					}
								//                            }
								//                        }
								//                        .padding(.bottom, 5)
								//                    }
								//						columCounter++
							}
						}
						//					Spacer()
						//					//画面下部のDockっぽい画面描写
						//					DockView(dockApps: dock, appSettingStr: self.appSettingStr)
					}
				}
				.onAppear(perform: {
//					let userDefaults = UserDefaults.standard
//					userDefaults.synchronize()
//					self.textR=self.appSettingStr.textR
//					self.textG=self.appSettingStr.textG
//					self.textB=self.appSettingStr.textB
//					self.textO=self.appSettingStr.textO
//					self.imageO=self.appSettingStr.imageO
				})
					.navigationBarItems(
						leading: NavigationLink(destination: OwnAppScreanView(textR: self.$textR, textG: self.$textG, textB: self.$textB, textO: self.$textO, imageO: self.$imageO), label: {Image(systemName: "gear")}),
						trailing: NavigationLink(destination: shortCutAdditionEditor(shortcutName: "", URLscheme: ""), label: {Image(systemName: "plus.square.fill")}))
					.navigationBarTitle("test Title", displayMode: .inline)
			}
		}
		
		
		func judgeRowLimitNum(num:Int)->Bool{
			//CGFloatにして計算時間を短縮
			let checknum:CGFloat=CGFloat(num%4)
			return checknum==CGFloat(0) ? true:false
		}
	}
	
	struct HomeView_Previews: PreviewProvider {
		static var previews: some View {
			ContentView(appSettingStr: AppSettingStructure(), textR:1.0, textG:1.0, textB:1.0, textO:1.0, imageO:1.0)
		}
	}
	
	func makeApps() -> [AppStruct] {
		var tempApps:[AppStruct]=[]
		
		tempApps.append(AppStruct(id: 0, appName: "HomeScreen", appIcon: "HomeScrean", urlScheme: "HomeScrean"))
		
		for x in 1...24 {
			if x<20 {
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
			}else{
				tempApps.append(AppStruct(id: x, appName: "", appIcon: "", urlScheme: ""))
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
	
