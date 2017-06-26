//
//  TableCell.m
//  Tinder
//
//  Created by Joy Hsu on 6/25/17.
//  Copyright © 2017 Joy Hsu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TableCell.h"

@interface TableCell ()

@property (nonatomic, assign) BOOL didSetupConstraints;

@end

@implementation TableCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        self.titleLabel = [[UILabel alloc] init];
        [self.titleLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self.titleLabel setLineBreakMode:NSLineBreakByTruncatingTail];
        [self.titleLabel setNumberOfLines:1];
        [self.titleLabel setTextAlignment:NSTextAlignmentLeft];
        [self.titleLabel setTextColor:[UIColor blackColor]];
        [self.titleLabel setBackgroundColor:[UIColor clearColor]];
        [self.contentView addSubview:self.titleLabel];
        
        // Add this label to the button
        self.bodyLabel = [[UILabel alloc] init];
        [self.bodyLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self.bodyLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
        [self.bodyLabel setLineBreakMode:NSLineBreakByTruncatingTail];
        [self.bodyLabel setNumberOfLines:0];
        [self.bodyLabel setTextAlignment:NSTextAlignmentLeft];
        [self.bodyLabel setTextColor:[UIColor darkGrayColor]];
        [self.bodyLabel setBackgroundColor:[UIColor clearColor]];
        [self.contentView addSubview:self.bodyLabel];
    }
    
    return self;
}

- (void)updateConstraints {
    [super updateConstraints];
    
    if (self.didSetupConstraints) return;
    
    // Get the views dictionary
    NSDictionary *viewsDictionary =
    @{
      @"titleLabel" : self.titleLabel,
      @"bodyLabel" : self.bodyLabel
      };
    
    NSString *format;
    NSArray *constraintsArray;
    
    //Create the constraints using the visual language format
    format = @"V:|-10-[titleLabel]-10-[bodyLabel]-10-|";
    constraintsArray = [NSLayoutConstraint constraintsWithVisualFormat:format options:0 metrics:nil views:viewsDictionary];
    [self.contentView addConstraints:constraintsArray];
    
    format = @"|-10-[titleLabel]-10-|";
    constraintsArray = [NSLayoutConstraint constraintsWithVisualFormat:format options:0 metrics:nil views:viewsDictionary];
    [self.contentView addConstraints:constraintsArray];
    
    format = @"|-10-[bodyLabel]-10-|";
    constraintsArray = [NSLayoutConstraint constraintsWithVisualFormat:format options:0 metrics:nil views:viewsDictionary];
    [self.contentView addConstraints:constraintsArray];
    
    self.didSetupConstraints = YES;
}

@end
