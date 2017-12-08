//
//  DSCollectionViewController+changeMark.swift
//  DreamStation
//
//  Created by xjb on 2016/12/27.
//  Copyright © 2016年 QPP. All rights reserved.
//

import UIKit

extension DSCollectionViewController {
 
    func addChangeMarkView(){
        SMAlertView.showAlertWithInputNumView("", title: "请填写备注", cancleTitle: "取消", okTitle: "完成", delegate: self)
    }
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        if buttonIndex == 1 {
            let textField:UITextField = alertView.textFieldAtIndex(0)!
            self.changeMark = textField.text!
            self.httpChangeMark()
        }
    }
    //MARK:--------我的约谈--------
    func httpChangeMark(){
        let cmd:HttpCommand=DSHttpChangeMarkCmd.httpCommandWithVersion(PHttpVersion_v1)
        let block:httpBlock = {[weak self](result:RequestResult!,userInfo:AnyObject!)->() in
            self?.httpChangeMarkResponse(result)
        }
        let dic:NSMutableDictionary = NSMutableDictionary()
        dic[kHttpParamKey_ChangeMark_id] = self.changeid
        dic[kHttpParamKey_ChangeMark_mark] = self.changeMark
        cmd.requestInfo = dic as [NSObject:AnyObject]
        let completeDelegate:SMBaseHttpComplete=SMBaseHttpComplete.init(block: block, withUserInfo: nil)
        cmd.completeDelegate=completeDelegate
        print("url == %@",cmd.getUrl())
        cmd.execute()
    }
    func httpChangeMarkResponse(result:RequestResult){
        let r:DSHttpChangeMarkRecule = result as! DSHttpChangeMarkRecule
        if r.isOk() {
           //SMToast("备注填写成功！")
           upPullLoadData()
        }else{
            SMToast("请查看当前网络状态！")
        }
    }
    
    
}
