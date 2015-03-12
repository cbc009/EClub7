//
//  ChangeLifeService.m
//  Club
//
//  Created by MartinLi on 15-3-11.
//  Copyright (c) 2015年 martin. All rights reserved.
//

#import "ChangeLifeService.h"
#import "Public_lifehall.h"
#import "JSONModelLib.h"
#import "SVProgressHUD.h"
@implementation ChangeLifeService
-(void)publiclifehallWithagentid:(NSString *)agent_id andLifehallId:(NSString *)lifehall_id inTabBarController:(UITabBarController*)tabBarController withDone:(doneWithObject)done{
    NSString *urlString =[NSString stringWithFormat:Public_Lifehall_Info_URL,agent_id,@""];
   [ Public_lifehall getModelFromURLWithString:urlString completion:^(Public_lifehall *model,JSONModelError *error){
       [SharedAction commonActionWithUrl:urlString andStatus:model.status andError:model.error andJSONModelError:error andObject:model.info inTabBarController:tabBarController withDone:done];
              }];
}
@end
