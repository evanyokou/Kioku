//
//  AddController.swift
//  Kioku
//
//  Created by Yuhao on 2017/05/31.
//  Copyright © 2017年 Yuhao. All rights reserved.
//

import UIKit

class AddController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource {
    
    @IBOutlet weak var wordTextField: UITextField!
    @IBOutlet weak var kanaTextField: UITextField!
    @IBOutlet weak var imiTextField: UITextField!
    @IBOutlet weak var reiTextField: UITextView!
    @IBOutlet weak var tagPicker: UIPickerView!
    
    var tags: NSArray!
    var tagIndex: Int = 0
    var edit_id: String? = nil
 
    
    let helper: KotobaHelper = KotobaHelper()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //wordTextField.resignFirstResponder()
        //kanaTextField.resignFirstResponder()
        //reiTextField.resignFirstResponder()
        
        let plistPath = Bundle.main.path(forResource: "Tags",ofType:"plist")
        self.tags = NSArray(contentsOfFile: plistPath!)!
        
        
        if edit_id == nil {
            self.wordTextField.text = ""
            self.kanaTextField.text = ""
            self.imiTextField.text = ""
            self.reiTextField.text = ""
            self.tagPicker.selectRow(0,inComponent: 0,animated: false)
        }else{
            let kotoba = helper.query(id: edit_id!)!
            self.wordTextField.text = kotoba.tango
            self.kanaTextField.text = kotoba.kana
            self.imiTextField.text = kotoba.imi
            self.reiTextField.text = kotoba.rei
            
            var row: Int = 0
            for index:Int in 0...(self.tags.count-1){
                if self.tags[index] as? String == kotoba.tag {
                    row = index
                    break
                }
            }
            self.tagPicker.selectRow(row,inComponent: 0,animated: false)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.tags.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.tags[row] as? String
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.tagIndex =  row
    }
    
    @IBAction func clickSaveBtn(_ sender: UIBarButtonItem) {
        let kotoba: KotobaEntity = KotobaEntity()
        
        kotoba.tango = self.wordTextField.text
        kotoba.kana = self.kanaTextField.text
        kotoba.imi = self.imiTextField.text
        kotoba.rei = self.reiTextField.text        
        kotoba.tag = self.tags[self.tagIndex] as? String
        
        if edit_id == nil {
            kotoba.id =  nil
            kotoba.kaisu = 0
            if helper.save(data: kotoba) != nil {
                edit_id = nil
                forwardViewController()
            }else{
                alert(title: "ヒント", message: "データを保存しないです。ごチェックください。", btn: ["確認"])
            }
        }else{
            kotoba.id = edit_id
            if helper.update(data: kotoba) != nil {
                edit_id = nil
                forwardViewController()
            }else{
                alert(title: "ヒント", message: "データを更新しないです。ごチェックください。", btn: ["確認"])
            }

        }
        
    }
    
    func alert(title:String,message:String,btn:[String]){
        let alertController = UIAlertController(title: title,
                                                message: message, preferredStyle: .alert)
        for str: String in btn {
            let okAction = UIAlertAction(title:str, style: .default, handler: nil)
            alertController.addAction(okAction)
        }
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func backForwardBtn(_ sender: UIBarButtonItem) {
        forwardViewController()
        
    }
  
    func forwardViewController(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "viewController") as! ViewController        
        //self.dismiss(animated: true, completion: nil)
        self.present(viewController, animated: true){
            viewController.tbView.reloadData()
        }
    }
    
    
}
