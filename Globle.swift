//
//  Globle.swift
//  HackVote
//
//  Created by 钟镇阳 on 10/14/15.
//  Copyright © 2015 ZhenyangZhong. All rights reserved.
//

import Foundation
import UIKit


let mainURL = "http://localhost/phpmyadmin/mywork/trojanHack/"
//let mainURL = "http://172.20.10.4/phpmyadmin/mywork/trojanHack/"

var vip:VoteInProgress!
var user:String!
var vote:Vote!
var mainVote:MainVote!
var feedback:FeedBack!
var vh:VoteHistory!

func errMsg(title:String,msg:String,vc:UIViewController){
    dispatch_async(dispatch_get_main_queue(), { () -> Void in
        let cancelAction = UIAlertAction(title: "Ok", style: .Cancel){(action) in}
        let alert = UIAlertController(title: title, message: msg, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(cancelAction)
        vc.presentViewController(alert, animated: true, completion: nil)
    })
}

func checkStatus(dic:NSDictionary,vc:UIViewController)->Bool{
    if dic["status"] as! String == "false"{
        errMsg("Sorry", msg: dic["errMsg"] as! String, vc: vc)
        return false
    }
    return true
}

func getData(data:NSData?)->NSDictionary?{
    if let receive = (try? NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers)) as? NSDictionary{
        return receive
    }
    return nil
}

func connect(data:NSData?,resp:NSURLResponse?,err:NSError?, myTask:(NSDictionary)->Void,vc:UIViewController){
    if (err==nil){
        let receive = getData(data)
        print(NSString(data: data!, encoding: NSUTF8StringEncoding))
        if receive != nil{
            if !checkStatus(receive!, vc: vc){
                return
            }
            else {
                myTask(receive!)
            }
            
        }
        else {
            errMsg("Error", msg: "Error loading data", vc: vc)
        }
    }
    else {
        errMsg("Error", msg: (err?.localizedDescription)!, vc: vc)
    }
}

func checkValidStr(str:String)->Bool{
    if str.containsString("\"")||str.containsString("\'")||str.containsString("&"){
        return false
    }
    else{
        return true
    }
}

func newPostRequest(upload:String?,url:String)->NSURLRequest?{
    let url = NSURL(string: mainURL+url)
    let request = NSMutableURLRequest(URL: url!, cachePolicy: NSURLRequestCachePolicy.UseProtocolCachePolicy, timeoutInterval: 10.0)
    request.HTTPMethod = "POST"
    let upStr = upload
    if upStr == nil{
        return nil
    }
    request.HTTPBody = upStr!.dataUsingEncoding(NSUTF8StringEncoding)
    return request
}
