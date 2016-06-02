//
//  hanyuannViewController.h
//  Tom
//
//  Created by 409 on 16-5-3.
//  Copyright (c) 2016年 409. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

#define kApplicationTimeoutInSecond 15;

@interface hanyuannViewController : UIViewController {
    AVAudioPlayer *player;
    NSTimer *timer;
}

@property (weak, nonatomic) IBOutlet UIImageView *tom;
- (IBAction)btnClick:(UIButton *)sender;

- (void)resetTimer;

@end
