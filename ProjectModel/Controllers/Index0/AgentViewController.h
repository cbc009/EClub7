//
//  AgentViewController.h
//  Club
//
//  Created by MartinLi on 15-4-21.
//  Copyright (c) 2015年 martin. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ChangeAgentIdDeleGate<NSObject>
-(void)changeAgentId:(NSString *)agentid;
@end
@interface AgentViewController : UIViewController
- (IBAction)quxiao:(id)sender;
@property (weak,nonatomic)id<ChangeAgentIdDeleGate>delegate;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong)NSArray *datas;
@property (nonatomic,strong)NSString *titles;
@end
