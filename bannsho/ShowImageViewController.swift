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
    
    @IBOutlet weak var imageview: UIImageView!
    
    @IBOutlet weak var navigationBar: UINavigationBar!
    
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
    
    @IBAction func trashPhoto(_ sender: UIBarButtonItem) {
        // アラートを作成
        let alert = UIAlertController(
            title: "削除",
            message: "この画像を削除しますか？",
            preferredStyle: .alert)
        
        // アラートにボタンをつける
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            
            let realm = try! Realm()
            let trashData : DataModel = realm.objects(DataModel).filter("id == " + String(ShowImageViewController.id)).first!
            
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
