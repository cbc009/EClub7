//
//  FeelHapply_View.m
//  FeelHapply_View
//
//  Created by apple on 14-9-2.
//  Copyright (c) 2014年 dengshiru. All rights reserved.
//
#define FH_GetWithImage(a,b) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:a ofType:b]]
#import "FeelHapply_View.h"
#import "STScratchView.h"
#import "PrizeLuckiesModel.h"
#import "prize_Lucky_Reoly_model.h"
#import "DrawBoard.h"
#import "Prize_luckService.h"
@interface FeelHapply_View ()<PostPrizeidDelegate>
{
    UserInfo *user;
    Prize_luckService *prizeService;
    
}
@property (nonatomic, strong) UITableView *feelHappyTableView;
@property (nonatomic, strong) NSMutableArray *imageMuArray;
@property (nonatomic, strong) STScratchView *scratchView;
@end

@implementation FeelHapply_View
@synthesize feelHappyTableView,imageMuArray,scratchView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    SharedData *sharedData =[SharedData sharedInstance];
    user=sharedData.user;
     prizeService=[Prize_luckService new];
    UIImageView *bg_View =[[UIImageView alloc] initWithFrame:CGRectMake(0, NavigationBarFrame.size.height, DeviceFrame.size.width, DeviceFrame.size.height-NavigationBarFrame.size.height)];
    [bg_View setImage:FH_GetWithImage(@"ScratchCard", @"png")];
    
    [bg_View setContentMode:UIViewContentModeScaleToFill];
    
    UIView *view =[[UIView alloc] initWithFrame:CGRectMake(30, DeviceFrame.size.height/2+36, DeviceFrame.size.width-60, 80)];
    [bg_View addSubview:view];
  [[self view] addSubview:bg_View];

        [[self view] setBackgroundColor:[UIColor grayColor]];
        DrawBoard *d = [[DrawBoard alloc] initWithFrame:view.bounds];
        d.prize=self.luckString;
    
        d.backgroundColor = [UIColor whiteColor];
        [view addSubview:d];
        scratchView = [[STScratchView alloc] init];
        scratchView.delegate=self;
        [scratchView setContentMode:UIViewContentModeScaleAspectFit];
        [scratchView setFrame:CGRectMake(30, DeviceFrame.size.height/2+80, DeviceFrame.size.width-60, 80)];
        [scratchView setBackgroundColor:[UIColor clearColor]];
        [scratchView setSizeBrush:30.0];
    
        [[self view] addSubview:scratchView];
        [scratchView setHideView:scratchView];
        //背景——白
}

-(void)postPrizeidinView:(STScratchView*)view{
    [prizeService prizePrizeLuckiesReplyWithprize_id:self.prize_id andToken:user.token andUser_type:user.user_type inTabBarController:self.tabBarController WithDone:^(prize_Lucky_Reoly_Model_Info*model){
    }];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
