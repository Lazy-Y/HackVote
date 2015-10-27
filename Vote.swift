//
//  Vote.swift
//  HackVote
//
//  Created by 钟镇阳 on 10/10/15.
//  Copyright © 2015 ZhenyangZhong. All rights reserved.
//

import UIKit

class Vote: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    var opt:Array<String>!
    
    func refreshData(dic:NSDictionary){
        refreshControl.endRefreshing()
        Vote.dic = dic as! NSMutableDictionary
        if let options = Vote.dic["options"]{
            opt = options.componentsSeparatedByString("§")
        }
        else {
            opt?.removeAll()
        }
        setData()
    }
    
    private func setData(){
        dispatch_async(dispatch_get_main_queue()) { () -> Void in
            if (Vote.dic["empty"] as! String == "true"){
                self.who.text = "No questions available"
                self.problem.text = ""
                self.detail.text = ""
            }
            else {
                self.who.text = Vote.dic["owner"] as! String+" post a questioin"
                self.problem.text = (Vote.dic["problem"] as! String)
                self.detail.text = (Vote.dic["detail"] as! String)
                self.detail.text = (Vote.dic["detail"] as! String)
            }
            self.table.reloadData()
        }
    }
    
    var url:String{
        return "get_one.php"
    }
    
    var upload:String{
        return "user="+mainVote.userData["name"]!
    }
    
    func refreshView(){
        let request = newPostRequest(upload,url: url)
        if request == nil{
            return
        }
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request!){
            (data,resp,err) in
            connect(data, resp: resp, err: err, myTask:self.refreshData, vc: self)
        }
        task.resume()
    }
    
    private func checkUserChoice()->Bool{
        if (userChoice == nil) {
            errMsg("Warning", msg: "Please select at least one item", vc: self)
            return false
        }
        else{
            return true
        }
    }
    
    var upload1:String{
        var str = "name="
        str += mainVote.userData["name"]!
        str += "&id="
        str += String(Vote.dic["id"]!)
        str += "&selected="
        str += String(userChoice.row+1)
        print(str)
        return str
    }
    
    func submitTask(dic:NSDictionary){
        refreshView()
    }
    
    var url1:String{
        return "user_select.php"
    }
    
    private func submit(){
        if checkUserChoice(){
            let request = newPostRequest(upload1,url: url1)
            print(url1)
            if request == nil{
                return
            }
            let task = NSURLSession.sharedSession().dataTaskWithRequest(request!){
                (data,resp,err) in
                connect(data, resp: resp, err: err, myTask:self.submitTask, vc: self)
            }
            task.resume()
        }
    }
    
    @IBAction func confirm(sender: AnyObject) {
        if checkUserChoice(){
            submit()
        }
    }
    @IBOutlet var who: UILabel!
    @IBOutlet var problem: UILabel!
    @IBOutlet var detail: UITextView!
    @IBOutlet var table: UITableView!
    var refreshControl = UIRefreshControl()
    private var userChoice:NSIndexPath!
    override func viewDidLoad() {
        super.viewDidLoad()
        table.delegate = self
        table.dataSource = self
        vote = self
        refreshView()
        refreshControl.addTarget(self, action: "refreshView", forControlEvents: UIControlEvents.ValueChanged)
        refreshControl.attributedTitle = NSAttributedString(string: "refresh")
        table.addSubview(refreshControl)
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
    
    static var dic = NSMutableDictionary()
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        if opt == nil{
            return 0
        }
        return opt.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "vcell")
        cell.textLabel?.text = opt[indexPath.row]
        if indexPath != userChoice {
            cell.textLabel?.textColor = UIColor.blackColor()
        }
        else {
            cell.textLabel?.textColor = UIColor.greenColor()
        }
        return cell
    }
}
