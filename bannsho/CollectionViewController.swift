//
//  CollectionViewController.swift
//  bannsho
//
//  Created by 鈴木莉夏 on 2017/01/15.
//  Copyright © 2017年 鈴木莉夏. All rights reserved.
//

import UIKit
import RealmSwift

class CollectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    
    @IBOutlet weak var collection: UICollectionView!
    let realm = try! Realm()
    var dataModels :Results<DataModel>!
    var searchResult : [DataModel] = []
    
    var set = Set<String>()
    static var folderNameString = ""
    
    @IBOutlet weak var chooseButton: UIBarButtonItem!
    @IBOutlet weak var moveButton: UIBarButtonItem!
    var isChooseMode :Bool = false
    var chooseArray : [DataModel] = []

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib:UINib = UINib(nibName: "CollectionCell", bundle: nil)
        collection.register(nib, forCellWithReuseIdentifier: "collectionCell")
        
        collection.dataSource = self
        collection.delegate = self
        // Do any additional setup after loading the view.
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        search()
        collection.reloadData()
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func choose(){
        isChooseMode = !isChooseMode
    }
    
    @IBAction func moveFolder(){
        if isChooseMode == true && chooseArray.count >= 1{
            performSegue(withIdentifier: "toChangeFolder", sender: nil)
            
        }
        
    }
    
  
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchResult.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collection.dequeueReusableCell(withReuseIdentifier: "collectionCell",for: indexPath) as! CollectionCell
        
        
        let dataVal : Data = searchResult[indexPath.row].reimage as Data
        let image:UIImage = UIImage(data:dataVal)!
        //let imageK = resizeImage(src: image)
        cell.imageC.image = image
        
        let imageName0 = searchResult[indexPath.row].name as String
        let folderName0 = searchResult[indexPath.row].folderName as String
        
        print(imageName0)
        print(folderName0)
        
        
        
        
        return cell
    }
    
    // Cell が選択された場合
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if isChooseMode == true{
            chooseArray.append(searchResult[indexPath.row])
            
            
        }else if isChooseMode == false{
        ShowImageViewController.image = UIImage(data:searchResult[indexPath.row].image as Data)!
        ShowImageViewController.name = searchResult[indexPath.row].name as String
        ShowImageViewController.id = searchResult[indexPath.row].id as Int
        
        performSegue(withIdentifier: "toFinal", sender: nil)
        }else{
            print("error")
        }
    }
    
    
    func search(){
        
        searchResult = []
        
        dataModels = realm.objects(DataModel.self)
        
        if CollectionViewController.folderNameString != "all"{
            
            for data in dataModels{
                if data.folderName == CollectionViewController.folderNameString{
                    searchResult.append(data)
                }
            }
        }else{
            
            searchResult.append(contentsOf: dataModels)
            
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
    
}
