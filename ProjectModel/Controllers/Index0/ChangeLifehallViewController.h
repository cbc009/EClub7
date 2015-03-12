//
//  ChangeLifehallViewController.h
//  Club
//
//  Created by MartinLi on 15-3-11.
//  Copyright (c) 2015年 martin. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ChangeLifehallDelegate <NSObject>
-(void)changeLifeId:(NSString *)lifeHallId andLifeHallName:(NSString *)lifehallName;
@end
@interface ChangeLifehallViewController : UIViewController
@property(nonatomic,retain)id<ChangeLifehallDelegate>delegate;

@property (weak, nonatomic) IBOutlet UIPickerView *changePick;
@property (nonatomic,strong)NSArray *pickData;
@property (nonatomic,strong)NSArray *pickArray;
@end
