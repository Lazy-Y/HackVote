//
//  FeedBack.swift
//  HackVote
//
//  Created by 钟镇阳 on 10/15/15.
//  Copyright © 2015 ZhenyangZhong. All rights reserved.
//

import UIKit

class FeedBack: Vote {
    
    var problemID:String!
    
    override var url:String{
        return "feedback.php"
    }
    
    override var upload:String{
        return "id="+problemID
    }
    
    override var url1:String{
        return "post_feedback.php"
    }
    
    override func submitTask(dic: NSDictionary) {
        dispatch_async(dispatch_get_main_queue()) { () -> Void in
            self.navigationController?.popViewControllerAnimated(true)
        }
        vip.loadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Feedback"
        // Do any additional setup after loading the view.
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
