//
//  ViewController.swift
//  HackVote
//
//  Created by 钟镇阳 on 10/5/15.
//  Copyright © 2015 ZhenyangZhong. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var name: UITextField!
    @IBOutlet var pass: UITextField!
    @IBAction func login(sender: AnyObject) {
        let url = NSURL(string:mainURL+"login.php")
        let request = NSMutableURLRequest(URL: url!, cachePolicy: NSURLRequestCachePolicy.UseProtocolCachePolicy, timeoutInterval: 10.0)
        request.HTTPMethod = "POST"
        let upload = "name=" + name.text! + "&pass=" + pass.text!
        if !checkValidStr(name.text!) || !checkValidStr(pass.text!) {
            errMsg("Warnning", msg: "Invalid character \",\',&", vc: self)
            return
        }
        request.HTTPBody = upload.dataUsingEncoding(NSUTF8StringEncoding)
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request){
            (data,resp,err) in
            if (err == nil){
                if let userInfo = (try? NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers)) as? Dictionary<String,String>{
                    if userInfo["name"]! == "fail" {
                        errMsg("Sorry", msg: "Incorrect username or password", vc: self)
                        return
                    }
                    else {
                        dispatch_async(dispatch_get_main_queue(), { () -> Void in
                            let board = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
                            let vc = board.instantiateViewControllerWithIdentifier("main") as! UITabBarController
                            self.presentViewController(vc, animated: true, completion: { () -> Void in
                                mainVote.userData = userInfo
                                mainVote!.loadLabels()
                            })
                        })
                        return
                    }
                    
                }
                else {
                    errMsg("Error", msg: "Error laoding data", vc: self)
                    return
                }
            }
            else {
                errMsg("Error", msg: (err?.localizedDescription)!, vc: self)
                return
            }
        }
        task.resume()
    }
    
    @IBAction func signUp(sender: AnyObject) {
        if name.text!.isEmpty {
            errMsg("Sorry", msg: "Please fill your user name tp sign up", vc: self)
            return
        }
        if pass.text!.isEmpty {
            errMsg("Sorry", msg: "Please fill your user password tp sign up", vc: self)
            return
        }
        let url = NSURL(string: mainURL+"signup.php")
        let request = NSMutableURLRequest(URL: url!, cachePolicy: NSURLRequestCachePolicy.UseProtocolCachePolicy, timeoutInterval: 10.0)
        request.HTTPMethod = "POST"
        let upload = "name=" + name.text! + "&pass=" + pass.text!
        if !checkValidStr(name.text!) || !checkValidStr(pass.text!) {
            errMsg("Warnning", msg: "Invalid character \",\',&", vc: self)
            return
        }
        request.HTTPBody = upload.dataUsingEncoding(NSUTF8StringEncoding)
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request){
            (data,resp,err) in
            if (err==nil){
                if let userInfo = (try? NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers)) as? Dictionary<String,String>{
                    if userInfo["name"]! == "fail" {
                        errMsg("Sorry", msg: "Sign up fail", vc: self)
                        return
                    }
                    else if userInfo["name"]! == "exist" {
                        errMsg("Sorry", msg: "Username exists", vc: self)
                        return
                    }
                    else {
                        dispatch_async(dispatch_get_main_queue(), { () -> Void in
                            let board = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
                            let vc = board.instantiateViewControllerWithIdentifier("main") as! UITabBarController
                            self.presentViewController(vc, animated: true, completion: { () -> Void in
                                mainVote.userData = userInfo
                                mainVote!.loadLabels()
                            })
                        })
                        return
                    }
                    
                }
                else {
                    errMsg("Error", msg: "Error loading data", vc: self)
                    return
                }
            }
            else {
                errMsg("Error", msg: (err?.localizedDescription)!, vc: self)
                return
            }
        }
        task.resume()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "DismissKeyboard:")
        view.addGestureRecognizer(tap)
        // Do any additional setup after loading the view, typically from a nib.\
    }
    
    func DismissKeyboard(recognizer: UITapGestureRecognizer){
        view.endEditing(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

