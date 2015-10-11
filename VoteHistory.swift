//
//  VoteHistory.swift
//  HackVote
//
//  Created by 钟镇阳 on 10/10/15.
//  Copyright © 2015 ZhenyangZhong. All rights reserved.
//

import UIKit

class VoteHistory: UIViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet var table: UITableView!
    static var dic = Array<Array<String>>()
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return VoteHistory.dic.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "vhcell")
        cell.textLabel?.text = VoteHistory.dic[indexPath.row][0]+", " + VoteHistory.dic[indexPath.row][1] + " votes"
        return cell
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        table.frame = CGRect(x: 0, y: 0, width: 380, height: 600)
        table.dataSource = self
        table.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
