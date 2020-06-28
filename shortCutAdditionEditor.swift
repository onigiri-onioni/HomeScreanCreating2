//
//  shortCutAdditionEditor.swift
//  HomeScreanCreating1
//
//  Created by 寺山和也 on 2020/06/23.
//  Copyright © 2020 寺山和也. All rights reserved.
//

import SwiftUI

struct shortCutAdditionEditor: View {
	@State var shortcutName:String
	@State var URLscheme:String
	@State var shortcutIconName:String
	
	@State var showAlert=false
	
	@State var imageSelected: Image? = nil
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
						
						imageSelected?.resizable()
							.frame(width: 100, height: 100)
							.clipShape(RoundedRectangle(cornerRadius: 10))
						
					}
				}
				Spacer()
				
				Button(action: {
					//登録処理
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
						Alert(title: Text("登録完了"))
					}
				
				Spacer()
			}
			
			if (showGetImageView) {
				GetImageView(shownBool: $showGetImageView, getImage: $imageSelected)
			}
		}
	}
}

struct shortCutAdditionEditor_Previews: PreviewProvider {
	static var previews: some View {
		shortCutAdditionEditor(shortcutName: "testName", URLscheme: "nothing", shortcutIconName: "nothing")
	}
}

//写真選択後
class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
	
	@Binding var showCoordinatorBool: Bool
	@Binding var coordinatorImage: Image?
	
	init(shownBool: Binding<Bool>, cordinatedImage: Binding<Image?>) {
		_showCoordinatorBool = shownBool
		_coordinatorImage = cordinatedImage
	}
	
	func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
		guard let gotImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
		coordinatorImage = Image(uiImage: gotImage)
		showCoordinatorBool = false
	}
	
	func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
		showCoordinatorBool = false
	}
}

//写真選択後の動作
struct GetImageView {
	
	@Binding var shownBool: Bool
	@Binding var getImage: Image?
	
	func makeCoordinator() -> Coordinator {
		return Coordinator(shownBool: $shownBool, cordinatedImage: $getImage)
	}
}

//「アイコン選択」時の挙動
extension GetImageView: UIViewControllerRepresentable {
	
	func makeUIViewController(context: UIViewControllerRepresentableContext<GetImageView>) -> UIImagePickerController {
		let picker = UIImagePickerController()
		picker.delegate = context.coordinator
		//コメントアウトを外せば写真ではなく、カメラが起動する
		// picker.sourceType = .camera
		return picker
	}
	
	func updateUIViewController(_ uiViewController: UIImagePickerController,context: UIViewControllerRepresentableContext<GetImageView>) {
	}
}

