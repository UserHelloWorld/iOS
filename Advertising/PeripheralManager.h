//
//  PeripheralManager.h
//  Peripheral
//
//  Created by apple on 15/12/17.
//  Copyright © 2017年 apple. All rights reserved.
//

#define PeripheralInstance [PeripheralManager shareInstance]

#import <Foundation/Foundation.h>

@interface PeripheralManager : NSObject

+ (PeripheralManager *)shareInstance;

- (void)sendMsg2DeviceMax20bytes:(NSData *)data;


@end
