//
//  MainVote.swift
//  HackVote
//
//  Created by 钟镇阳 on 10/10/15.
//  Copyright © 2015 ZhenyangZhong. All rights reserved.
//

import UIKit

class MainVote: UIViewController {
    
    @IBAction func logout(sender: AnyObject) {
        clean()
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func clean(){
        VoteInProgress.dic.removeAll()
        VoteHistory.dic.removeAll()
        MainVote.userData.removeAll()
    }
    
    static var userData = Dictionary<String,String>()
    
    func loadLabels(){
        name.text = MainVote.userData["name"]
        academic.text = "Academic " + MainVote.userData["academic"]!
        recreation.text = "Recreation " + MainVote.userData["recreation"]!
        finance.text = "Finance " + MainVote.userData["finance"]!
        social.text = "Social Experience " + MainVote.userData["social"]!
    }
    
    @IBOutlet var name: UILabel!
    @IBOutlet var academic: UILabel!
    @IBOutlet var recreation: UILabel!
    @IBOutlet var finance: UILabel!
    @IBOutlet var social: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
