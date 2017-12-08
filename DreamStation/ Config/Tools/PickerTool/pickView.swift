//
//  pickView.swift
//  ImagePickerDemo
//
//  Created by 刘佳斌 on 16/8/25.
//  Copyright © 2016年 xiaosi. All rights reserved.
//

import UIKit

class pickView:NSObject,UIImagePickerControllerDelegate ,UINavigationControllerDelegate{

    var block:passParameterBlock!
    var picker:UIImagePickerController = UIImagePickerController()

    internal override init(){
        super.init()
        self.picker.delegate=self
    }

    func showLocalPhotoWithController(controller:UIViewController,block:passParameterBlock){
        self.block = block
        self.picker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        controller.presentViewController(self.picker, animated: true, completion: nil)
    }
    
    func showTakePhotoWithController(controller:UIViewController,block:passParameterBlock){
        
        self.block = block
        
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera){
            self.picker.sourceType=UIImagePickerControllerSourceType.Camera
            controller.presentViewController(self.picker, animated: true, completion: nil)
        }else{
            print("不支持")
        }
    }

    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        let gotImage=info[UIImagePickerControllerOriginalImage]as! UIImage
        self.block(self.imageWithImageSimple(gotImage, scaledToSize: CGSizeMake(600, 600)))
        picker.dismissViewControllerAnimated(true, completion: nil)
    }

    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    //缩放图片
    func imageWithImageSimple(image:UIImage,scaledToSize newSize:CGSize)->UIImage
        
    {
        UIGraphicsBeginImageContext(newSize);
        image.drawInRect(CGRectMake(0,0,newSize.width,newSize.height))
        let newImage:UIImage=UIGraphicsGetImageFromCurrentImageContext()!;
        UIGraphicsEndImageContext();
        return newImage;
    }

}
