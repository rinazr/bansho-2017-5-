//
//  ChangeFolderViewController.swift
//  bannsho
//
//  Created by 鈴木莉夏 on 2018/02/18.
//  Copyright © 2018年 鈴木莉夏. All rights reserved.
//

import UIKit
import RealmSwift

class ChangeFolderViewController: UIViewController,UITableViewDataSource,UITableViewDelegate{
    @IBOutlet weak var folderTableView: UITableView!
    
    
    var set: Set<String> = []
    var array : Array<String> = Array<String>()
    var imageArray: [UIImage] = []
    var dataModels :Results<DataModel>!
    let realm = try! Realm()
    
    var chooseArray :[DataModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        folderTableView.dataSource = self
        folderTableView.delegate = self
        
        let nib = UINib(nibName: "CustomCell", bundle:nil)
        folderTableView.register(nib, forCellReuseIdentifier: "customCell")
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
        var folderName = ""
        switch indexPath.row {
        case 0:
            folderName = "アルバム"
            break
        default:
            folderName = array[indexPath.row - 1]
            break
        }
        // Realmのインスタンスを取得
        let realm = try! Realm()
        for dataModel in chooseArray {
            try! realm.write(){
                dataModel.folderName = folderName
            }
        }
        performSegue(withIdentifier: "toCollection", sender: nil)

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
