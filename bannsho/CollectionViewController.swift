//
//  CollectionViewController.swift
//  bannsho
//
//  Created by 鈴木莉夏 on 2017/01/15.
//  Copyright © 2017年 鈴木莉夏. All rights reserved.
//

import UIKit
import  RealmSwift

class CollectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var collection: UICollectionView!
    let realm = try! Realm()
    var dataModels :Results<DataModel>!
    var searchResult : [DataModel] = []
    
    var set = Set<String>()
    static var folderNameString = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib:UINib = UINib(nibName: "CollectionCell", bundle: nil)
        collection.register(nib, forCellWithReuseIdentifier: "collectionCell")
        
        collection.dataSource = self
        collection.delegate = self
    
        dataModels = realm.objects(DataModel)
        
        if CollectionViewController.folderNameString != "all"{
            
            for data in dataModels{
                if data.folderName == CollectionViewController.folderNameString{
                    searchResult.append(data)
                }
            }
        }else{
            
            searchResult.append(contentsOf: dataModels)
            
        }
        
        
        
        
        // Do any additional setup after loading the view.
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchResult.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collection.dequeueReusableCell(withReuseIdentifier: "collectionCell",for: indexPath) as! CollectionCell
        
        cell.imageC.image = UIImage(data:searchResult[indexPath.row].image as Data)
        
        let imageName0 = searchResult[indexPath.row].name as String
        let folderName0 = searchResult[indexPath.row].folderName as String
        
        print(imageName0)
        print(folderName0)
        
        
        
        
        return cell
    }
    
    // Cell が選択された場合
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        ShowImageViewController.image = UIImage(data:searchResult[indexPath.row].image as Data)!
        ShowImageViewController.name = searchResult[indexPath.row].name as String
        performSegue(withIdentifier: "toFinal", sender: nil)
        
       
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