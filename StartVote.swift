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
        scr.contentSize = CGSizeMake(340, CGFloat(top+400+120*count))
        v.frame = CGRect(x: 0, y: 0, width: 340, height: top+350+120*count)
    }

    @IBOutlet var remove: UIButton!
    
    private func getRow(row:Int)->String{
        switch row{
        case 0:
            return "academic"
        case 1:
            return "recreation"
        case 2:
            return "finance"
        default:
            return "social"
        }
    }
    
    private func checkConfirm()->Bool{
        if ptf.text!.isEmpty {
            errMsg("Sorry", msg: "Problem title cannot be empty", vc: self)
            return false
        }
        if detailText.text!.isEmpty {
            errMsg("Sorry", msg: "Detail description cannot be empty", vc: self)
            return false
        }
        if arrText.count < 2 {
            errMsg("Sorry", msg: "You must add at least 2 options", vc: self)
            return false
        }
        return true
    }
    
    //upload: owner, problem, detail, type, options
    private func upload()->String?{
        var check = true
        var str = "owner=" + mainVote.userData["name"]! + "&problem=" + ptf.text! + "&detail=" + detailText.text!
        str += "&type=" + getRow(aspect.selectedRowInComponent(0))
        str += "&options="
        for item in arrText{
            str+=item.text!+"§"
            if (!checkValidStr(item.text!)){
                check = false
            }
        }
        if (!checkValidStr(ptf.text!))||(!checkValidStr(detailText.text!)) {
            check = false
        }
        str.removeAtIndex(str.endIndex.predecessor())
        if !check{
            return nil
        }
        else {
            return str
        }
    }
    
    private func setVote(dic:NSDictionary){
        vip.dic.addObject([self.ptf.text!,"0"])
        vip.table.reloadData()
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            self.navigationController?.popViewControllerAnimated(true)
        })
    }
    
    @IBAction func confirm(sender: AnyObject) {
        if !checkConfirm(){
            return
        }
        let request = newPostRequest(upload(),url: "post.php")
        if request == nil{
            return
        }
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request!){
            (data,resp,err) in
            connect(data, resp: resp, err: err, myTask:self.setVote, vc: self)
        }
        task.resume()
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
        scr.contentSize = CGSizeMake(380, CGFloat(top+400+120*count))
        v.frame = CGRect(x: 0, y: 0, width: 380, height: top+350+120*count)
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
    
    @IBOutlet var ptf: UITextView!
    
    var dic = Array<String>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scr.frame = CGRect(x: 0, y: 0, width: 380, height: 600)
        scr.contentSize = CGSizeMake(380, 600)
        scr.autoresizesSubviews = true;
        v.autoresizesSubviews = true;
        // Do any additional setup after loading the view
        
        v.frame = CGRect(x: scr.frame.minX ,y: scr.frame.minY,width: 380,height: scr.frame.height+300)
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
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "DismissKeyboard:")
        view.addGestureRecognizer(tap)
        
    }
    
    
    func DismissKeyboard(recognizer: UITapGestureRecognizer){
        view.endEditing(true)
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
    
    private var activeField:UITextField?
    
    func registerForKeyboardNotifications()
    {
        //Adding notifies on keyboard appearing
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWasShown:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillBeHidden:", name: UIKeyboardWillHideNotification, object: nil)
    }
    
    
    func deregisterFromKeyboardNotifications()
    {
        //Removing notifies on keyboard appearing
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func keyboardWasShown(notification: NSNotification)
    {
        //Need to calculate keyboard exact size due to Apple suggestions
        self.scr.scrollEnabled = true
        let info : NSDictionary = notification.userInfo!
        let keyboardSize = (info[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue().size
        let contentInsets : UIEdgeInsets = UIEdgeInsetsMake(0.0, 0.0, keyboardSize!.height, 0.0)
        
        self.scr.contentInset = contentInsets
        self.scr.scrollIndicatorInsets = contentInsets
        
        var aRect : CGRect = self.view.frame
        aRect.size.height -= keyboardSize!.height
        if let _ = activeField
        {
            if (!CGRectContainsPoint(aRect, activeField!.frame.origin))
            {
                self.scr.scrollRectToVisible(activeField!.frame, animated: true)
            }
        }
        
        
    }
    
    
    func keyboardWillBeHidden(notification: NSNotification)
    {
        //Once keyboard disappears, restore original positions
        let info : NSDictionary = notification.userInfo!
        let keyboardSize = (info[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue().size
        let contentInsets : UIEdgeInsets = UIEdgeInsetsMake(0.0, 0.0, -keyboardSize!.height, 0.0)
        self.scr.contentInset = contentInsets
        self.scr.scrollIndicatorInsets = contentInsets
        self.view.endEditing(true)
        self.scr.scrollEnabled = false
        
    }
    
    func textFieldDidBeginEditing(textField: UITextField)
    {
        activeField = textField
    }
    
    func textFieldDidEndEditing(textField: UITextField)
    {
        activeField = nil
    }
}
