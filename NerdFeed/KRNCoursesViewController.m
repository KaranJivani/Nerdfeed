//
//  KRNCoursesViewController.m
//  NerdFeed
//
//  Created by Karan Jivani on 7/29/16.
//  Copyright © 2016 Karan Jivani. All rights reserved.
//

#import "KRNCoursesViewController.h"

@interface KRNCoursesViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation KRNCoursesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Tableview DataSource Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 0;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return nil;
}

#pragma mark Tableview Delegate Methods
@end
