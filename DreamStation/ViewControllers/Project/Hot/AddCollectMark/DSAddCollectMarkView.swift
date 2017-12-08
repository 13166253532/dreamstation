//
//  DSFifthTableViewCell.swift
//  DreamStation
//
//  Created by K.E on 16/9/20.
//  Copyright © 2016年 QPP. All rights reserved.
//

import UIKit


class DSAddCollectMarkView: UIView ,UITextViewDelegate{

    
    @IBOutlet var sureBtn: UIButton!
    @IBOutlet var cancelBtn: UIButton!
    @IBOutlet var collectMarkView: UIView!
    @IBOutlet var bottomLay: NSLayoutConstraint!
    var view: UIView!
    @IBOutlet var collectTV: UITextView!
    
    var collectMarkCancelBlock : selectBlock!
    var collectMarkSureBlock : selectBlock!
    
    @IBAction func collectMarkCancel(sender: AnyObject) {
        collectMarkCancelBlock()
    }
    @IBAction func collectMarkSure(sender: AnyObject) {
        collectMarkSureBlock()
    }
    
    func textViewShouldBeginEditing(textView: UITextView) -> Bool {
        if textView.text == "对项目做备注，方便日后管理跟进的项目（选填）" {
            textView.text = ""
            textView.textColor = UIColor.blackColor()
        }
        return true
    }
    func textViewDidEndEditing(textView: UITextView) {
        textView .resignFirstResponder()
    }
    func addKeyboardNotification() {
    
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(DSAddCollectMarkView.keyboardHide(_:)), name: UIKeyboardWillHideNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(DSAddCollectMarkView.keyboardShow(_:)), name: UIKeyboardWillShowNotification, object: nil)
    
    }
    func keyboardHide(note: NSNotification) {
        self.bottomLay.constant = 0
        
        
    }
    func keyboardShow(note: NSNotification) {
        let keyboardinfo = note.userInfo![UIKeyboardFrameBeginUserInfoKey]
        let keyboardheight:CGFloat = (keyboardinfo?.CGRectValue.size.height)!
        UIView.animateWithDuration(0.5) { 
            self.bottomLay.constant = keyboardheight
        }
    }

    func loadViewFfromNib() -> UIView {
        let bundle = NSBundle(forClass: self.dynamicType)
        let nib = UINib(nibName: String(self.dynamicType), bundle: bundle)
        let view = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
        return view
    } // setup view's auto resize to fill parent, and add a % view to input view
    
    func setupSubviews() {
        view = loadViewFfromNib()
        view.backgroundColor=UIColor.blackColor().colorWithAlphaComponent(0.5)
        view.autoresizingMask = [UIViewAutoresizing.FlexibleWidth, UIViewAutoresizing.FlexibleHeight]
        addSubview(view)
        
        
        
    } // reset subview's frame
    override func layoutSubviews() {
        view.frame = bounds
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupSubviews()
        addKeyboardNotification()
        setUI()
        
    }
    func setUI() {
        collectMarkView.backgroundColor = kRGBA(240, g: 240, b: 240, a: 1.0)
        cancelBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Left
        sureBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Right
        self.collectTV.text="对项目做备注，方便日后管理跟进的项目（选填）"
        //UIControlContentHorizontalAlignmentLeft;

    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupSubviews()
    }
    
    func show(){
         UIApplication.sharedApplication().keyWindow?.addSubview(self)
    }
    
    func dissmiss(){
        self.collectTV.resignFirstResponder()
        self.removeFromSuperview()
    }
    
    deinit{
        
        print("------------------------------")
        print(NSStringFromClass(self.classForCoder)+"释放")
        print("------------------------------")
    }


}


