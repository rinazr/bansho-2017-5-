//
//  ShowImageViewController.swift
//  bannsho
//
//  Created by 鈴木莉夏 on 2017/05/14.
//  Copyright © 2017年 鈴木莉夏. All rights reserved.
//

import UIKit
import RealmSwift

class ShowImageViewController: UIViewController {
    static var image : UIImage!
    static var name : String!
    static var id : Int!
    let realm = try! Realm()
    
    @IBOutlet weak var imageview: UIImageView!
    
    @IBOutlet weak var navigationBar: UINavigationBar!
    
    @IBOutlet weak var folder: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        if ShowImageViewController.name == ""{
            self.navigationItem.title = "名称未設定"
            
        }else{
            self.navigationItem.title = ShowImageViewController.name;
        }
        imageview.image = ShowImageViewController.image
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func shareImage(_ sender: UIBarButtonItem) {
        let shareImage = ShowImageViewController.image
        let activityItems: [Any]  = [shareImage]
        let activityViewController = UIActivityViewController(activityItems:activityItems , applicationActivities: nil)
        let excludedActivityTypes = [UIActivityType.postToWeibo, .saveToCameraRoll , .print]
        activityViewController.excludedActivityTypes = excludedActivityTypes
        present(activityViewController, animated: true, completion: nil)
        
    }
    
    @IBAction func edit(_ sender: UIBarButtonItem) {
        let alert: UIAlertController = UIAlertController(title: "保存", message: "メモの保存が完了しました", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {action in
            
            NSLog("OKボタンが押されました")
            
            
            
            if let textFields = alert.textFields{
                let textField1 = textFields[0]
                let textField2 = textFields[1]
                print(textField1.text!)
                print(textField2.text!)
                
                
                let editData: DataModel = self.realm.objects(DataModel.self).filter("id == " + String(ShowImageViewController.id)).first!
                
                try! self.realm.write {
                    
                    editData.name = textField1.text!
                    editData.folderName = textField2.text!
                    
                    
                }
            }
            self.navigationController!.popViewController(animated: true)
        }))
        
        //テキストフィールド
        alert.addTextField(configurationHandler: {(textField) -> Void in
            
            var nowData = self.realm.objects(DataModel.self).filter("id == " + String(ShowImageViewController.id)).first!
            textField.text = nowData.name
        })
        
        alert.addTextField(configurationHandler: {(textField) -> Void in
            var nowData = self.realm.objects(DataModel.self).filter("id == " + String(ShowImageViewController.id)).first!
            textField.text = nowData.folderName
        })
        
        
        
        //        var table = UITableView()
        //        table.frame = CGRect(x:0,y:0,width:view.bounds.width*0.85,height:150)
        //        table.dataSource = self
        //        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        //alert.view.addSubview(table)
        
        
        
        present(alert, animated: true, completion: nil)
        
    }
    
    @IBAction func trashPhoto(_ sender: UIBarButtonItem) {
        // アラートを作成
        let alert = UIAlertController(
            title: "削除",
            message: "この画像を削除しますか？",
            preferredStyle: .alert)
        
        // アラートにボタンをつける
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            
            let realm = try! Realm()
            let trashData : DataModel = realm.objects(DataModel.self).filter("id == " + String(ShowImageViewController.id)).first!
            
            try! realm.write() {
                realm.delete(trashData)
            }
            self.navigationController?.popViewController(animated: true)
            
        }))
        
        alert.addAction(UIAlertAction(title: "キャンセル", style: .cancel))
        
        // アラート表示
        self.present(alert, animated: true, completion: nil)
        
        
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
