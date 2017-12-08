//
//  DSHotDetailViewController+CollectMark.swift
//  DreamStation
//
//  Created by K.E. on 16/9/20.
//  Copyright © 2016年 QPP. All rights reserved.
//

import UIKit

extension DSHotDetailViewController {

    func collectionViewShow(){
            let collectionView=DSAddCollectMarkView.init(frame: CGRectMake(0, 0, SCREEN_WHIDTH(), SCREEN_HEIGHT()))
            collectionView.show()
            collectionView.collectMarkCancelBlock = {

                collectionView.removeFromSuperview()
                
            }
            collectionView.collectMarkSureBlock = {
                [weak self]in
                self!.collectionMessage=collectionView.collectTV.text
                collectionView.removeFromSuperview()
                self!.httpCollectionsRequire()//实现收藏

            }
    }

}
