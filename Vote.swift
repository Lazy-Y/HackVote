//
//  Vote.swift
//  HackVote
//
//  Created by 钟镇阳 on 10/10/15.
//  Copyright © 2015 ZhenyangZhong. All rights reserved.
//

import UIKit

class Vote: UIViewController,UITableViewDataSource,UITableViewDelegate {

    @IBAction func confirm(sender: AnyObject) {
        if (userChoice == nil) {
            let cancelAction = UIAlertAction(title: "Ok", style: .Cancel){(action) in}
            let alert = UIAlertController(title: "Warning", message: "Please select at least one item", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(cancelAction)
            self.presentViewController(alert, animated: true, completion: nil)
            return
        }
        self.navigationController?.popViewControllerAnimated(true)
    }
    @IBOutlet var who: UILabel!
    @IBOutlet var problem: UILabel!
    @IBOutlet var detail: UITextView!
    @IBOutlet var table: UITableView!
    private var userChoice:NSIndexPath!
    override func viewDidLoad() {
        super.viewDidLoad()
        table.delegate = self
        table.dataSource = self
        Vote.dic = ["swift","java"]
        table.reloadData()
        // Do any additional setup after loading the view.
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        userChoice = indexPath
        table.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    static var dic = Array<String>()
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return Vote.dic.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "vcell")
        cell.textLabel?.text = Vote.dic[indexPath.row]
        if indexPath != userChoice {
            cell.textLabel?.textColor = UIColor.blackColor()
        }
        else {
            cell.textLabel?.textColor = UIColor.greenColor()
        }
        return cell
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
