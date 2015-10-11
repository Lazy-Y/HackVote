//
//  Vote.swift
//  HackVote
//
//  Created by 钟镇阳 on 10/10/15.
//  Copyright © 2015 ZhenyangZhong. All rights reserved.
//

import UIKit

class Vote: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    func reloadAll(){
        if (Vote.prob.isEmpty) {
            setData()
            return
        }
        Vote.dic.removeFirst()
        Vote.prob.removeFirst()
        Vote.detail.removeFirst()
        Vote.user.removeFirst()
        setData()
    }
    
    func setData(){
        if (Vote.dic.isEmpty){
            who.text = "No questions available"
            problem.text = ""
            detail.text = ""
            table.reloadData()
        }
        else {
            who.text = Vote.user[0]+" post a questioin"
            problem.text = Vote.prob[0]
            detail.text = Vote.detail[0]
            table.reloadData()
        }
    }

    @IBAction func confirm(sender: AnyObject) {
        if (userChoice == nil) {
            let cancelAction = UIAlertAction(title: "Ok", style: .Cancel){(action) in}
            let alert = UIAlertController(title: "Warning", message: "Please select at least one item", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(cancelAction)
            self.presentViewController(alert, animated: true, completion: nil)
            return
        }
        reloadAll()
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
        vote = self
        setData()
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
    
    static var dic = Array<Array<String>>()
    static var prob = Array<String>()
    static var detail = Array<String>()
    static var user = Array<String>()
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        if (Vote.dic.isEmpty) {return 0}
        return Vote.dic[0].count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "vcell")
        cell.textLabel?.text = Vote.dic[0][indexPath.row]
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
