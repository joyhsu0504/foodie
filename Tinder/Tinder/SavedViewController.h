//
//  SavedViewController.h
//  Tinder
//
//  Created by Joy Hsu on 6/25/17.
//  Copyright © 2017 Joy Hsu. All rights reserved.
//

#import <UIKit/UIKit.h>
@import FirebaseDatabase;
@import Firebase;

@interface SavedViewController : UITableViewController

@property (strong, nonatomic) FIRDatabaseReference *ref;

@end

