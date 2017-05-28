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
    
    
    @IBOutlet weak var imageView2: UIImageView!
    @IBOutlet weak var imageView3: UIImageView!
    
    @IBOutlet weak var imageView1: UIImageView!
    let saveData: UserDefaults = UserDefaults.standard
    
    var numberData : Int = 0
    
    @IBOutlet weak var imageview: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib
        saveData.register(defaults: ["number" : 0])
        
        if saveData.object(forKey: "number") != nil{
            numberData = saveData.object(forKey: "number") as! Int
        }
        
        var image1 : NSData = NSData()
        //var image2 : NSData!
        //var image3 : NSData!
        
        
        
        //image2 = saveData.object(forKey: "2") as? NSData
        //image3 = saveData.object(forKey: "3") as? NSData
        
        var UIImage1 : UIImage!
        //        var UIImage2 : UIImage!
        //        var UIImage3 : UIImage!
        
        if numberData != 0{
            
            //image1 = (saveData.object(forKey: "1") as? NSData)!
            //UIImage1 = nsDataToImage(nsData: image1)
            //imageView1.image = UIImage1
            
        }
        
        
        
        //UIImage2 = nsDataToImage(nsData: image2)
        //UIImage3 = nsDataToImage(nsData: image3)
        
        //imageView2.image = UIImage2
        //imageView3.image = UIImage3
        
        
        
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
        let pickedImage : UIImage = (info[UIImagePickerControllerOriginalImage] as? UIImage)!
        //
        //        //numberDataを取得する
        //        if saveData.object(forKey: "number") != nil{
        //            numberData = saveData.object(forKey: "number") as! Int
        //        }
        //        //numberDataに1足したものを上書きする
        //        numberData = numberData + 1
        //        print(numberData)
        //
        //
        //
        //        //NSDataにpickedImageを保存
        //        saveData.set(imageToNSData(image: pickedImage!), forKey: String(numberData))
        //        saveData.synchronize()
        //
        //
        //
        //        //numberDataを保存
        //        saveData.set(numberData, forKey: "number")
        //        saveData.synchronize()
        
        
        
        // print(getdate)
        
        
        //閉じる処理
        imagePicker.dismiss(animated: true, completion: nil)
        
        let alert: UIAlertController = UIAlertController(title: "保存", message: "メモの保存が完了しました", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {action in
            self.navigationController!.popViewController(animated: true)
            NSLog("OKボタンが押されました")
            
            
            
            if let textFields = alert.textFields{
                let textField1 = textFields[0]
                let textField2 = textFields[1]
                print(textField1.text!)
                print(textField2.text!)
                
                let realm = try! Realm()
                
                
               
                
                
                
                let dataModel = DataModel()
                
                dataModel.name = textField1.text!
                dataModel.image = UIImageJPEGRepresentation(pickedImage,0.8)! as NSData
                dataModel.folderName = textField2.text!
                
                
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
                
                
                
                //gazou
                let data =  UIImageJPEGRepresentation(pickedImage,0.8)! as NSData as Data
                let image = UIImage(data:data)
                self.imageview.image = image
            }
            
        }))
        
        //テキストフィールド
        alert.addTextField(configurationHandler: {(textField) -> Void in
            textField.placeholder = "画像名"
        })
        
        alert.addTextField(configurationHandler: {(textField) -> Void in
            textField.placeholder = "フォルダ名"
        })
        
        
        
        //        var table = UITableView()
        //        table.frame = CGRect(x:0,y:0,width:view.bounds.width*0.85,height:150)
        //        table.dataSource = self
        //        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        //alert.view.addSubview(table)
        
        
        
        present(alert, animated: true, completion: nil)
        
        
        
    }
    
    
    func imageToNSData(image: UIImage) -> NSData! {
        
        return UIImagePNGRepresentation(image) as NSData!
    }
    
    func nsDataToImage(nsData: NSData) -> UIImage! {
        
        return UIImage(data: nsData as Data)
    }
    
    
    
    //    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    //        return 1
    //    }
    //
    //    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    //
    //        // 再利用するCellを取得する.
    //         let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell")! as UITableViewCell
    //        
    //        // Cellに値を設定する.
    //        cell.textLabel!.text = "@@@@"
    //        
    //        return cell
    //    }
    //    
    
    
    
    
    
}

