//
//  KRNCoursesViewController.m
//  NerdFeed
//
//  Created by Karan Jivani on 7/29/16.
//  Copyright © 2016 Karan Jivani. All rights reserved.
//

#import "KRNCoursesViewController.h"

@interface KRNCoursesViewController ()<UITableViewDataSource,UITableViewDelegate,NSURLSessionDataDelegate>

@property (nonatomic) NSURLSession *session;
@property(nonatomic,copy) NSArray *courses;

@end

@implementation KRNCoursesViewController

-(instancetype)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (self) {
        self.navigationItem.title = @"Courses";
        
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        _session = [NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:nil];
    }
    [self fetchFeed];
    return self;
}

-(void) fetchFeed {
    
    NSString *requestString = @"https://bookapi.bignerdranch.com/private/courses.json";
    NSURL *url = [NSURL URLWithString:requestString];
    NSURLRequest *req = [NSURLRequest requestWithURL:url];
    
    NSURLSessionDataTask *dataTask = [self.session dataTaskWithRequest:req completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSString *json = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        self.courses = [jsonObject objectForKey:@"courses"];
        NSLog(@"%@",self.courses);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }];
    
    [dataTask resume];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark Tableview DataSource Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.courses count];
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    NSDictionary *course = [self.courses objectAtIndex:indexPath.row];
    cell.textLabel.text = [course valueForKey:@"title"];
    
    return cell;
}

#pragma mark Tableview Delegate Methods

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSDictionary *course = [self.courses objectAtIndex:indexPath.row];
    NSURL *URL = [NSURL URLWithString:[course valueForKey:@"url"]];
    self.webViewController.title = [course valueForKey:@"title"];
    self.webViewController.URL = URL;
    
    if (!self.splitViewController) {
        [self.navigationController pushViewController:self.webViewController animated:YES];
    }
                  
}

#pragma mark NSURLSessionDataDelegate Methods 

-(void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition, NSURLCredential * _Nullable))completionHandler {
    
    NSURLCredential *cred = [NSURLCredential credentialWithUser:@"BigNerdRanch" password:@"AchieveNerdvana" persistence:NSURLCredentialPersistenceForSession];
    completionHandler(NSURLSessionAuthChallengeUseCredential,cred);
    
}

@end
