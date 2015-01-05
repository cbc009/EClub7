//
//  MainItemLayout.m
//  Club
//
//  Created by Gao Huang on 14-12-3.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import "MainItemLayout.h"

@implementation MainItemLayout

-(id)init
{
    if (self = [super init])
    {
        self.itemSize = CGSizeMake(65, 90);
        self.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
        self.minimumInteritemSpacing = 10.0f;
        self.minimumLineSpacing = 10.0f;
    }
    return self;
}

@end
