//
//  FileViewController.swift
//  bannsho
//
//  Created by 鈴木莉夏 on 2017/01/15.
//  Copyright © 2017年 鈴木莉夏. All rights reserved.
//

import UIKit
import RealmSwift

class FileViewController: UIViewController, UITableViewDataSource,UITableViewDelegate{
    
    var set: Set<String> = []
    var array : Array<String> = Array<String>()
    var imageArray: [UIImage] = []
    var dataModels :Results<DataModel>!
    let realm = try! Realm()
    
    
    @IBOutlet weak var plusFileB: UIBarButtonItem!
    @IBOutlet weak var table: UITableView!
    
    override func viewDidLoad() {
        // Do any additional setup after loading the view.
        
        super.viewDidLoad()
        table.dataSource = self
        table.delegate = self
        
        let nib = UINib(nibName: "CustomCell", bundle:nil)
        table.register(nib, forCellReuseIdentifier: "customCell")
        //performSegue(withIdentifier: "move1", sender: nil)
        
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        search()
        searchImage()
        table.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //セルの設定
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return set.count + 1
    }
    
    //ID付きのセルを取得して、セル付属のtextLabelに「テスト」と表示させてみる
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell") as! CustomCell
        
        switch indexPath.row {
        case 0:
            cell.label1.text = "アルバム"
            cell.label2.text = ">"
            cell.imageB.image = UIImage(named: "4-rampo-b.png")
            break
        case set.count + 1:
            cell.label1.text = "ゴミ箱"
            cell.label2.text = ">"
            cell.imageB.image = UIImage(named: "暗殺教室.jpg")
            break
        default:
            cell.label1.text = array[indexPath.row - 1]
            cell.label2.text = ">"
            cell.imageB.image = imageArray[indexPath.row - 1]
            break
        }
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        print("qqq")
        
        performSegue(withIdentifier: "move1", sender: nil)
        
        if indexPath.row >= 1 && indexPath.row < set.count + 1 {
            
            print(indexPath.row)
            
            CollectionViewController.folderNameString = array[indexPath.row - 1]
            
        }else if indexPath.row == 0{
            CollectionViewController.folderNameString = "all"
            }
    }
    
//    @IBAction func plusFile(_ sender: Any) {
//        let alert: UIAlertController = UIAlertController(title: "追加", message: "", preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {action in
//            NSLog("フォルダが追加されました")
//            if let textFields = alert.textFields{
//                let textField2 = textFields[1]
//                print(textField2.text!) 
//                let realm = try! Realm()
//                let dataModel = DataModel()
//                dataModel.folderName = textField2.text!
//                let result = realm.objects(DataModel).sorted(byKeyPath: "id", ascending: true).last
//                if result?.id == nil{
//                    dataModel.id = 0
//                }else{
//                    dataModel.id = (result?.id)! + 1
//                }
//                print("ID:" + String(describing: dataModel.id))
//                
//                try! realm.write {
//                    realm.add(dataModel)
//                }
//                
//            }
//        }))
//        alert.addTextField(configurationHandler: {(textField) -> Void in
//            textField.placeholder = "フォルダ名"
//        })
//        present(alert, animated: true, completion: nil)
//    }
    
    func search(){
        
        set = Set<String>()
        array = Array<String>()
        
        dataModels = realm.objects(DataModel.self)
        
        for dataModel in dataModels {
            
            print(dataModel.folderName)
            
            if dataModel.folderName != ""{
                set.insert(dataModel.folderName)
            }
        }
        
        print(set)
        
        
        array.append(contentsOf: set)
        
    }
    
    func searchImage(){
        for folderName in array {
            let data = realm.objects(DataModel.self).filter("folderName == %@",folderName).last
            let imageData = data?.image
            let image = UIImage(data: imageData!)
            imageArray.append(image!)
        }
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


