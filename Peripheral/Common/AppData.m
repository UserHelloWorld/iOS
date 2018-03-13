//
//  AppData.m
//  Peripheral
//
//  Created by apple on 29/12/17.
//  Copyright © 2017年 apple. All rights reserved.
//

#define GroupName @"GroupName"

#import "AppData.h"

@implementation AppData

+ (NSArray *)getGroupNameArray {
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    return [user objectForKey:GroupName];
}
+ (void)saveGroupNameArray:(NSArray *)array
{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    [user setObject:array forKey:GroupName];
    [user synchronize];
}

@end
