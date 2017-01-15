//
//  ViewController.swift
//  bannsho
//
//  Created by 鈴木莉夏 on 2016/11/20.
//  Copyright © 2016年 鈴木莉夏. All rights reserved.
//
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    
    @IBOutlet weak var imageView2: UIImageView!
    @IBOutlet weak var imageView3: UIImageView!
    
    @IBOutlet weak var imageView1: UIImageView!
    let saveData: UserDefaults = UserDefaults.standard
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib
        saveData.register(defaults: ["number" : 0])
        
        var image1 : NSData!
        var image2 : NSData!
        var image3 : NSData!
        
        image1 = saveData.object(forKey: "1") as? NSData
//        image2 = saveData.object(forKey: "2") as? NSData
        //image3 = saveData.object(forKey: "3") as? NSData
        
        var UIImage1 : UIImage!
        var UIImage2 : UIImage!
        var UIImage3 : UIImage!
        
        UIImage1 = nsDataToImage(nsData: image1)
        //UIImage2 = nsDataToImage(nsData: image2)
        //UIImage3 = nsDataToImage(nsData: image3)
        
        imageView1.image = UIImage1
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
        let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage
        
        var numberData : Int = 0
        //numberDataを取得する
        if saveData.object(forKey: "number") != nil{
            numberData = saveData.object(forKey: "number") as! Int
        }
        //numberDataに1足したものを上書きする
        numberData = numberData + 1
        
        //NSDataにpickedImageを保存
        saveData.set(imageToNSData(image: pickedImage!), forKey: String(numberData))
        saveData.synchronize()
        
        //numberDataを保存
        saveData.set(numberData, forKey: "number")
        saveData.synchronize()
        
        //閉じる処理
        imagePicker.dismiss(animated: true, completion: nil)
        
    }
    
    
    func imageToNSData(image: UIImage) -> NSData! {
        
        return UIImagePNGRepresentation(image) as NSData!
    }
    
    func nsDataToImage(nsData: NSData) -> UIImage! {
        
        return UIImage(data: nsData as Data)
    }
    
    
    
    
    
    
}

