//
//  AddViewController.swift
//  bannsho
//
//  Created by 鈴木莉夏 on 2017/10/29.
//  Copyright © 2017年 鈴木莉夏. All rights reserved.
//

import UIKit
import RealmSwift

class AddViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate{
    @IBOutlet weak var imagetaken: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var folderNamePickerView: UIPickerView!
    
    @IBOutlet weak var folderNameTextField: UITextField!
    @IBOutlet weak var save: UIBarButtonItem!
    
    var receive :UIImage!
    
   
    var list = ["アイス" , "じゃがりこ" , "ジャガビー", "チョコレート効果"]
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        folderNamePickerView.dataSource = self
        folderNamePickerView.delegate = self
        
         imagetaken.image = receive
     
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ folderNamePickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return list.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return list[row]
    }
    
    @IBAction func saving(_ sender: Any) {
        
        
  //11月12日　最後の変更点
         let realm = try! Realm()
         let dataModel = DataModel()
        
        let result = realm.objects(DataModel).sorted(byKeyPath: "id", ascending: true).last
        
        if result?.id == nil{
            
            dataModel.id = 0
        }else{
            dataModel.id = (result?.id)! + 1
        }
        
        print("ID:" + String(describing: dataModel.id))
        //idと同様に名前なども書く：基本；datamodel.名前　= "aaa"　↩︎dataModel. ex.folderName = textField.text (次回)
        dataModel.name = name.text!
        let pickedImage = receive
        dataModel.image = UIImageJPEGRepresentation(pickedImage!,0.8)! as NSData
        dataModel.reimage = UIImageJPEGRepresentation(self.resizeImage(src: pickedImage!), 0.0)! as NSData
        dataModel.folderName =  folderNameTextField.text!
        try! realm.write {
            realm.add(dataModel)
            
        }


        
        
        
       /* try! realm.write {
            realm.add(folderNameTextField.text)
             //メソッド持っている変数.someMethod(別ラベル:へん数, 引数のラベル: 実際の変数 )
        }
        */
        
       
        
         
       /*  dataModel.name = name.text!
         dataModel.image = UIImageJPEGRepresentation(pickedImage,0.8)! as NSData
         dataModel.reimage = UIImageJPEGRepresentation(self.resizeImage(src: pickedImage), 0.0)! as NSData
         
         let result = realm.objects(DataModel).sorted(byKeyPath: "id", ascending: true).last
         
         if result?.id == nil{
         
         dataModel.id = 0
         }else{
         dataModel.id = (result?.id)! + 1
         }
         
         print("ID:" + String(describing: dataModel.id))
         
         try! realm.write {
         realm.add(dataModel)
         
         }
         
         */
        
        
    }
    
    func resizeImage(src: UIImage) -> UIImage {
        
        var resizedSize : CGSize!
        let maxLongSide : CGFloat = 75
        
        // リサイズが必要か？
        let ss = src.size
        if maxLongSide == 0 || ( ss.width <= maxLongSide && ss.height <= maxLongSide ) {
            resizedSize = ss
            return src
        }
        
        // TODO: リサイズ回りの処理を切りだし
        
        // リサイズ後のサイズを計算
        let ax = ss.width / maxLongSide
        let ay = ss.height / maxLongSide
        let ar = ax > ay ? ax : ay
        let re = CGRect(x: 0, y: 0, width: ss.width / ar, height: ss.height / ar)
        
        // リサイズ
        UIGraphicsBeginImageContext(re.size)
        src.draw(in: re)
        let dst = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        resizedSize = dst?.size
        
        return dst!
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
/*
 // MARK: - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 // Get the new view controller using segue.destinationViewController.
 // Pass the selected object to the new view controller.
 }
 */


