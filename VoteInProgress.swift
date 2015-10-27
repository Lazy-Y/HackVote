//
//  VoteInProgress.swift
//  HackVote
//
//  Created by 钟镇阳 on 10/10/15.
//  Copyright © 2015 ZhenyangZhong. All rights reserved.
//

import UIKit

class VoteInProgress: UIViewController,UITableViewDataSource,UITableViewDelegate {

    var dic = NSMutableArray()
    var refreshControl = UIRefreshControl()
    
    @IBOutlet var table: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        table.frame = CGRect(x: 0, y: 0, width: 380, height: 600)
        table.delegate = self
        table.dataSource = self
        table.reloadData()
        vip = self
        loadData()
        refreshControl.addTarget(self, action: "loadData", forControlEvents: UIControlEvents.ValueChanged)
        refreshControl.attributedTitle = NSAttributedString(string: "refresh")
        table.addSubview(refreshControl)
    }

    func myTask(dic:NSDictionary){
        self.dic = dic["data"] as! NSMutableArray
        dispatch_async(dispatch_get_main_queue()) { () -> Void in
            self.table.reloadData()
        }
    }
    
    var url:String{
        return "vip.php"
    }
    
    func loadData(){
        let request = newPostRequest("owner="+mainVote.userData["name"]!,url: url)
        if request == nil{
            return
        }
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request!){
            (data,resp,err) in
            connect(data, resp: resp, err: err, myTask:self.myTask, vc: self)
        }
        task.resume()
        refreshControl.endRefreshing()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return dic.count
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        let board = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        let vc = board.instantiateViewControllerWithIdentifier("feedback")
        feedback = vc as? FeedBack
        feedback!.problemID = String(dic[indexPath.row][2])
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "cell")
        let prob = String(dic[indexPath.row][0])
        let num = String(dic[indexPath.row][1])
        cell.textLabel?.text = prob+", " + num + " votes"
        return cell
    }
}
