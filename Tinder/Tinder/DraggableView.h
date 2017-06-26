//
//  DraggableView.h
//  Tinder
//
//  Created by Joy Hsu on 6/24/17.
//  Copyright © 2017 Joy Hsu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OverlayView.h"

@protocol DraggableViewDelegate <NSObject>

-(void)cardSwipedLeft:(UIView *)card;
-(void)cardSwipedRight:(UIView *)card;

@end

@interface DraggableView : UIView

@property (weak) id <DraggableViewDelegate> delegate;

@property (nonatomic, strong)UIPanGestureRecognizer *panGestureRecognizer;
@property (nonatomic)CGPoint originalPoint;
@property (nonatomic,strong)OverlayView* overlayView;
@property (nonatomic,strong)UILabel* information; //a placeholder for any card-specific information
@property (nonatomic,strong)UITextView* text;

-(void)leftClickAction;
-(void)rightClickAction;

@end
