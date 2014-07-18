//
//  ParentTableViewCell.h
//  SubTableExample
//
//  Created by Alex Koshy on 7/16/14.
//  Copyright (c) 2014 ajkoshy7. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ParentTableViewCell : UITableViewCell {
    
    NSInteger parentIndex;
    UILabel *titleLabel;
    UILabel *subtitleLabel;
}

@property (nonatomic) NSInteger parentIndex;
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *subtitleLabel;

- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier;
- (void)setCellForegroundColor:(UIColor *)foregroundColor;
- (void)setCellBackgroundColor:(UIColor *)backgroundColor;

@end
