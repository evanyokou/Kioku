//
//  ViewController.swift
//  Kioku
//
//  Created by Yuhao on 2017/05/31.
//  Copyright © 2017年 Yuhao. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var segView: UISegmentedControl!
    @IBOutlet weak var tbView: UITableView!
    
    var kotoba: [Kotoba]? = nil
    let helper: KotobaHelper = KotobaHelper()
    let level: Int16 = 7
    let colors: [UIColor] = [UIColor(red: 254/255, green: 67/255, blue: 101/255, alpha: 1),
                             UIColor(red: 252/255, green: 157/255, blue: 154/255, alpha: 1),
                             UIColor(red: 249/255, green: 205/255, blue: 173/255, alpha: 1),
                             UIColor(red: 200/255, green: 200/255, blue: 169/255, alpha: 1),
                             UIColor(red: 131/255, green: 175/255, blue: 155/255, alpha: 1),
                             UIColor(red: 38/255, green: 188/255, blue: 214/255, alpha: 1),
                             UIColor(red: 28/255, green: 120/255, blue: 135/255, alpha: 1),
                             UIColor(red: 20/255, green: 68/255, blue: 106/255, alpha: 1),
                             UIColor.black]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.segView.addTarget(self, action: #selector(ViewController.segmentDidChange(_:)), for: .valueChanged)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func segmentDidChange(_ segmented: UISegmentedControl){
        self.tbView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.segView.selectedSegmentIndex == 0 {
            self.kotoba = helper.query(condition: "kaisu<\(self.level)")
            if self.kotoba != nil {
                return (self.kotoba?.count)!
            }else{
                return 0
            }
        }else{
            self.kotoba = helper.query(condition: "kaisu>=\(self.level)")
            if self.kotoba != nil {
                return (self.kotoba?.count)!
            }else{
                return 0
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "RememberCellIdentifier"
        var cell: RememberCell! = tbView.dequeueReusableCell(withIdentifier: cellIdentifier) as? RememberCell
        
        if(cell == nil){
            cell = RememberCell(style: UITableViewCellStyle.default, reuseIdentifier: cellIdentifier)
        }
        
        let row = indexPath.row
        let rowDict = (self.kotoba?[row])! as Kotoba
        
        cell.id = rowDict.id
        
        cell.wordLabel.textColor = self.colors[Int(rowDict.kaisu)]
        cell.kanaLabel.textColor = self.colors[Int(rowDict.kaisu)]
        cell.tagLabel.textColor = self.colors[Int(rowDict.kaisu)]
        cell.levelLabel.textColor = self.colors[Int(rowDict.kaisu)]
        
        cell.wordLabel.text = rowDict.tango
        cell.kanaLabel.text = rowDict.kana
        cell.tagLabel.text = rowDict.tag
        if rowDict.kaisu >= self.level {
            cell.levelLabel.text = "完了"
        }else{
            cell.levelLabel.text = "\(rowDict.kaisu)"
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell: RememberCell = tableView.cellForRow(at: indexPath) as! RememberCell
        if cell.levelLabel.text! != "完了" {
            var kaisu: Int16 = Int16.init(cell.levelLabel.text!)!
            kaisu += 1
            if kaisu <= self.level {
                self.helper.update(id: cell.id, kaisu: kaisu)
                self.tbView.reloadData()
            }
            
        }
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let cell: RememberCell = tableView.cellForRow(at: indexPath) as! RememberCell
        let del = UITableViewRowAction(style: .normal, title: "削除") { (action, index) in
            self.helper.delete(id: cell.id)
            self.tbView.reloadData()
        }
        
        del.backgroundColor = UIColor.red
        
        let edit = UITableViewRowAction(style: .normal, title: "編集") { (action, index) in
            self.forwardAddController(id: cell.id)
        }
        
        edit.backgroundColor = UIColor.orange
        return [del,edit]
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
    
    
    @IBAction func homeClick(_ sender: UIBarButtonItem) {
        self.tbView.reloadData()
    }
    
    @IBAction func addClick(_ sender: UIBarButtonItem) {
        forwardAddController()
    }
    
    @IBAction func settingClick(_ sender: UIBarButtonItem) {
        forwardSettingController()
    }
    
    func forwardAddController(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "addController") as! AddController
        viewController.edit_id = nil
        self.present(viewController, animated: true,completion: nil)
    }
    
    func forwardAddController(id: String){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "addController") as! AddController
        viewController.edit_id = id
        self.present(viewController, animated: true,completion: nil)
    }
    
    func forwardSettingController(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "settingController") as! SettingController
        //self.dismiss(animated: true, completion: nil)
        self.present(viewController, animated: true, completion: nil)
        
    }
    
    
}

