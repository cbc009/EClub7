//
//  CallHistoryService.m
//  Club
//
//  Created by MartinLi on 14-12-7.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import "CallHistoryService.h"
#import "Call_history_Model.h"
#import "JSONModelLib.h"
#import "SharedAction.h"
#import "Index2NavViewController.h"
#import "AdvertPic.h"
#import "SVProgressHUD.h"
#import "AdvertPic.h"
#import "Index0Service.h"
#import "SharedData.h"
#import "Member_Login.h"
#import "WebViewController.h"
#import "MJRefresh.h"

@implementation CallHistoryService

-(void)call_historyWithToken:(NSString *)token andUser_type:(NSInteger )user_type andPageString:(NSString *)pageString inTabBarController:(UITabBarController *)tabBarController withDoneObject:(doneWithObject)done{
    NSString *urlString = [NSString stringWithFormat:Call_History_URL,token,user_type,pageString];
    [Call_history_Model getModelFromURLWithString:urlString  completion:^(Call_history_Model *object,JSONModelError *error){
        [SharedAction commonActionWithUrl:urlString andStatus:object.status andError:object.error andJSONModelError:error andObject:object.info inTabBarController:tabBarController withDone:done];
    }];
}

-(void)loadAdverPicFromUrl:(NSString *)urlString inViewController:(CallPhoneViewController *)viewController{
    [AdvertPic getModelFromURLWithString:urlString completion:^(AdvertPic *model,JSONModelError *err){
        if (model.status==2) {
            AdvertPicInfo *Info =model.info;
            Picture_Arr_advert *pictures =Info.arr_advert[0];
            NSArray *pictures1 = pictures.arr_info;
            [self loadAdPictureWithImgInfos:pictures1 InViewController:viewController];
        }else if (model.status==808){
            //如果第4个位置没有广告图就加在第1个位置的广告图
            SharedData *sharedData = [SharedData sharedInstance];
            UserInfo *user = sharedData.user;
            NSString *urlString = [NSString stringWithFormat:AdPictUrl,user.agent_id,1];
            [self loadAdverPicFromUrl:urlString inViewController:viewController];
        }else{
            [SharedAction showErrorWithStatus:model.status andError:model.error witViewController:viewController];
        }
        
    }];
}


-(void)loadAdPictureWithImgInfos:(NSArray *)infos InViewController:(CallPhoneViewController *)viewController{
    Index0Service *index0Service = [[Index0Service alloc] init];
    viewController.pageView.imageType = UIImageUrlType;
    viewController.pageView.imgUrls = [index0Service namesFromPictures:infos];
    viewController.pageView.titles = [index0Service titlesFromPictures:infos];
    viewController.pageView.urls = [index0Service urlsFromPictures:infos];
     viewController.pageView.martinLiPageScrollViewDelegate = (id)viewController;
    viewController.pageView.height =viewController.height.constant;
    viewController.pageView.isAutoScroll = YES;
    viewController.pageView.titleIsHidden = YES;//默认为NO（可选）
   viewController.pageView.pageViewType = MLPageScrollViewAdvertiseMode;//默认是广告模式（可选）
    viewController.pageView.timeInterval = 3;//默认自动滚动图片时间为2秒（可选）
    [viewController.pageView updatePageViewInSuperView:viewController.view];

}
-(void)presentEmsViewControllerOnViewController:(UIViewController *)viewController{
    WebViewController *target = [[WebViewController alloc] initWithNibName:@"WebViewController" bundle:nil];
        [viewController.navigationController pushViewController:target animated:YES];
}

@end
