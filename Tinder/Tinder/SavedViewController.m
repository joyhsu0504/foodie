//
//  SavedViewController.m
//  Tinder
//
//  Created by Joy Hsu on 6/25/17.
//  Copyright © 2017 Joy Hsu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SavedViewController.h"
#import "TableCell.h"
@import FirebaseDatabase;
@import Firebase;

static NSString *CellIdentifier = @"CellIdentifier";

@interface SavedViewController () {
    UIButton *backButton;
    FIRDataSnapshot *snapData;
}

@property(strong,nonatomic) NSMutableArray *titleArray;
@property(strong,nonatomic) NSMutableArray *bodyArray;

@end

@implementation SavedViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        self.title = @"Table View Controller";
    }
    return self;
}

-(void)backToMain {
    //[self. popToRootViewControllerAnimated:YES];
    //UIViewController *org = self.window.rootViewController;
    //[org presentViewController:vc animated:YES completion:nil];
     [self dismissViewControllerAnimated:NO completion:nil];
}

- (void)contentSizeCategoryChanged:(NSNotification *)notification
{
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.titleArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    TableCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    int dataIndex = (int) indexPath.row % [self.bodyArray count];
    cell.titleLabel.text =  self.titleArray[indexPath.row];
    cell.bodyLabel.text = self.bodyArray[dataIndex];
    
    // Make sure the constraints have been added to this cell, since it may have just been created from scratch
    [cell setNeedsUpdateConstraints];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    TableCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    int dataIndex = (int) indexPath.row % [self.bodyArray count];
    cell.titleLabel.text =  self.titleArray[indexPath.row];
    cell.bodyLabel.text = self.bodyArray[dataIndex];
    
    cell.bodyLabel.preferredMaxLayoutWidth = tableView.bounds.size.width - (20.0 * 2.0f);
    
    [cell setNeedsUpdateConstraints];
    [cell updateConstraintsIfNeeded];
    [cell.contentView setNeedsLayout];
    
    [cell.contentView layoutIfNeeded];
    
    CGFloat height = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    
    return height;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 200.0f;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.ref = [[FIRDatabase database] reference];
    
    
    
    //test
    [self.tableView registerClass:[TableCell class] forCellReuseIdentifier:CellIdentifier];
    self.titleArray = [[UIFont familyNames] mutableCopy];
    for(int i = 0; i < 100; i++) {
        [self.titleArray addObjectsFromArray:[UIFont familyNames]];
    }
    self.bodyArray = [@[@"Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",@"Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.",@"Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.",@"Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."] mutableCopy];
    
    //test
    
    
    backButton = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width - 20 - 18, 34, 20, 20)];
    [backButton setImage:[UIImage imageNamed:@"menuButton"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backToMain) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    //[[[[_ref child:@"users"] child:[[[UIDevice currentDevice] identifierForVendor] UUIDString]] child:label] setValue:textView];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"Show View" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.frame = CGRectMake(80.0, 210.0, 160.0, 40.0);
    [self.view addSubview:button];
    
    /*dispatch_sync(dispatch_get_main_queue(), ^{
        NSString *userID = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
        [[[_ref child:@"users"] child:userID] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
            snapData = snapshot;
            
        } withCancelBlock:^(NSError * _Nonnull error) {
            NSLog(@"%@", error.localizedDescription);
        }];
    });*/
    
    [button setTitle:snapData.value forState:UIControlStateNormal];
    
    /*NSString *userID = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    [[[_ref child:@"users"] child:userID] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
        [button setTitle:snapshot.value forState:UIControlStateNormal];

    } withCancelBlock:^(NSError * _Nonnull error) {
        NSLog(@"%@", error.localizedDescription);
    }];*/
    
    
    
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
