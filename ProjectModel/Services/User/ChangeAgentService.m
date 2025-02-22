//
//  ChangeAgentService.m
//  Club
//
//  Created by MartinLi on 15-4-21.
//  Copyright (c) 2015年 martin. All rights reserved.
//

#import "ChangeAgentService.h"
#import "Province_Info.h"
#import "SVProgressHUD.h"
#import "JSONModelLib.h"
#import "Agent_Info.h"
@implementation ChangeAgentService
-(void)publicProvinceInfoWithType:(NSString*)type withDone:(doneWithObject)done{
    [SVProgressHUD show];
    NSString *urlString =[NSString stringWithFormat:Public_Province_Info_URL,type];
    NSLog(@"%@",urlString);
    [Province_Info getModelFromURLWithString:urlString completion:^(Province_Info *model,JSONModelError *error){
        [SVProgressHUD dismiss];
        if (model.status==2) {
            done(model.info);
        }else{
            [SVProgressHUD showErrorWithStatus:model.error];
        }
    }];
}
-(void)publicAgentInfoWithProvionecId:(NSString*)provinceId withDone:(doneWithObject)done{
    [SVProgressHUD show];
    NSString *urlString =[NSString stringWithFormat:Public_Agent_Info_URL,provinceId];
       NSLog(@"%@",urlString);
    [Agent_Info getModelFromURLWithString:urlString completion:^(Agent_Info *model,JSONModelError *error){
        [SVProgressHUD dismiss];
        if (model.status==2) {
            done(model.info);
        }else{
            [SVProgressHUD showErrorWithStatus:model.error];
        }
        
    }];
}
@end
