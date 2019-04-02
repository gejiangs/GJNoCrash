//
//  KVOViewController.m
//  NoCrash
//
//  Created by gejiangs on 2019/4/2.
//  Copyright © 2019 gejiangs. All rights reserved.
//

#import "KVOViewController.h"

@interface KVOViewController ()

@property (nonatomic, strong)   NSString *key;

@end

@implementation KVOViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"KVO";
    self.view.backgroundColor = [UIColor whiteColor];
    [self addObserver:self forKeyPath:self.key options:NSKeyValueObservingOptionNew context:nil];
}

-(void)addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(void *)context
{
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)dealloc
{
    NSLog(@"不手动removeObserver,不crash");
}

@end
