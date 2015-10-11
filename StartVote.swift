//
//  StartVote.swift
//  HackVote
//
//  Created by 钟镇阳 on 10/5/15.
//  Copyright © 2015 ZhenyangZhong. All rights reserved.
//

import UIKit

class StartVote: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource{
    
    let arr = ["Academics","Recreation","Finance","Social Experience"]
    let top = 340
    @IBOutlet var aspect: UIPickerView!
    @IBAction func rem(sender: AnyObject) {
        if arrText.count==0{
            return
        }
        arrLabel[arrLabel.count-1].removeFromSuperview()
        arrText[arrText.count-1].removeFromSuperview()
        arrLabel.removeLast()
        arrText.removeLast()
        let count = arrText.count-1
        addOption.frame = CGRect(x: 20, y: top+120+120*count, width: 80, height: 30)
        remove.frame = CGRect(x: 220, y: top+120+120*count, width: 80, height: 30)
        scr.contentSize = CGSizeMake(340, CGFloat(top+200+120*count))
        v.frame = CGRect(x: 0, y: 0, width: 340, height: top+150+120*count)
    }

    @IBOutlet var remove: UIButton!
    @IBAction func confirm(sender: AnyObject) {
        if ptf.text!.isEmpty {
            let cancelAction = UIAlertAction(title: "Ok", style: .Cancel){(action) in
            }
            let alert = UIAlertController(title: "Sorry", message: "Problem title cannot be empty", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(cancelAction)
            self.presentViewController(alert, animated: true, completion: nil)
            return
        }
        if detailText.text!.isEmpty {
            let cancelAction = UIAlertAction(title: "Ok", style: .Cancel){(action) in
            }
            let alert = UIAlertController(title: "Sorry", message: "Detail description cannot be empty", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(cancelAction)
            self.presentViewController(alert, animated: true, completion: nil)
            return
        }
        if arrText.count < 2 {
            let cancelAction = UIAlertAction(title: "Ok", style: .Cancel){(action) in
            }
            let alert = UIAlertController(title: "Sorry", message: "You must add at least 2 options", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(cancelAction)
            self.presentViewController(alert, animated: true, completion: nil)
            return
        }
        VoteInProgress.dic.append([p.text!,"0"])
        vip.table.reloadData()
        var dic = Array<String>()
        for i in arrText{
            dic.append(i.text)
        }
        Vote.dic.append(dic)
        Vote.prob.append(ptf.text!)
        Vote.detail.append(detailText.text!)
        Vote.user.append(user)
    }
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int{
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        return arr.count
    }
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?{
        return arr[row]
    }
    @IBAction func add(sender: AnyObject) {
        let count = arrText.count
        let opt = UILabel(frame: CGRect(x: 20, y: top+120*count, width: 80, height: 30))
        opt.text = "Option "+String(count+1)
        v.addSubview(opt)
        arrLabel.append(opt)
        let optText = UITextView(frame: CGRect(x: 20, y: top+30+120*count, width: 280, height: 80))
        optText.text = "write here"
        optText.layer.borderWidth = CGFloat(1)
        v.addSubview(optText)
        arrText.append(optText)
        addOption.frame = CGRect(x: 20, y: top+120+120*count, width: 80, height: 30)
        remove.frame = CGRect(x: 220, y: top+120+120*count, width: 80, height: 30)
        scr.contentSize = CGSizeMake(380, CGFloat(top+200+120*count))
        v.frame = CGRect(x: 0, y: 0, width: 380, height: top+150+120*count)
    }
    @IBOutlet var scr: UIScrollView!
    @IBOutlet var v: UIView!
    var p:UILabel!
    var detail:UILabel!
    var detailText:UITextView!
    @IBOutlet var addOption: UIButton!
    var arrText = Array<UITextView>()
    var arrLabel = Array<UILabel>()
    var type:UILabel!
    
    @IBOutlet var ptf: UITextField!
    
    var dic = Array<String>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scr.frame = CGRect(x: 0, y: 0, width: 380, height: 600)
        scr.contentSize = CGSizeMake(380, 600)
        scr.autoresizesSubviews = true;
        v.autoresizesSubviews = true;
        // Do any additional setup after loading the view
        
        v.frame = CGRect(x: scr.frame.minX ,y: scr.frame.minY,width: 380,height: scr.frame.height)
        p = UILabel(frame: CGRect(x: 20, y: 20, width: 80, height: 30))
        p.text = "Problem:"
        v.addSubview(p)
        ptf.frame = CGRect(x: 120, y: 20, width: 180, height: 30)
        detail = UILabel(frame: CGRect(x: 20, y: 60, width: 180, height: 30))
        detail.text = "Detail description:"
        v.addSubview(detail)
        detailText = UITextView(frame:CGRect(x: 20, y: 90, width: 280, height: 100))
        detailText.text = "Question Here"
        detailText.layer.borderWidth = CGFloat(1)
        v.addSubview(detailText)
        type = UILabel(frame: CGRect(x: 20, y: 190, width: 200, height: 30))
        type.text = "Please Select a Type"
        v.addSubview(type)
        aspect.frame = CGRect(x: 0, y: 210, width: 300, height: 120)
        aspect.delegate = self
        aspect.dataSource = self
        addOption.frame = CGRect(x: 20, y: top, width: 80, height: 30)
        remove.frame = CGRect(x: 220, y: top, width: 80, height: 30)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
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
