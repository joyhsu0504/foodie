//
//  DraggableViewBackground.m
//  Tinder
//
//  Created by Joy Hsu on 6/24/17.
//  Copyright © 2017 Joy Hsu. All rights reserved.
//

@import Firebase;
@import FirebaseDatabase;
#import <Foundation/Foundation.h>
#import "DraggableViewBackground.h"
#import "SavedViewController.h"


@implementation DraggableViewBackground{
    NSInteger cardsLoadedIndex; //the index of the card you have loaded into the loadedCards array last
    NSMutableArray *loadedCards; //the array of card loaded (change max_buffer_size to increase or decrease the number of cards this holds)
    
    UIButton* menuButton;
    UIButton* messageButton;
    UIButton* checkButton;
    UIButton* xButton;
}
//this makes it so only two cards are loaded at a time to
//avoid performance and memory costs
static const int MAX_BUFFER_SIZE = 2; //max number of cards loaded at any given time, must be greater than 1
//static const float CARD_HEIGHT = 386; //height of the draggable card
//static const float CARD_WIDTH = 290; //width of the draggable card

@synthesize exampleCardLabels; //all the labels I'm using as example data at the moment
@synthesize allCards;//all the cards
@synthesize exampleCardTexts;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    self.ref = [[FIRDatabase database] reference];
    //[[[_ref child:@"users"] child:[[[UIDevice currentDevice] identifierForVendor] UUIDString]] setValue:@{@"temp label": @"temp text"}];
    //[[[[_ref child:@"users"] child:[[[UIDevice currentDevice] identifierForVendor] UUIDString]] child:@"temp label"] setValue:@"temp text"];
    if (self) {
        [super layoutSubviews];
        [self setupView];
        exampleCardLabels = [[NSArray alloc]initWithObjects:@"first",@"second",@"third",@"fourth",@"fifth", nil]; //placeholder for card-specific information
                             exampleCardTexts = [[NSArray alloc]initWithObjects:@"hello", @"hello2", @"hello3", @"hello4", @"hello5", nil];
        loadedCards = [[NSMutableArray alloc] init];
        allCards = [[NSMutableArray alloc] init];
        cardsLoadedIndex = 0;
        [self loadCards];
    }
    return self;
}

-(void)showFilter {
    
}

-(void)showSaved {
    UIViewController * vc = [[SavedViewController alloc] init];
    UIViewController *org = self.window.rootViewController;
    [org presentViewController:vc animated:YES completion:nil];
}

//sets up the extra buttons on the screen
-(void)setupView
{
    self.backgroundColor = [UIColor colorWithRed:.92 green:.93 blue:.95 alpha:1]; //the gray background colors
    
    /*menuButton = [[UIButton alloc]initWithFrame:CGRectMake(20, 34, 20, 20)];
    [menuButton setImage:[UIImage imageNamed:@"menuButton"] forState:UIControlStateNormal];
    [menuButton addTarget:self action:@selector(showFilter) forControlEvents:UIControlEventTouchUpInside];*/
    
    messageButton = [[UIButton alloc]initWithFrame:CGRectMake(self.frame.size.width - 20 - 18, 34, 20, 20)];
    [messageButton setImage:[UIImage imageNamed:@"menuButton"] forState:UIControlStateNormal];
    [messageButton addTarget:self action:@selector(showSaved) forControlEvents:UIControlEventTouchUpInside];
    
    //int buttonHeight = (self.frame.size.height/2) + ((self.frame.size.height - 220)/2) + 20;
    int buttonHeight = self.frame.size.height - 90; //220 - 30
    xButton = [[UIButton alloc]initWithFrame:CGRectMake(60, buttonHeight, 59, 59)]; //orig 485 , 60
    [xButton setImage:[UIImage imageNamed:@"xButton"] forState:UIControlStateNormal];
    [xButton addTarget:self action:@selector(swipeLeft) forControlEvents:UIControlEventTouchUpInside];
    checkButton = [[UIButton alloc]initWithFrame:CGRectMake(self.frame.size.width - 60 - 59, buttonHeight, 59, 59)]; // 200
    
    [checkButton setImage:[UIImage imageNamed:@"checkButton"] forState:UIControlStateNormal];
    [checkButton addTarget:self action:@selector(swipeRight) forControlEvents:UIControlEventTouchUpInside];
    //[self addSubview:menuButton];
    [self addSubview:messageButton];
    [self addSubview:xButton];
    [self addSubview:checkButton];
}

