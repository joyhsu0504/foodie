//
//  DraggableViewBackground.h
//  Tinder
//
//  Created by Joy Hsu on 6/24/17.
//  Copyright © 2017 Joy Hsu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DraggableView.h"
@import Firebase;
@import FirebaseDatabase;

@interface DraggableViewBackground : UIView <DraggableViewDelegate>

-(void)cardSwipedLeft:(UIView *)card;
-(void)cardSwipedRight:(UIView *)card;

@property (retain,nonatomic)NSArray* exampleCardLabels;
@property (retain,nonatomic)NSArray* exampleCardTexts;
@property (retain,nonatomic)NSMutableArray* allCards;
@property (strong, nonatomic) FIRDatabaseReference *ref;


@end
