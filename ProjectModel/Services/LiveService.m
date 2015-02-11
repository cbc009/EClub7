//
//  LiveService.m
//  Club
//
//  Created by MartinLi on 14-12-26.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import "LiveService.h"
#import "SVProgressHUD.h"
#import "JSONModelLib.h"
#import "LiveModel.h"
#import "BodyCell.h"
#import "NSString+MT.h"
@implementation LiveService
-(void)loadLiveDataWithToken:(NSString *)token andUser_type:(NSInteger )user_type andPageString:(NSString *)pageString withTabBarViewController:(UITabBarController*)tabBarController doneObject:(doneWithObject)done
{
    NSString *urlString = [NSString stringWithFormat:LiveURL,token,user_type,pageString];
    [LiveModel getModelFromURLWithString:urlString completion:^(LiveModel *model,JSONModelError *error){
        [SharedAction commonActionWithUrl:urlString andStatus:model.status andError:model.error andJSONModelError:error andObject:model.info inTabBarController:tabBarController withDone:done];
    }];
}
-(void)countSizeWithData:(NSMutableArray *)data inViewController:(LiveViewController *)viewController{

}

//修改头像图
-(void)updateHeaderImage:(UIImage *)image inTabBarController:(UITabBarController *)tabBarController withCompletion:(finished)finished{
    SharedData *sharedData = [SharedData sharedInstance];
    UserInfo *user = sharedData.user;
    NSString *user_type = [NSString stringWithFormat:@"%ld",(long)user.user_type];
    NSMutableDictionary *parameters = (NSMutableDictionary *)@{@"token":user.token,@"user_type":user_type};
    [SharedAction callAPI:[NSString stringWithFormat:@"%@%@",IP,@"/wap.php/Base/head"] parameters:parameters name:@"picture" image:image withCompletion:^(BOOL complete,NSDictionary *info){
        if (complete) {
            finished(info);
        }
    }];
}
//修改背景图
-(void)updateBackGroundImage:(UIImage *)image inTabBarController:(UITabBarController *)tabBarController withCompletion:(finished)finished{
    SharedData *sharedData = [SharedData sharedInstance];
    UserInfo *user = sharedData.user;
    NSString *user_type = [NSString stringWithFormat:@"%ld",(long)user.user_type];
    NSMutableDictionary *parameters = (NSMutableDictionary *)@{@"token":user.token,@"user_type":user_type};
    [SharedAction callAPI:[NSString stringWithFormat:@"%@%@",IP,@"/wap.php/Lifecircle/life_backpic"] parameters:parameters name:@"picture" image:image withCompletion:^(BOOL complete,NSDictionary *info){
        if (complete) {
            finished(info);
        }
    }];
}
-(void)deleteCellInLiveViewController:(LiveViewController *)viewController atIndexPath:(NSIndexPath *)indexPath{
    NSUInteger row = indexPath.row;
    NSArray *cells = [[NSArray alloc] initWithObjects:indexPath, nil];
    [viewController.tableview beginUpdates];
    [viewController.datas removeObjectAtIndex:row];
    [viewController.tableview deleteRowsAtIndexPaths:cells withRowAnimation: UITableViewRowAnimationLeft];
    [viewController.tableview endUpdates];
}
@end
