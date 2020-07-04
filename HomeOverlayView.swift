//
//  HomeOverlayView.swift
//  HomeScreanCreating1
//
//  Created by 寺山和也 on 2020/07/02.
//  Copyright © 2020 寺山和也. All rights reserved.
//

import SwiftUI

struct HomeOverlayView: View {
	@State var showAlert=false
	//アイコン長押しに表示される編集ボタン
	@Binding var editor:Bool
	
    var body: some View {
		Button(action: {
			print("ばつボタンの押下")
			self.showAlert.toggle()
		}) {
			Image(systemName: "multiply.circle")
				.resizable()
				.frame(width: 30, height: 30)
				.background(Color.white)
				.foregroundColor(.black)
				.clipShape(Circle())
		}
		.transition(.slide)
		.alert(isPresented: $showAlert){
			Alert(title: Text("確認"),
				  message: Text("このショートカットを削除しますか?"),
				  primaryButton: .destructive(Text("削除"), action: {
					//削除時はCoredateのデータから削除して、編集ボタンを非表示にする
					self.editor.toggle()
					
				}),
				  secondaryButton: .cancel(Text("キャンセル"), action: {
					//キャンセル時は編集ボタンを非表示にする
					self.editor.toggle()
				}))
		}
    }
}

struct HomeOverlayView_Previews: PreviewProvider {
    static var previews: some View {
		HomeOverlayView(editor: .constant(true))
		.previewLayout(.fixed(width: 30, height: 30))
    }
}
