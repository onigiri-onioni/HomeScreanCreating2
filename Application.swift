//
//  Application.swift
//  HomeScreanCreating1
//
//  Created by 寺山和也 on 2020/07/05.
//  Copyright © 2020 寺山和也. All rights reserved.
//

import Foundation
import SwiftUI
import UIKit
import CoreData

extension Application{
	static func create(in managedObjectContext: NSManagedObjectContext, appName:String, urlScheme:String, appIcon:UIImage!, sortOrder: Int){
		let newApplication = self.init(context: managedObjectContext)
		
		//データベースに入れるデータの設定
		newApplication.id=UUID()
		newApplication.appName=appName
		newApplication.urlScheme=urlScheme
		newApplication.sortOrder=Int16(sortOrder)
		
		if(appIcon != nil){
			//UIImageの方向を確認
			var appIconOrientation:Int = 0
			switch appIcon.imageOrientation {
			case .down:
				appIconOrientation = 1
			case .left:
				appIconOrientation = 2
			case .right:
				appIconOrientation = 3
			case .upMirrored:
				appIconOrientation = 4
			case .downMirrored:
				appIconOrientation = 5
			case .leftMirrored:
				appIconOrientation = 6
			case .rightMirrored:
				appIconOrientation = 7
			default:
				appIconOrientation = 0
			}
			
			//UIImageをNSDataに変換
			let jpegAppIcon = appIcon.toJPEGData()
			newApplication.appIcon=jpegAppIcon
			newApplication.appIconOrientation=Int16(appIconOrientation)
		}

		do{
			try managedObjectContext.save()
			// path to application support
			print(NSSearchPathForDirectoriesInDomains(.applicationSupportDirectory, .userDomainMask, true).last!);

		}catch{
			let nserror = error as NSError
			fatalError("Unsolved Error.\n\(nserror), \(nserror.userInfo)")
//			NSLog("Unsolved Error.\n\(nserror), \(nserror.userInfo)")
		}
	}
}


// UIImage拡張(データ)
public extension UIImage {
	// イメージ→PNGデータに変換する
	//
	// - Returns: 変換後のPNGデータ
	func toPNGData() -> Data {guard let data = self.pngData() else {
		print("イメージをPNGデータに変換できませんでした。")
		return Data()
		}
		
		return data
	}
	
	// イメージ→JPEGデータに変換する
	//
	// - Returns: 変換後のJPEGデータ
	func toJPEGData() -> Data {
		guard let data = self.jpegData(compressionQuality: 1.0) else {
			print("イメージをJPEGデータに変換できませんでした。")
			return Data()
		}
		
		return data
	}
	
}

/// Data拡張(イメージ)
public extension Data {

    // MARK: Public Methods

    /// データ→イメージに変換する
    ///
    /// - Returns: 変換後のイメージ
	func toImage() -> UIImage {
        guard let image = UIImage(data: self) else {
            print("データをイメージに変換できませんでした。")
            return UIImage()
        }

        return image
    }

}
