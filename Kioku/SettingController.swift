//
//  SettingController.swift
//  Kioku
//
//  Created by Yuhao on 2017/05/31.
//  Copyright © 2017年 Yuhao. All rights reserved.
//

import UIKit

class SettingController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    var listItems: NSArray!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        let plistPath = Bundle.main.path(forResource: "Setting",ofType:"plist")
        self.listItems = NSArray(contentsOfFile: plistPath!)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "SettingTableViewCell"
        var cell: SettingCell! = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? SettingCell
        
        if(cell == nil){
            cell = SettingCell(style: UITableViewCellStyle.default, reuseIdentifier: cellIdentifier)
        }
        
        let row = indexPath.row
        let rowDict = self.listItems[row] as! NSDictionary
        
        let imageFile = rowDict["image"] as! String
        let imagePath = NSString(format: "%@.png", imageFile) as String
        cell.iconView.image = UIImage(named: imagePath)
        
        cell.descriptionView.text = rowDict["name"] as? String
        
        return cell
    }
    
    @IBAction func homeClick(_ sender: UIBarButtonItem) {
        forwardViewController()
    }
    
    @IBAction func addClick(_ sender: UIBarButtonItem) {
        forwardAddController()
    }
    
    func forwardAddController(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "addController") as! AddController
        //self.dismiss(animated: true, completion: nil)
        self.present(viewController, animated: true, completion: nil)
    }
    
    func forwardViewController(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "viewController") as! ViewController
        //self.dismiss(animated: true, completion: nil)
        self.present(viewController, animated: true, completion: nil)
    }
}

