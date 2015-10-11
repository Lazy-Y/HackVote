//
//  ViewController.swift
//  HackVote
//
//  Created by 钟镇阳 on 10/5/15.
//  Copyright © 2015 ZhenyangZhong. All rights reserved.
//

import UIKit

let mainURL = "http://localhost/phpmyadmin/mywork/trojanHack/"

var vip:VoteInProgress!



class ViewController: UIViewController {
    @IBOutlet var name: UITextField!
    @IBOutlet var pass: UITextField!
    @IBAction func login(sender: AnyObject) {
        let board = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        let vc = board.instantiateViewControllerWithIdentifier("main") as! UITabBarController
        self.presentViewController(vc, animated: true, completion:nil)
        /*print("Login in start")
        let url = NSURL(string:mainURL+"login.php")
        let request = NSMutableURLRequest(URL: url!, cachePolicy: NSURLRequestCachePolicy.UseProtocolCachePolicy, timeoutInterval: 10.0)
        request.HTTPMethod = "POST"
        let upload = "name=" + name.text! + "&pass=" + pass.text!
        print(upload)
        request.HTTPBody = upload.dataUsingEncoding(NSUTF8StringEncoding)
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request){
            (data,resp,err) in
            if (err == nil){
                let str = NSString(data: data!, encoding: NSUTF8StringEncoding)
                print(str)
                if let userInfo = (try? NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers)) as? Dictionary<String,String>{
                    print(userInfo)
                    print(userInfo["name"]!)
                    if userInfo["name"]! == "fail" {
                        dispatch_async(dispatch_get_main_queue(), { () -> Void in
                            let cancelAction = UIAlertAction(title: "Ok", style: .Cancel){(action) in}
                            let alert = UIAlertController(title: "Sorry", message: "Incorrect username or password", preferredStyle: UIAlertControllerStyle.Alert)
                            alert.addAction(cancelAction)
                            self.presentViewController(alert, animated: true, completion: nil)
                        })
                        return
                    }
                    else {
                        MainVote.userData = userInfo
                        dispatch_async(dispatch_get_main_queue(), { () -> Void in
                            let board = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
                            let vc = board.instantiateViewControllerWithIdentifier("main") as! UITabBarController
                            self.presentViewController(vc, animated: true, completion: { () -> Void in
                                if let nvc = vc.viewControllers?[0] {
                                    let mvvc = (nvc as! UINavigationController).viewControllers[0] as! MainVote
                                    mvvc.loadLabels()
                                }
                            })
                        })
                        return
                    }
                    
                }
                else {
                    let cancelAction = UIAlertAction(title: "Ok", style: .Cancel){(action) in}
                    let alert = UIAlertController(title: "Error", message: "Error loading data", preferredStyle: UIAlertControllerStyle.Alert)
                    alert.addAction(cancelAction)
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        self.presentViewController(alert, animated: true, completion: nil)
                    })
                    return
                }
            }
            else {
                let cancelAction = UIAlertAction(title: "Ok", style: .Cancel){(action) in}
                let alert = UIAlertController(title: "Error", message: err?.localizedDescription, preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(cancelAction)
                self.presentViewController(alert, animated: true, completion: nil)
                return
            }
        }
        task.resume()*/
    }

    @IBAction func signUp(sender: AnyObject) {
        if name.text!.isEmpty {
            let cancelAction = UIAlertAction(title: "Ok", style: .Cancel){(action) in
            }
            let alert = UIAlertController(title: "Sorry", message: "Please fill your user name tp sign up", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(cancelAction)
            self.presentViewController(alert, animated: true, completion: nil)
            return
        }
        if pass.text!.isEmpty {
            let cancelAction = UIAlertAction(title: "Ok", style: .Cancel){(action) in
            }
            let alert = UIAlertController(title: "Sorry", message: "Please fill your password to sign up", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(cancelAction)
            self.presentViewController(alert, animated: true, completion: nil)
            return
        }
        let url = NSURL(string: mainURL+"signup.php")
        let request = NSMutableURLRequest(URL: url!, cachePolicy: NSURLRequestCachePolicy.UseProtocolCachePolicy, timeoutInterval: 10.0)
        request.HTTPMethod = "POST"
        let upload = "name=" + name.text! + "&pass=" + pass.text!
        print(upload)
        request.HTTPBody = upload.dataUsingEncoding(NSUTF8StringEncoding)
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request){
            (data,resp,err) in
            if (err==nil){
                let str = NSString(data: data!, encoding: NSUTF8StringEncoding)
                print(str)
                if let userInfo = (try? NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers)) as? Dictionary<String,String>{
                    print(userInfo)
                    print(userInfo["name"]!)
                    if userInfo["name"]! == "fail" {
                            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                            let cancelAction = UIAlertAction(title: "Ok", style: .Cancel){(action) in}
                            let alert = UIAlertController(title: "Sorry", message: "Sign up fail, please try again", preferredStyle: UIAlertControllerStyle.Alert)
                            alert.addAction(cancelAction)
                            self.presentViewController(alert, animated: true, completion: nil)
                        })
                        return
                    }
                    else if userInfo["name"]! == "exist" {
                        dispatch_async(dispatch_get_main_queue(), { () -> Void in
                            let cancelAction = UIAlertAction(title: "Ok", style: .Cancel){(action) in}
                            let alert = UIAlertController(title: "Sorry", message: "The username has existed", preferredStyle: UIAlertControllerStyle.Alert)
                            alert.addAction(cancelAction)
                            self.presentViewController(alert, animated: true, completion: nil)
                        })
                        return
                    }
                    else {
                        MainVote.userData = userInfo
                        dispatch_async(dispatch_get_main_queue(), { () -> Void in
                            let board = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
                            let vc = board.instantiateViewControllerWithIdentifier("main") as! UITabBarController
                            self.presentViewController(vc, animated: true, completion: { () -> Void in
                                if let nvc = vc.viewControllers?[0] {
                                    let mvvc = (nvc as! UINavigationController).viewControllers[0] as! MainVote
                                    mvvc.loadLabels()
                                }
                            })
                        })
                        return
                    }
                    
                }
                else {
                    let cancelAction = UIAlertAction(title: "Ok", style: .Cancel){(action) in}
                    let alert = UIAlertController(title: "Error", message: "Error loading data", preferredStyle: UIAlertControllerStyle.Alert)
                    alert.addAction(cancelAction)
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        self.presentViewController(alert, animated: true, completion: nil)
                    })
                    return
                }
            }
            else {
                let cancelAction = UIAlertAction(title: "Ok", style: .Cancel){(action) in
                }
                let alert = UIAlertController(title: "Error", message: err?.localizedDescription, preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(cancelAction)
                self.presentViewController(alert, animated: true, completion: nil)
                return
            }
        }
        task.resume()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

