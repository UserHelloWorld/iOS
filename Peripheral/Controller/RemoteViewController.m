
//
//  RemoteViewController.m
//  Peripheral
//
//  Created by apple on 06/01/18.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "RemoteViewController.h"

@interface RemoteViewController ()

@end

@implementation RemoteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}


- (IBAction)btnClick:(UIButton *)sender
{
    
    
    switch (sender.tag) {
        case 1:
        {
            [PeripheralInstance ble_testA:0x05 B:0x01];
        }
            break;
        case 2:
        {
            [PeripheralInstance ble_testA:0x04 B:0x02];
            
        }
            break;
        case 3:
        {
            [PeripheralInstance ble_testA:0x0A B:0x03];
            
        }
            break;
        case 4:
        {
            [PeripheralInstance ble_testA:0x03 B:0x00];
            
        }
            break;
        case 5:
        {
            [PeripheralInstance ble_testA:0x06 B:0x01];
            
        }
            break;
        case 6:
        {
            [PeripheralInstance ble_testA:0x07 B:0x02];
            
        }
            break;
        case 7:
        {
            [PeripheralInstance ble_testA:0x08 B:0x03];
            
        }
            break;
        case 8:
        {
            [PeripheralInstance ble_testA:0x09 B:0x04];
        }
            break;
        case 9:
        {
            [PeripheralInstance ble_testA:0x02 B:0x04];
            
        }
            break;
        default:
            break;
    }

}


@end
