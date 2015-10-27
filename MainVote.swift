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
        vip?.dic.removeAllObjects()
        vh?.dic.removeAllObjects()
        userData.removeAll()
    }
    
    var userData = Dictionary<String,String>()
    
    func loadLabels(){
        name.text = userData["name"]
        academic.text = String(userData["academic"]!)
        recreation.text = String(userData["recreation"]!)
        finance.text = String(userData["finance"]!)
        social.text = String(userData["social"]!)
    }
    
    func myTask(dic:NSDictionary){
        userData = dic["data"] as! Dictionary<String,String>
        dispatch_async(dispatch_get_main_queue()) { () -> Void in
            self.loadLabels()
        }
    }
    
    func loadData(){
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) { () -> Void in
            sleep(10)
            print("load here")
            while !mainVote.userData.isEmpty{
                let request = newPostRequest("name="+mainVote.userData["name"]!,url: "user_data.php")
                if request == nil{
                    return
                }
                let task = NSURLSession.sharedSession().dataTaskWithRequest(request!){
                    (data,resp,err) in
                    connect(data, resp: resp, err: err, myTask:self.myTask, vc: self)
                }
                task.resume()
                print("Load data")
                sleep(10)
            }
        }
    }

    @IBOutlet var name: UILabel!
    @IBOutlet var academic: UILabel!
    @IBOutlet var recreation: UILabel!
    @IBOutlet var finance: UILabel!
    @IBOutlet var social: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        mainVote = self
        loadData()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
