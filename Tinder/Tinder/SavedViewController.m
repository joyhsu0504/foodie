//
//  SavedViewController.m
//  Tinder
//
//  Created by Joy Hsu on 6/25/17.
//  Copyright © 2017 Joy Hsu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SavedViewController.h"
@import FirebaseDatabase;
@import Firebase;

@interface SavedViewController () {
    UIButton *backButton;
    FIRDataSnapshot *snapData;
}

@end

@implementation SavedViewController

-(void)backToMain {
    [self.navigationController popToRootViewControllerAnimated:YES];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.ref = [[FIRDatabase database] reference];
    
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
    
    dispatch_sync(dispatch_get_main_queue(), ^{
        NSString *userID = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
        [[[_ref child:@"users"] child:userID] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
            snapData = snapshot;
            
        } withCancelBlock:^(NSError * _Nonnull error) {
            NSLog(@"%@", error.localizedDescription);
        }];
    });
    
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
