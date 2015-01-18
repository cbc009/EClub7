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
    viewController.cellHeightlArray = [[NSMutableArray alloc] init];
    viewController.labeHeightlArray = [[NSMutableArray alloc] init];
//    viewController.datas = (NSMutableArray *)model.info.data;
    //NSLog(@"viewController.datas:%@",[viewController.datas componentsJoinedByString:@"-"]);
    //label_height 发布信息的label高度
    //label1_height 回复信息的label高度
    //labeAddheight 回复信息的总label高度
    //tableViewheight tableView 的高度
    //cellHeight   里面的cell的高度
    for (int i=0; i<viewController.datas.count; i++) {
        viewController.heightArray = [[NSMutableArray alloc] init];
        CGFloat tableViewheight = 0.0;
        CGFloat label_height = 0.0;
        CGFloat pictureHeight =0.0;
        DataInfo *model = data[i];
        label_height = [NSString heightWithString:model.content font:[UIFont systemFontOfSize:12] maxSize:CGSizeMake(DeviceFrame.size.width-(84), 600)];
        
        if (model.picture.count>0) {
            pictureHeight =64;
        }else{
            pictureHeight =0;
        }
        if (model.comment.count==0){
            tableViewheight = 5;
            [viewController.heightArray addObject:[NSString stringWithFormat:@"%d",0]];
        }else {
            CGFloat cellHeight = 0.0;
            CGFloat labelHeight = 0.0;
            for (int k=0; k<model.comment.count; k++) {
            CommentInfo *object = model.comment[k];
            labelHeight = [NSString heightWithString:object.content font:[UIFont systemFontOfSize:12] maxSize:CGSizeMake(DeviceFrame.size.width-84-7, 600)]+20;
            cellHeight =cellHeight+labelHeight;
        }
         tableViewheight = tableViewheight+cellHeight;
        }
        [viewController.cellHeightlArray addObject:[NSString stringWithFormat:@"%f",label_height+75+tableViewheight+pictureHeight]];
        [viewController.labeHeightlArray addObject:[NSString stringWithFormat:@"%f",label_height]];
    }
    [viewController.tableview reloadData];
}

//修改头像图
-(void)updateHeaderImage:(UIImage *)image withCompletion:(finished)finished{
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
-(void)updateBackGroundImage:(UIImage *)image withCompletion:(finished)finished{
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
