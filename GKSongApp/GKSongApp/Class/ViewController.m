//
//  ViewController.m
//  GKSongApp
//
//  Created by wangws1990 on 2019/6/3.
//  Copyright © 2019 王炜圣. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (strong, nonatomic) NSArray *listData;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self  setupEmpty:self.tableView];
    [self setupRefresh:self.tableView option:ATHeaderRefresh|ATHeaderAutoRefresh];

}
- (void)refreshData:(NSInteger)page{
    NSDictionary *params = @{
                             @"categoryId": @"2",
                             @"contentType": @"album",
                             @"version": @"4.3.26.2",
                             @"device": @"ios",
                             @"scale": @(2),
                             };
    [BaseNetManager method:HttpMethodGet urlString:kBaseUrl(@"mobile/discovery/v2/category/recommends") params:params success:^(id object) {
        
    } failure:^(NSString *error) {
        [self endRefreshFailure];
    }];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.listData.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [UITableViewCell cellForTableView:tableView indexPath:indexPath];
    cell.textLabel.text = @"-----";
    return cell;
}
@end
