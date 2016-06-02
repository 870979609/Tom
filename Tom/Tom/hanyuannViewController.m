//
//  hanyuannViewController.m
//  Tom
//
//  Created by 409 on 16-5-3.
//  Copyright (c) 2016年 409. All rights reserved.
//

#import "hanyuannViewController.h"

@interface hanyuannViewController (){
    NSDictionary *_dict;
}
@end

@implementation hanyuannViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *path = [bundle pathForResource:@"tom" ofType:@"plist"];
    
    _dict = [NSDictionary dictionaryWithContentsOfFile:path];
    
    // 准备播放声音
    NSString *soundPath=[[NSBundle mainBundle] pathForResource:@"aiyo" ofType:@"mp3"];
    NSURL *soundUrl=[[NSURL alloc] initFileURLWithPath:soundPath];
    player=[[AVAudioPlayer alloc] initWithContentsOfURL:soundUrl error:nil];
    [player prepareToPlay];
    
    // 初始化计时器
    if(!timer){
        [self resetTimer];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnClick:(UIButton *)sender {
    if(_tom.isAnimating) return;
    
    NSString *title = [sender titleForState:UIControlStateNormal];
    int count = [_dict[title] intValue];
    [self playAnim:count filename:title];
}

- (void)playAnim:(int)count filename:(NSString *)filename {
    // 当用户触发动画时重置计时器
    [self resetTimer];
    
    NSMutableArray *images = [NSMutableArray array];
    for (int i = 0; i<count; i++) {
        NSString *name = [NSString stringWithFormat:@"%@_%02d.jpg", filename, i];
        NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:nil];
        //UIImage *img = [UIImage imageNamed:name];
        UIImage *img = [[UIImage alloc] initWithContentsOfFile:path];
        [images addObject:img];
    }
    
    _tom.animationImages = images;
    _tom.animationRepeatCount = 1;
    _tom.animationDuration = 0.1 * count;
    //播放动画
    [_tom startAnimating];
    //播放声音
    [player play];
    
    //释放内存，减少引用计数
    [images removeAllObjects];
    images = nil;
}

//重置计时器
- (void)resetTimer{
    if(timer){
        [timer invalidate];
    }
    int timeout = kApplicationTimeoutInSecond;
    timer = [NSTimer scheduledTimerWithTimeInterval:timeout target:self selector:@selector(timerExceeded) userInfo:nil repeats:NO];
}

//计时器结束时的监听
- (void)timerExceeded{
    int count = [_dict[@"angry"] intValue];
    [self playAnim:count filename:@"angry"];
}
@end
