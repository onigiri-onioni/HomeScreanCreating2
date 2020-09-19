//
//  ContentView.swift
//  HomeScreanCreating1
//
//  Created by 寺山和也 on 2020/05/16.
//  Copyright © 2020 寺山和也. All rights reserved.
//

import SwiftUI

var appViewRow:Int=0

struct ContentView: View {
	@State var appSettingStr:AppSettingStructure

	// Get the managed object context from the shared persistent container.
	let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
	@Environment(\.managedObjectContext) var viewContext
	@FetchRequest(
		sortDescriptors: [NSSortDescriptor(keyPath: \Application.sortOrder, ascending: true)],
		animation: .default)
	var applications: FetchedResults<Application>
	
	@State var textR:Double=UserDefaults.standard.double(forKey: "textR")
	@State var textG:Double=UserDefaults.standard.double(forKey: "textG")
	@State var textB:Double=UserDefaults.standard.double(forKey: "textB")
	@State var textO:Double=UserDefaults.standard.double(forKey: "textO")
	@State var imageO:Double=UserDefaults.standard.double(forKey: "imageO")
	
	var body: some View {
		HomeView(appSettingStr: appSettingStr, applications: applications, textR: $textR, textG: $textG, textB: $textB, textO: $textO, imageO: $imageO).environment(\.managedObjectContext, context)
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView(appSettingStr: AppSettingStructure())
	}
}
