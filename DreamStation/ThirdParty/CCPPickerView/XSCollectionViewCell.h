//
//  XSCollectionViewCell.h
//  DreamStation
//
//  Created by 刘佳斌 on 16/8/4.
//  Copyright © 2016年 QPP. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XSCollectionViewInfo : NSObject
@property NSString *title;

@property BOOL isSelect;
@end

@interface XSCollectionViewCell : UICollectionViewCell
-(void)updateCell:(XSCollectionViewInfo *)info;
- (void)updateCell2:(XSCollectionViewInfo *)info1 withInfo2:(XSCollectionViewInfo *)info2;
@property (strong, nonatomic) IBOutlet UIButton *btn;

@end


