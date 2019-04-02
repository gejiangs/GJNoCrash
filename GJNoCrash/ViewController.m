//
//  ViewController.m
//  NoCrash
//
//  Created by gejiangs on 2019/3/28.
//  Copyright © 2019 gejiangs. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong)   UITableView *tableView;
@property (nonatomic, strong)   NSMutableArray *array;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"No Crash";
    
    [self setTableViewStyle:UITableViewStylePlain];
    
    self.array = [NSMutableArray arrayWithObjects:
                  @"NSString",
                  @"NSMutableString",
                  @"NSArray",
                  @"NSMutableArray",
                  @"NSDictionary",
                  @"NSMutableDictionary",
                  @"KVO",
                  @"NSNotification", nil];
}


-(void)setTableViewStyle:(UITableViewStyle)tableViewStyle
{
    if (self.tableView != nil) {
        [self.tableView removeFromSuperview];
        self.tableView = nil;
    }
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:tableViewStyle];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.tableView];
}

#pragma mark - UITableView Delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.array.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ident = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ident];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ident];
    }
    
    cell.textLabel.text = self.array[indexPath.row];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSInteger row = indexPath.row;
    
    if (row == 0) {
        NSString *s = @"aa";
        NSString *ss = [s substringFromIndex:10];
        NSLog(@"ss:%@", ss);
    }else if (row == 1){
        NSMutableString *s = [NSMutableString stringWithFormat:@"aaaa"];
        NSString *ss = [s stringByReplacingCharactersInRange:NSMakeRange(10, 10) withString:@"bb"];
        NSLog(@"ss:%@", ss);
    }else if (row == 2){
        NSArray *a = [NSArray array];
        id v = [a objectAtIndex:10];
        NSLog(@"array index 10 :%@", v);
    }else if (row == 3){
        NSMutableArray *array = [NSMutableArray array];
        [array addObject:nil];
        NSLog(@"NSMutableArray:%@", array);
    }else if (row == 4){
//        NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:@"vv",@"kk",nil, @"k",  nil];
        NSDictionary *dict = @{@"k":@"v"};
        NSLog(@"NSDictionary:%@", dict);
    }else if (row == 5){
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        [dict setObject:nil forKey:@"key1"];
        [dict setObject:@"value1" forKey:nil];
        [dict setObject:@"value2" forKey:@"key2"];
        NSLog(@"NSMutableDictionary:%@", dict);
    }else if (row == 6){
        UIViewController *vc = [[NSClassFromString(@"KVOViewController") alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (row == 7){
        UIViewController *vc = [[NSClassFromString(@"NSNotificationViewController") alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

@end
