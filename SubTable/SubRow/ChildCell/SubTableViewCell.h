//
//  SubTableViewCell.h
//  SubTableExample
//
//  Created by Alex Koshy on 7/16/14.
//  Copyright (c) 2014 ajkoshy7. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SubTableViewCell : UITableViewCell {
    
    UILabel *titleLabel;
    UILabel *subtitleLabel;
}

@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *subtitleLabel;

- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier;
- (void)setupDisplay;
- (void)setCellForegroundColor:(UIColor *) foregroundColor;
- (void)setCellBackgroundColor:(UIColor *) backgroundColor;

@end
