//
//  CentralManager.h
//  Peripheral
//
//  Created by apple on 15/12/17.
//  Copyright © 2017年 apple. All rights reserved.
//
#define CentralInstance [CentralManager shareInstance]

#import <Foundation/Foundation.h>
#import "BleDevice.h"

@interface CentralManager : NSObject

/** 广播中的所有外设 */
@property (nonatomic, retain) NSMutableArray <BleDevice *> *deviceList;

+ (CentralManager *)shareInstance;

- (int)deviceCountInOfGroup:(int)groupID;

//- (BleDevice *)getDeviceOfGroup:(int)groupID andIndex:(int)index;

- (NSMutableArray *)allGroupDevice; //!< 所有分好组的外设

- (int)selectedFlag; //!< 是否有选中过设备

- (NSArray *)getDeviceOfGroup:(int)groupID; //

- (NSMutableArray *)getGroupList;

- (NSArray *)remoteControlArray; // 遥控器数据
- (NSArray *)remoteBoundLightArray; // 绑定遥控器的灯
- (void)compareBle:(BleDevice *)ble;

- (int)existGroup; // 判断是否存在组

- (NSArray *)noBoundBleDeviceArray;

- (NSArray *)selelctedGroup;

- (NSArray *)getAllGroupCount;  // 获取所有的分组

- (NSArray *)getNoSetGroup; 

- (NSArray *)getGroupCount:(int)group;

@end
