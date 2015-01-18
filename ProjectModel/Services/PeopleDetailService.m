//
//  PeopleDetailService.m
//  Club
//
//  Created by MartinLi on 15-1-13.
//  Copyright (c) 2015年 martin. All rights reserved.
//

#import "PeopleDetailService.h"
#import "SVProgressHUD.h"
#import "JSONModelLib.h"
#import "LiveModel.h"
#import "PeopleDetailViewController.h"
@implementation PeopleDetailService
-(void)LifecircleMyinfoWithMid:(NSInteger)mid andToken:(NSString *)token andUser_type:(NSInteger)user_type withTabBarController:(UITabBarController *)tabBarController witDoneObject:(doneWithObject)done;
{
    NSString *urlString = [NSString stringWithFormat:Lifecircle_Myinfo_info_URL,mid,token,user_type];
    [LiveModel getModelFromURLWithString:urlString completion:^(LiveModel *model,JSONModelError *error){
        [SharedAction commonActionWithUrl:urlString andStatus:model.status andError:model.error andJSONModelError:error andObject:model.info inTabBarController:tabBarController withDone:done];
    }];
}
-(void)countSizeWithData:(NSArray *)data inViewController:(PeopleDetailViewController *)viewController{
    for (int i=0; i<data.count; i++) {
        CGFloat lableHeight =0.0;
        CGFloat pictureHeight = 0.0;
        CGFloat cellHeight =0.0;
        DataInfo *content = data[i];
        NSInteger h = [content.content length]/16;
        lableHeight = ((h+1) * 15)+8;
        if (content.picture.count>0) {
            pictureHeight =80;
        }else{
            pictureHeight=14;
        }
        cellHeight = pictureHeight+lableHeight+16;
        [viewController.labelHeightArrar addObject:[NSString stringWithFormat:@"%f",lableHeight]];
        [viewController.cellHeightArray addObject:[NSString stringWithFormat:@"%f",cellHeight]];
    }
    [viewController.tableView reloadData];
}
@end
