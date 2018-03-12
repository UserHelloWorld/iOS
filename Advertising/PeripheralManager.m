//
//  PeripheralManager.m
//  Peripheral
//
//  Created by apple on 15/12/17.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "PeripheralManager.h"
#import <CoreBluetooth/CoreBluetooth.h>

@interface PeripheralManager ()<CBPeripheralManagerDelegate>
{
    int _commandFlag;
    int _countTick;
}

@property (strong, nonatomic) CBPeripheralManager *peripheralMgr;
@property (strong, nonatomic) NSTimer *timer;

@end

@implementation PeripheralManager

+ (PeripheralManager *)shareInstance {
    static PeripheralManager *peripheral = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        peripheral = [[PeripheralManager alloc] init];
    });
    return peripheral;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.peripheralMgr = [[CBPeripheralManager alloc] initWithDelegate:self queue:nil];
    }
    return self;
}

- (UInt8)getFlag
{
    _commandFlag++;
    if (_commandFlag == 0 || _commandFlag == 16) {
        _commandFlag = 1;
    }
    return (UInt8)(_commandFlag & 0x0f);
}

- (void)createTimer {
    [self stopTimer];
    _countTick = 0;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(tick) userInfo:nil repeats:YES];
}

- (void)tick {
    if (_countTick == 1) {
        [self stopTimer];
    }
}

- (void)stopTimer {
    if (self.timer != nil) {
        [self.timer invalidate];
        self.timer = nil;
    }
}

-(void)sendMsg2DeviceMax20bytes:(NSData *)data
{
    if (data.length < 1 || data == nil) {
        return;
    }
    NSMutableData *mData = [NSMutableData data];
    [mData appendData:data];
      
    if (mData.length != 20) {
        int count = 20 - (int)mData.length;
        NSMutableData *fillData = [NSMutableData data];
        UInt8 nByte = 0x00;
        for (int i = 0; i < count; i++) {
            [fillData appendBytes:&nByte length:1];
        }
        [mData appendData:fillData];
    }
    
    NSLog(@"%@",mData);
    UInt8 *buf = (UInt8 *)mData.bytes;
    
    //    buf[0] = 0xb5;
    //    buf[1] = 0x5b;
    // 第三个字节的高2bit表示数据来源，
    // 00 : - 未知
    // 01 : - ios
    // 10 : - android
    // 11 : - 遥控器
    
//    buf[2] |= 0x40;
//    buf[2] &= 0x40;
    NSString *struuid = @"";
    for(int i = 15; i >= 0; i--)
    {
        struuid = [struuid stringByAppendingFormat:@"%02X", buf[i]];
        if(i == 12 || i == 10 || i == 8 || i == 6) struuid = [struuid stringByAppendingString:@"-"];
    }
    NSString *strname = @"";
    for(int i = 16; i < 20; i++)
    {
        strname = [strname stringByAppendingFormat:@"%02X", buf[i]];
    }
    
    NSDictionary *advdata = @{CBAdvertisementDataLocalNameKey : strname, CBAdvertisementDataServiceUUIDsKey : @[[CBUUID UUIDWithString:struuid]]};
    
    if (self.peripheralMgr.isAdvertising) {
        [self.peripheralMgr stopAdvertising];
    }
    [self.peripheralMgr startAdvertising:advdata];
    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [self.peripheralMgr stopAdvertising];
//    });
    
    
}

#pragma mark = CBPeripheralManagerDelegate
- (void)peripheralManagerDidUpdateState:(CBPeripheralManager *)peripheral {
    if (peripheral.state == CBCentralManagerStatePoweredOn) {
        
    }
}

- (void)peripheralManager:(CBPeripheralManager *)peripheral central:(CBCentral *)central didSubscribeToCharacteristic:(CBCharacteristic *)characteristic {
    NSLog(@"%s %d",__func__,__LINE__);
    
}
- (void)peripheralManager:(CBPeripheralManager *)peripheral central:(CBCentral *)central didUnsubscribeFromCharacteristic:(CBCharacteristic *)characteristic {
    NSLog(@"%s %d",__func__,__LINE__);

}

- (void)peripheralManager:(CBPeripheralManager *)peripheral didReceiveReadRequest:(CBATTRequest *)request {
    NSLog(@"%s %d",__func__,__LINE__);

}

@end
