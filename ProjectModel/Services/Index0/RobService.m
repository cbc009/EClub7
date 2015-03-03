//
//  RobService.m
//  Club
//
//  Created by dongway on 14-8-19.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import "RobService.h"
#import "SVProgressHUD.h"
#import "RobModel.h"
#import "NSString+MT.h"
#import "Status.h"
#import "SharedData.h"
#import "Member_Login.h"
#import "Member_History.h"
#import "JSONModelLib.h"
#import "Rob_goods_history.h"
#import "NSString+MT.h"
#import "AdvertPic.h"
#import "MartinLiPageScrollView.h"
#import "Index0Service.h"
#import "SharedAction.h"
@implementation RobService

-(void)setRobModelWithToken:(NSString *)token andUser_type:(NSInteger )user_type inRootTabBarController:(UITabBarController *)tabBarController withDone:(doneWithObject)done{
    [SVProgressHUD showWithStatus:@"正在加载今日抢菜数据......"];
      NSString *urlString = [NSString stringWithFormat:Rob_Index_URL,token,user_type];
    [RobModel getModelFromURLWithString:urlString completion:^(RobModel *model,JSONModelError *error){
        [SharedAction commonActionWithUrl:urlString andStatus:model.status andError:model.error andJSONModelError:error andObject:model inTabBarController:tabBarController withDone:done];
    }];
}

-(void)setItemInfosWithController:(RobViewController *)viewController andGoodModel:(RobModelInfo *)good{
    NSString *startTime =@"1425366826";
    viewController.robModel = good;
    viewController.itemImage.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IP,good.picture]]]];
    viewController.itemPic =[NSString stringWithFormat:@"%@%@",IP,good.picture];
    viewController.date.text = [NSString stringWithFormat:@"%@",good.qiang];
    viewController.itemNameLabel.text = good.name;
    viewController.itemPastPriceLabel.text = [NSString stringWithFormat:@"原   价: %@元/%@",good.price,good.unit];
    NSString *discount = good.discount;
    if ([discount floatValue] == 0){
        viewController.discount.text = [NSString stringWithFormat:@"抢购价:%@ E币",good.point];
    }else{
        viewController.discount.text = [NSString stringWithFormat:@"抢购价:%@",discount];
    }
    viewController.itemCount.text = [NSString stringWithFormat:@"抢购总数量：%@%@",good.nums,good.unit];
    NSString *startTime2 = [NSString timeType1FromStamp:startTime];//yyyy-MM-dd HH:mm:ss
    if ([SharedAction notifyTime2:startTime2]) {
        return ;
    }else{
    NSString *notifyTime = [NSString dateStringByAddTimeInterval:-120 fromDateString:startTime2 withDateFormatter:@"yyyy-MM-dd HH:mm:ss"];
    NSLog(@"notifyTime:%@,startTime2:%@",notifyTime,startTime2);
    [SharedAction setLocalNotifyWithAlertBody:[NSString stringWithFormat:@"%@抢菜时间马上就到了,请留意哦",startTime2] andType:@"rob" andFireDate:notifyTime];
    }
}


/*
 加载广告图片
 */
-(void)loadAdverPicWithPos:(NSInteger)pos inViewController:(RobViewController *)viewController{
    SharedData *sharedData = [SharedData sharedInstance];
    UserInfo *user = sharedData.user;
    NSString *urlString = [NSString stringWithFormat:AdPictUrl,user.city,3];
    [self loadAdverPicFromUrl:urlString inViewController:viewController];
}

-(void)loadAdverPicFromUrl:(NSString *)urlString inViewController:(RobViewController *)viewController{
    [AdvertPic getModelFromURLWithString:urlString completion:^(AdvertPic *model,JSONModelError *err){
        if (model.status) {
            NSArray *pictures = model.info.picture;
            [self loadAdPictureWithImgInfos:pictures InViewController:viewController];
        }else{
            [SharedAction showErrorWithStatus:model.status andError:model.error witViewController:viewController];
        }
    }];
}

-(void)loadAdPictureWithImgInfos:(NSArray *)infos InViewController:(RobViewController *)viewController{
    Index0Service *index0Service = [[Index0Service alloc] init];
    viewController.pageView.imageType = UIImageUrlType;
    viewController.pageView.imgUrls = [index0Service namesFromPictures:infos];
    viewController.pageView.titles = [index0Service titlesFromPictures:infos];
    viewController.pageView.urls = [index0Service urlsFromPictures:infos];
    viewController.pageView.timeInterval = 3;//默认自动滚动图片时间为2秒（可选）
    viewController.pageView.isAutoScroll = YES;
    viewController.pageView.titleIsHidden = YES;//默认为NO（可选）
    viewController.pageView.height = viewController.height.constant;
    viewController.pageView.martinLiPageScrollViewDelegate = (id)viewController;
    viewController.pageView.pageViewType = MLPageScrollViewAdvertiseMode;//默认是广告模式（可选）
    [viewController.pageView updatePageViewInFatherController:viewController];//（必填）//位置置于后面
    viewController.pageView.defaultLocationIndex = 0;
}

//开抢
-(void)robWithToken:(NSString *)token andUser_type:(NSInteger )user_type andRobModel:(RobModelInfo *)robModel inTabBarController:(UITabBarController *)tabBarController withDone:(doneWithObject)done{
    if ([robModel.starttime compareCurrentTimeWith:robModel.starttime]==NSOrderedDescending) {
        [SVProgressHUD showErrorWithStatus:@"未到抢菜时间"];
    }else{
        [SVProgressHUD showWithStatus:@"正在努力抢菜中......."];
        NSString *gid = robModel.gid;
        NSString *urlString = [NSString stringWithFormat:Rob_Robuy_Order_URL,token,user_type,gid];
        [Status getModelFromURLWithString:urlString completion:^(Status *model,JSONModelError *error){
            [SharedAction commonActionWithUrl:urlString andStatus:model.status andError:model.error andJSONModelError:error andObject:model inTabBarController:tabBarController withDone:done];
        }];
    }
}





@end
