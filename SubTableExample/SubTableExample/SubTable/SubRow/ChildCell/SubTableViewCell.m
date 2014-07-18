//
//  SubTableViewCell.m
//  SubTableExample
//
//  Created by Alex Koshy on 7/16/14.
//  Copyright (c) 2014 ajkoshy7. All rights reserved.
//

#import "SubTableViewCell.h"

@implementation SubTableViewCell
@synthesize titleLabel;
@synthesize subtitleLabel;

- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    [self setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
    [[self contentView] setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
    
    if (!self)
        return self;
    
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.opaque = NO;
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:titleLabel];
    
    self.subtitleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    subtitleLabel.backgroundColor = [UIColor clearColor];
    subtitleLabel.opaque = NO;
    subtitleLabel.textColor = [UIColor blackColor];
    subtitleLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:subtitleLabel];
    
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self setupDisplay];
}

- (void)setupDisplay {
    
    [self.contentView setAutoresizesSubviews:YES];
    
    self.titleLabel.frame = CGRectMake(35, 10, 165, 20);
    self.subtitleLabel.frame = CGRectMake(35, 30, 165, 16);
    
    self.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    self.subtitleLabel.font = [UIFont systemFontOfSize:12];
}

- (void)setCellForegroundColor:(UIColor *)foregroundColor {
    titleLabel.textColor = foregroundColor;
    subtitleLabel.textColor = [UIColor colorWithWhite:0.9 alpha:1.0];
}

- (void)setCellBackgroundColor:(UIColor *) backgroundColor {
    self.contentView.backgroundColor = backgroundColor;
}

@end
