//
//  SNPhotoBrowserTool.m
//  soccernotes
//
//  Created by sqb on 15/9/14.
//  Copyright (c) 2015年 sqp. All rights reserved.
//

#import "SNPhotoBrowserTool.h"
#import "UIImageView+WebCache.h"
#import "PBViewController.h"
#import "PBViewControllerDataSource.h"
#import "PBImageScrollerViewController.h"
#import "PBViewControllerDelegate.h"

@interface SNPhotoBrowserTool ()<PBViewControllerDataSource, PBViewControllerDelegate>

@property NSArray* originDataArray;
@end
@implementation SNPhotoBrowserTool

+(SNPhotoBrowserTool*)showPhotoBrowser:(NSInteger)index originData:(NSArray*)originArray containerVC:(UIViewController*)containerVC
{
    SNPhotoBrowserTool * pbTool = [SNPhotoBrowserTool new];
    pbTool.originDataArray = originArray;
    [pbTool showPhotoBrowser:containerVC initIndex:index];
    
    return pbTool;
}

- (void)showPhotoBrowser:(UIViewController*)vc initIndex:(NSInteger)index{
    
    PBViewController *pbViewController = [PBViewController new];
    pbViewController.pb_dataSource = self;
    pbViewController.pb_delegate = self;
    [pbViewController setInitializePageIndex:index];
    [vc presentViewController:pbViewController animated:YES completion:nil];
}

#pragma mark - PBViewControllerDataSource

- (NSInteger)numberOfPagesInViewController:(PBViewController *)viewController {
    return self.originDataArray.count;
}

//- (UIImage *)viewController:(PBViewController *)viewController imageForPageAtIndex:(NSInteger)index {
//    NSString *name = [NSString stringWithFormat:@"%@.jpg", @(index+1)];
//    return [UIImage imageNamed:name];
//}

- (void)viewController:(PBViewController *)viewController presentImageView:(UIImageView *)imageView forPageAtIndex:(NSInteger)index {
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        NSString *name = [NSString stringWithFormat:@"%@.jpg", @(index+1)];
//        UIImage *image = [UIImage imageNamed:name];
//        imageView.image = image;
//    });
    
    NSString *str=self.originDataArray[index];
    [imageView sd_setImageWithURL:[NSURL URLWithString:str] placeholderImage:[UIImage imageNamed:@"testImage"]];
   
    
//    SNImageModel * model = self.originDataArray[index];
//    [imageView setImageWithURL:[NSURL URLWithString:model.thumbImage] placeholderImage:HOLDER_IMAGE];
    
    
    
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        SNImageModel * model = self.originDataArray[index];
//        NSString *path =  model.thumbImage;
//        NSData *data = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:path] options:0 error:nil];
//        UIImage *image = [[UIImage alloc] initWithData:data];
//        dispatch_async(dispatch_get_main_queue(), ^{
//            // 主线程
//            imageView.image = image;
//        });
//    });
}

#pragma mark - PBViewControllerDelegate

- (void)viewController:(PBViewController *)viewController didSingleTapedPageAtIndex:(NSInteger)index presentedImage:(UIImage *)presentedImage {
    NSLog(@"didSingleTapedPageAtIndex: %@", @(index));
    [viewController.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewController:(PBViewController *)viewController didLongPressedPageAtIndex:(NSInteger)index presentedImage:(UIImage *)presentedImage {
    NSLog(@"didLongPressedPageAtIndex: %@", @(index));
}

//+(SNPhotoBrowserTool*)showPhotoBrowser:(NSInteger)index originData:(NSArray<SNImageModel>*)originArray containerView:(UIView*)containerView
//{
//    SNPhotoBrowserTool * pbTool = [SNPhotoBrowserTool new];
//    [pbTool showImage:index originData:originArray containerView:containerView];
//
//    return pbTool;
//}
//
//#pragma mark image group view
//- (void)showImage:(NSInteger)index originData:(NSArray<SNImageModel>*)originArray containerView:(UIView*)containerView
//{
//    self.originDataArray = originArray;
//    //启动图片浏览器
//    HZPhotoBrowser *browserVc = [[HZPhotoBrowser alloc] init];
//    browserVc.sourceImagesContainerView = containerView; // 原图的父控件
//    browserVc.imageCount = originArray.count; // 图片总数
//    browserVc.currentImageIndex = (int)index;
//    browserVc.delegate = self;
//    [browserVc show];
//}
//
//#pragma mark - photobrowser代理方法
//- (UIImage *)photoBrowser:(HZPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index
//{
//    return HOLDER_IMAGE;
//}
//
//- (NSURL *)photoBrowser:(HZPhotoBrowser *)browser highQualityImageURLForIndex:(NSInteger)index
//{
//    SNImageModel * cur = [self originDataArray][index];
//    NSLog(@"%@",cur.thumbImage);
//    NSURL * url = [NSURL URLWithString:cur.thumbImage];
//    return url;
//}
//
@end
