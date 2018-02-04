
//
//  DataModel.swift
//  bannsho
//
//  Created by 鈴木莉夏 on 2017/02/12.
//  Copyright © 2017年 鈴木莉夏. All rights reserved.
//

import Foundation
import RealmSwift



class DataModel: Object {
    @objc dynamic var name : String = "画像名"
    @objc dynamic var image = Data()
    @objc dynamic var folderName: String = "所属"
    @objc dynamic var id:Int = 0
    @objc dynamic var reimage = Data()
}
