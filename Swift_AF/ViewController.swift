//
//  ViewController.swift
//  Swift_AF
//
//  Created by lee on 16/5/12.
//  Copyright © 2016年 lee. All rights reserved.
//

import UIKit

class ViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource{
    let str = "http://bi2.duowan.com/apiMain.php?version=2.0.4&os=iOS&_=1460339882791r"
    let tableV = UITableView()
    var data = Array<String>()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //        self.view.backgroundColor = UIColor.redColor()
        print("\(str)")
        self.getResqueUrl()
        self.initUI()
    }
    
    func initUI(){
        tableV.backgroundView?.alpha = 0.5
        tableV.delegate = self
        tableV.dataSource = self
        tableV.frame = self.view.bounds
        tableV.registerClass(UITableViewCell.classForKeyedUnarchiver(), forCellReuseIdentifier: "cell")
        tableV.rowHeight = 180
        self.view .addSubview(tableV)
    }
    
    
    func getResqueUrl(){
        ZCTools.afGetURl(str, parameter: nil, blockSuccess: { (success, respon) in
            //            print("respon:\(respon)")
            let dict:NSDictionary = try! NSJSONSerialization.JSONObjectWithData(respon! as! NSData, options: .MutableContainers) as! NSDictionary
            let arr:Array<NSDictionary> = dict["banner"] as! Array
            for dic in arr{
                print("\(dic["text"])")
                self.data.append(dic["text"] as! String)
            }
            self.tableV.reloadData()
            
            
        }) { (success, error) in
            print("error:\(error)")
        }
        //        HTTPConnection.getRequestWithUrl(str!, param: nil) { (data, error) in
        //            print("\(data)")
        //        }
    }
    
    
    //=========UITableViewDelegate,UITableViewDataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:UITableViewCell = tableView.dequeueReusableCellWithIdentifier("cell")!
        cell.textLabel!.text = self.data[indexPath.row]
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //        返回后取消选中状态
        self.tableV.deselectRowAtIndexPath(indexPath, animated: true)
        self.navigationController?.pushViewController(OneViewController(), animated: true)
    }
}


