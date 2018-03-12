//
//  ViewController.m
//  Advertising
//
//  Created by apple on 16/12/17.
//  Copyright © 2017年 apple. All rights reserved.
//
#define Width  [UIScreen mainScreen].bounds.size.width
#define Height [UIScreen mainScreen].bounds.size.height
#import "ViewController.h"
#import "PeripheralManager.h"

@interface ViewController ()
@property (strong, nonatomic) NSMutableString *string;

@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (strong, nonatomic) UIView *headerView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    PeripheralInstance;
    self.string = [NSMutableString string];
    self.textField.userInteractionEnabled = NO;

    NSString *st = @"FA";
    
    char a = [st characterAtIndex:0];
    char b = [st characterAtIndex:1];
    char f =  'd'-'a' + 0xa;
    NSLog(@"%02x",f);
    char c = (a - 'A') + 0xa;
    char d = b - 'A'  + 0xa;
    char e = c << 4;
    e = e|d;
    NSData *data = [NSData dataWithBytes:&e length:1];
    Byte buf[3];
    buf[0] = 'a';
    buf[1] = 'b';
    buf[2] = 'c'+0xa;
    
    for (int i = 0; i<3; i++) {
//        printf("%x\n",buf[i]);
    }
    
    
    
    [self createHeaderView];
    [self str2HexBuffer:@"13lksdlklsdklkl"];
}
- (NSArray *)keyArray {
    return @[@"D",@"E",@"F",@"A",@"B",@"C",@"7",@"8",@"9",@"4",@"5",@"6",@"1",@"2",@"3",@"删除",@"0",@" "];
}

- (void)str2HexBuffer:(NSString *)st
{
    char buf[256];
    int index = -1;
    memset(buf, 0x00, 256);
    NSMutableString *string = [NSMutableString string];
    unsigned char v = 0x00;
    for(int i = 0; i < st.length; i++)
    {
        char c = [st characterAtIndex:i];
        if((c >= '0' && c <= '9') ||
           (c >= 'a' && c <= 'f') ||
           (c >= 'A' && c <= 'F'))
        {
        }
        else continue;
        NSString *cc = [NSString stringWithFormat:@"%c",c];
        [string appendString:cc];
        NSLog(@"string ==%@",string);
        unsigned char b = 0x00;
        if(c >= '0' && c <= '9')
        {
            b = c - '0';
        }
        else if(c >= 'a' && c <= 'f')
        {
            b = c - 'a' + 0x0a;
        }
        else if(c >= 'A' && c <= 'F')
        {
            b = c - 'A' + 0x0a;
        }
        
        if(i % 2 == 1)
        {
            v |= b;
            index++;
            buf[index] = v;
        }
        else
        {
            v = b << 4;
        }
    }
    
    for(int i = 0; i < index + 1; i++)
    {
        NSLog(@"%d - %02X", i, (unsigned char)buf[i]);
    }
    NSData *data = [NSData dataWithBytes:buf length:20];
    [PeripheralInstance sendMsg2DeviceMax20bytes:data];
}

- (IBAction)sendBtnClick:(id)sender {
    
    [self str2HexBuffer:self.textField.text];
    
//    UInt8 *buf[20];
//    NSMutableArray *array = [NSMutableArray array];
//    NSString *temp;
//    for (int i = 0; i < self.string.length; i+=2) {
//        NSLog(@"%d",i);
//        if (i == self.string.length -1) {
//            temp = [self.string substringWithRange:NSMakeRange(i, 1)];
//        } else {
//            temp = [self.string substringWithRange:NSMakeRange(i, 2)];
//        }
//        [array addObject:temp];
//    }
//    if (array.count < 20) {
//        for (int i = array.count; i< 20; i++) {
//            [array addObject:@"0"];
//        }
//    }
    
//    for (int i = 0;i < 20; i++) {
//
//
//        NSString *st = [array objectAtIndex:i];
//
//        char a = [st characterAtIndex:0];
//        char b = [st characterAtIndex:1];
//        char c =  a << 4 | b;
////        buf[i] = 0x22;
//    }
  
}


- (void)createHeaderView {
    
    self.headerView = [[UIView alloc] initWithFrame:CGRectMake(0, Height - 300,Width, 300)];
    [self.view addSubview:self.headerView];
    
    UIButton *btn;
    for (int i = 0; i < 18; i ++) {
        btn = [UIButton buttonWithType:UIButtonTypeSystem];
        int col = i % 3;
        int row = i / 3; // 行
        CGFloat W = (Width - 40) / 3;
        CGFloat H = 40;
        CGFloat MarginW = 10;
        CGFloat MarginH = 10;
        CGFloat btnX = col * (W + MarginW) + 10;
        CGFloat btnY = 10 + row * (H + MarginH);
        btn.tag = i;
        btn.backgroundColor = [UIColor purpleColor];
        [btn setTitle:[NSString stringWithFormat:@"%@",[self keyArray][i]] forState:UIControlStateNormal];
        btn.frame = CGRectMake(btnX, btnY, W, H);
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.headerView addSubview:btn];
        
    }
}
- (void)btnClick:(UIButton *)btn {

    switch (btn.tag) {
        case 0:case 1:case 2:case 3:case 4:case 5:case 6:case 7:case 8:case 9:case 10:case 11:case 12:case 13:case 14:case 16:
        {
            [self.string appendFormat:@"%@",[self keyArray][btn.tag]] ;
            
//            if(self.string.length && (self.string.length % 2 == 1))
//            {
//                [self.string appendString:@" "];
//            }
            self.textField.text = self.string;
        }
            break;
        case 15:
        {
            if (_string.length ==0) {
                return;
            }
            NSRange range = {_string.length-1,1};
            [self.string deleteCharactersInRange:range];
            self.textField.text = self.string;
        }
            break;
        default:
            break;
    }
   
    
}

@end
