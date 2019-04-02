//
//  NSNotificationViewController.m
//  NoCrash
//
//  Created by gejiangs on 2019/4/2.
//  Copyright © 2019 gejiangs. All rights reserved.
//

#import "NSNotificationViewController.h"

@interface NSNotificationViewController ()

@end

@implementation NSNotificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"NSNotification";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(testNoti) name:@"testNoti" object:nil];
}

-(void)testNoti
{
    
}

-(void)dealloc
{
    NSLog(@"NSNotificationViewController dealloc");
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
