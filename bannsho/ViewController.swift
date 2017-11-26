//
//  ViewController.swift
//  bannsho
//
//  Created by 鈴木莉夏 on 2016/11/20.
//  Copyright © 2016年 鈴木莉夏. All rights reserved.
//
//

import UIKit
import RealmSwift

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    //,UITableViewDataSource{
    let saveData: UserDefaults = UserDefaults.standard
    var numberData : Int = 0
    var  pickedImage : UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib
        saveData.register(defaults: ["number" : 0])
        
        if saveData.object(forKey: "number") != nil{
            numberData = saveData.object(forKey: "number") as! Int
        }
  
        var _ : UIImage!
        
        if numberData != 0{
        }
    
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func move(_ sender: Any) {
        
        performSegue(withIdentifier: "toMainView", sender: nil)
    }
    @IBAction func takePhoto(_ sender: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera){
            let picker = UIImagePickerController()
            picker.sourceType = UIImagePickerControllerSourceType.camera
            picker.allowsEditing = true
            picker.delegate = self
            
            self.present(picker, animated: true, completion: nil)
            
        }else{
            print("error")
        }
    }
    
    //　撮影が完了時した時に呼ばれる
    func imagePickerController(_ imagePicker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        //撮影した画像をUIImage型として取得しpickedImageに代入
        pickedImage = (info[UIImagePickerControllerOriginalImage] as? UIImage)!
       
        self.move2()
        
        // print(getdate)
        
        
        //閉じる処理
        imagePicker.dismiss(animated: true, completion: nil)
        
//        let alert: UIAlertController = UIAlertController(title: "保存", message: "メモの保存が完了しました", preferredStyle: .alert)
//        
//        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {action in
//            self.navigationController!.popViewController(animated: true)
//            NSLog("OKボタンが押されました")
//            
//            
//            
//            if let textFields = alert.textFields{
//                let textField1 = textFields[0]
//              
//                print(textField1.text!)
        
//                dataModel.name = textField1.text!
//                dataModel.image = UIImageJPEGRepresentation(pickedImage,0.8)! as NSData
//                dataModel.reimage = UIImageJPEGRepresentation(self.resizeImage(src: pickedImage), 0.0)! as NSData
/*      let result = realm.objects(DataModel).sorted(byKeyPath: "id", ascending: true).last
        
                if result?.id == nil{
                   dataModel.id = 0
                }else{
                    dataModel.id = (result?.id)! + 1
                }
 
                print("ID:" + String(describing: dataModel.id))
                try! realm.write {
                    realm.add(dataModel)
        
                }
//            }
//        }))
//        //テキストフィールド
//        alert.addTextField(configurationHandler: {(textField) -> Void in
//            textField.placeholder = "画像名"
//        })
//        //        var table = UITableView()
//        //        table.frame = CGRect(x:0,y:0,width:view.bounds.width*0.85,height:150)
//        //        table.dataSource = self
//        //        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
//        
//        //alert.view.addSubview(table)
//        
//        
//        
//        present(alert, animated: true, completion: nil)
//        
//        
//        
//    }
 */
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let addViewController:AddViewController = segue.destination as! AddViewController
        addViewController.receive = pickedImage
    }
    
    func move2(){
        performSegue(withIdentifier: "toAdd", sender: nil)
    }
    
    func imageToNSData(image: UIImage) -> NSData! {
        
        return UIImagePNGRepresentation(image) as NSData!
    }
    
    func nsDataToImage(nsData: NSData) -> UIImage! {
        
        return UIImage(data: nsData as Data)
    }
    /// イメージのサイズを変更
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
    
}


