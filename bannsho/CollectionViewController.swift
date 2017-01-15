//
//  CollectionViewController.swift
//  bannsho
//
//  Created by 鈴木莉夏 on 2017/01/15.
//  Copyright © 2017年 鈴木莉夏. All rights reserved.
//

import UIKit

class CollectionViewController: UIViewController, UICollectionViewDataSource {

    @IBOutlet weak var collection: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib:UINib = UINib(nibName: "CollectionCell", bundle: nil)
        collection.register(nib, forCellWithReuseIdentifier: "collectionCell")
        
        collection.dataSource = self

        // Do any additional setup after loading the view.
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collection.dequeueReusableCell(withReuseIdentifier: "collectionCell",for: indexPath) as! CollectionCell
        
        cell.imageC.image = UIImage(named: "1-nakajima-b.png")
        
        return cell
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
