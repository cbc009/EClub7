//
//  UserDefaults.m
//  Club
//
//  Created by dongway on 14-8-11.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import "UserDefaults.h"
#import "InternetRequest.h"
@implementation UserDefaults

-(id)init
{
    if(self = [super init])
    {
        
        self.userDefaults1 = [NSUserDefaults standardUserDefaults];
        
    }
    return self;
}


-(void)ChangeNickName:(NSString *)nickname onChangeNameViewController:(ChangeNameViewController *)viewController
{
    [self.userDefaults1 setObject:nickname forKey:@"nickname"];
    [self.userDefaults1 synchronize];

    
}
-(void)ChangeAddressgo:(NSString *)address onChangeAddress:(ChangeAdressViewController *)viewController
{
    [self.userDefaults1 setObject:address forKey:@"address"];
    [self.userDefaults1 synchronize];

}



@end
