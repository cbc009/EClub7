//
//  NeighborService.m
//  Club
//
//  Created by MartinLi on 14-12-8.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import "NeighborService.h"
#import "SVProgressHUD.h"
#import "SharedData.h"
#import "Login.h"
#import "SharedAction.h"
#import "MyNeighbor.h"
#import "JSONModelLib.h"
@implementation NeighborService
-(void)loadNeighborPhoneWithMId:(NSInteger )mid andSid:(NSInteger )sid andPage:(NSString *)page OnViewController:(MyneighborViewController*)viewController
{
  
    NSString *urlString = [NSString stringWithFormat:MYneighbor,mid,sid,page];
    [SVProgressHUD show];
   [MyNeighbor getModelFromURLWithString:urlString completion:^(MyNeighbor *model,JSONModelError *error){
       NSLog(@"%@",urlString);
        if (model.status == 2) {
            viewController.datas = [NSMutableArray arrayWithArray:model.info.members];
            [viewController.tableview reloadData];
            [SVProgressHUD dismiss];
        } else{
            NSLog(@"error");
           [SVProgressHUD dismiss];
        }
    }];
}
-(void)loadMoreNeighborPhoneWithMId:(NSInteger )mid andSid:(NSInteger )sid andPage:(NSString *)page OnViewController:(MyneighborViewController*)viewController
{
    NSString *urlString = [NSString stringWithFormat:MYneighbor,mid,sid,page];
    [SVProgressHUD show];
    [MyNeighbor getModelFromURLWithString:urlString completion:^(MyNeighbor *model,JSONModelError *error){
        NSLog(@"%@",urlString);
        if (model.status == 2) {
            [viewController.datas addObjectsFromArray:model.info.members];
            [viewController.tableview reloadData];
            [SVProgressHUD dismiss];
        } else{
            [SharedAction showErrorWithStatus:model.status witViewController:viewController];
        }
    }];


}
@end