//creates a card and returns it.  This should be customized to fit your needs.
// use "index" to indicate where the information should be pulled.  If this doesn't apply to you, feel free
// to get rid of it (eg: if you are building cards from data from the internet)
-(DraggableView *)createDraggableViewWithDataAtIndex:(NSInteger)index
{
    int cardHeight = self.frame.size.height - 220;
    int cardWidth = self.frame.size.width - 80;
    DraggableView *draggableView = [[DraggableView alloc]initWithFrame:CGRectMake((self.frame.size.width - cardWidth)/2, (self.frame.size.height - cardHeight)/2, cardWidth, cardHeight)];
    draggableView.information.text = [exampleCardLabels objectAtIndex:index]; //placeholder for card-specific information
    draggableView.text.text = [exampleCardTexts objectAtIndex:index];
    draggableView.delegate = self;
    return draggableView;
}

//loads all the cards and puts the first x in the "loaded cards" array
-(void)loadCards
{
    if([exampleCardLabels count] > 0) {
        NSInteger numLoadedCardsCap =(([exampleCardLabels count] > MAX_BUFFER_SIZE)?MAX_BUFFER_SIZE:[exampleCardLabels count]);
        //if the buffer size is greater than the data size, there will be an array error, so this makes sure that doesn't happen
        
        //loops through the exampleCardsLabels array to create a card for each label.  This should be customized by removing "exampleCardLabels" with your own array of data
        for (int i = 0; i<[exampleCardLabels count]; i++) {
            DraggableView* newCard = [self createDraggableViewWithDataAtIndex:i];
            [allCards addObject:newCard];
            
            if (i<numLoadedCardsCap) {
                //adds a small number of cards to be loaded
                [loadedCards addObject:newCard];
            }
        }
        
        //displays the small number of loaded cards dictated by MAX_BUFFER_SIZE so that not all the cards
        // are showing at once and clogging a ton of data
        for (int i = 0; i<[loadedCards count]; i++) {
            if (i>0) {
                [self insertSubview:[loadedCards objectAtIndex:i] belowSubview:[loadedCards objectAtIndex:i-1]];
            } else {
                [self addSubview:[loadedCards objectAtIndex:i]];
            }
            cardsLoadedIndex++; //we loaded a card into loaded cards, so we have to increment
        }
    }
}


//action called when the card goes to the left.
// This should be customized with your own action
-(void)cardSwipedLeft:(UIView *)card;
{
    //do whatever you want with the card that was swiped
    //    DraggableView *c = (DraggableView *)card;
    
    [loadedCards removeObjectAtIndex:0]; //card was swiped, so it's no longer a "loaded card"
    
    if (cardsLoadedIndex < [allCards count]) { //if we haven't reached the end of all cards, put another into the loaded cards
        [loadedCards addObject:[allCards objectAtIndex:cardsLoadedIndex]];
        cardsLoadedIndex++;//loaded a card, so have to increment count
        [self insertSubview:[loadedCards objectAtIndex:(MAX_BUFFER_SIZE-1)] belowSubview:[loadedCards objectAtIndex:(MAX_BUFFER_SIZE-2)]];
    }
}


//action called when the card goes to the right.
// This should be customized with your own action
-(void)cardSwipedRight:(UIView *)card
{
    //do whatever you want with the card that was swiped
    DraggableView *c = (DraggableView *)card;
    
    [loadedCards removeObjectAtIndex:0]; //card was swiped, so it's no longer a "loaded card"
    
    NSString *label = c.information.text;
    NSString *textView = c.text.text;
    //[[[_ref child:@"users"] child:[[[UIDevice currentDevice] identifierForVendor] UUIDString]] setValue:@{label: textView}];
    [[[[_ref child:@"users"] child:[[[UIDevice currentDevice] identifierForVendor] UUIDString]] child:label] setValue:textView];
    if (cardsLoadedIndex < [allCards count]) { //if we haven't reached the end of all cards, put another into the loaded cards
        [loadedCards addObject:[allCards objectAtIndex:cardsLoadedIndex]];
        cardsLoadedIndex++;//loaded a card, so have to increment count
        [self insertSubview:[loadedCards objectAtIndex:(MAX_BUFFER_SIZE-1)] belowSubview:[loadedCards objectAtIndex:(MAX_BUFFER_SIZE-2)]];
    }
    
}

//when you hit the right button, this is called and substitutes the swipe
-(void)swipeRight
{
    DraggableView *dragView = [loadedCards firstObject];
    dragView.overlayView.mode = GGOverlayViewModeRight;
    [UIView animateWithDuration:0.2 animations:^{
        dragView.overlayView.alpha = 1;
    }];
    [dragView rightClickAction];
}

//when you hit the left button, this is called and substitutes the swipe
-(void)swipeLeft
{
    DraggableView *dragView = [loadedCards firstObject];
    dragView.overlayView.mode = GGOverlayViewModeLeft;
    [UIView animateWithDuration:0.2 animations:^{
        dragView.overlayView.alpha = 1;
    }];
    [dragView leftClickAction];
}


@end
