//
//  VoteInProgress.swift
//  HackVote
//
//  Created by 钟镇阳 on 10/10/15.
//  Copyright © 2015 ZhenyangZhong. All rights reserved.
//

import UIKit

class VoteInProgress: UIViewController,UITableViewDataSource,UITableViewDelegate {

    static var dic = Array<Array<String>>()
    @IBOutlet var table: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        table.frame = CGRect(x: 0, y: 0, width: 380, height: 600)
        table.delegate = self
        table.dataSource = self
        table.reloadData()
        vip = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return VoteInProgress.dic.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "cell")
        cell.textLabel?.text = VoteInProgress.dic[indexPath.row][0]+", " + VoteInProgress.dic[indexPath.row][1] + " votes"
        return cell
    }
}
