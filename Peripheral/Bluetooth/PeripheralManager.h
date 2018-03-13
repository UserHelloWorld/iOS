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

@property (assign, nonatomic) int serialNumber; //!< 序列号

- (void)ble_testA:(UInt8)a B:(UInt8)b;

+ (PeripheralManager *)shareInstance;

- (void)ble_setGroup:(BleDevice *)ble group:(int)groupID;

- (void)ble_disbandGroup:(BleDevice *)dev ;

- (void)ble_switch:(BleDevice *)dev mask:(UInt8)mask onOff:(int)onOff;

- (void)ble_switchMask:(UInt8)mask;

- (void)ble_setWarm:(UInt8)w cold:(UInt8)c mask:(UInt8)mask;

- (void)ble_setRGB:(BleDevice *)dev mask:(UInt8)mask R:(UInt8)R G:(UInt8)G B:(UInt8)B ;

- (void)ble_setRGB:(UInt8)rgb;

@end
