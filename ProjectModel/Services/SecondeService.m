//
//  SecondeService.m
//  Club
//
//  Created by MartinLi on 14-12-21.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import "SecondeService.h"
#import "SecondeChange.h"
#import "JSONModelLib.h"
#import "SVProgressHUD.h"
#import "SecondeBuy.h"
@implementation SecondeService
-(void)loadDataWithSid:(NSInteger )sid andPage:(NSString *)page onSecondeChangeViewController:(SecondeChangeViewController *)viewController
{
    NSString *urlString =[NSString stringWithFormat:SecondChangeURL,sid,page];
    [SVProgressHUD show];
    [SecondeChange getModelFromURLWithString:urlString completion:^(SecondeChange *model,JSONModelError *error){
        NSLog(@"%@ %@",urlString,model.info);
         NSArray *value = model.info.trans;
        if (model.status==2) {
            viewController.datas = value;
            [viewController.tableview reloadData];
            [SVProgressHUD dismiss];
            }else{
                NSLog(@"%@",error);
                [SVProgressHUD showErrorWithStatus:@"数据加载失败"];
            }

    }];
}
-(void)loadBuyDataWithSid:(NSInteger )sid andPage:(NSString *)page onSecondeChangeViewController:(SecondeChangeViewController *)viewController
{
    NSString *urlString =[NSString stringWithFormat:SecondBuyChangeURL,sid,page];
    [SVProgressHUD show];
    [SecondeBuy getModelFromURLWithString:urlString completion:^(SecondeBuy *model,JSONModelError *error){
        NSLog(@"%@",urlString);
         NSArray *value = [model.info valueForKey:@"buy"];
        if (model.status==2) {
            [SVProgressHUD dismiss];
            viewController.datas = value;
            [viewController.tableview reloadData];
        }else{
            NSLog(@"%@",error);
            [SVProgressHUD showErrorWithStatus:@"数据加载失败"];
           
        }
        
    }];
}
-(void)loadMyTransDataWithMid:(NSInteger )mid andPage:(NSString *)page onMysecondeViewController:(MysecondeViewController *)viewController
{
    NSString *urlString =[NSString stringWithFormat:MySecondChangeURL,mid,page];
    [SVProgressHUD show];
    [SecondeChange getModelFromURLWithString:urlString completion:^(SecondeChange *model,JSONModelError *error){
        NSLog(@"%@,%@",urlString,model.info);
        NSArray *value = [model.info valueForKey:@"trans"];
        if (model.status==2) {
            viewController.datas = value;
            [viewController.tableview reloadData];
            [SVProgressHUD dismiss];
        }else{
            NSLog(@"%@",error);
            [SVProgressHUD showErrorWithStatus:@"数据加载失败"];
        }
        
    }];
}
-(void)loadMyBuyDataWithMid:(NSInteger )mid andPage:(NSString *)page onMysecondeViewController:(MysecondeViewController *)viewController
{
    NSString *urlString =[NSString stringWithFormat:MySecondBuyChangeURL,mid,page];
    [SVProgressHUD show];
    [SecondeChange getModelFromURLWithString:urlString completion:^(SecondeChange *model,JSONModelError *error){
        NSLog(@"%@,%@",urlString,model.info);
        NSArray *value = [model.info valueForKey:@"buy"];
        if (model.status==2) {
            viewController.datas = value;
            [viewController.tableview reloadData];
            [SVProgressHUD dismiss];
        }else{
            NSLog(@"%@",error);
            [SVProgressHUD showErrorWithStatus:@"数据加载失败"];
        }
        
    }];


}
@end
