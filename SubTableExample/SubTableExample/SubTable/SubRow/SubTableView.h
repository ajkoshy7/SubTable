//
//  SubTableView.h
//  SubTableExample
//
//  Created by Alex Koshy on 7/16/14.
//  Copyright (c) 2014 ajkoshy7. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SubTableViewCellDelegate <NSObject>

@required
- (NSInteger)numberOfChildrenUnderParentIndex:(NSInteger)parentIndex;
- (NSInteger)heightForChildRows;

@optional
- (void)didSelectRowAtChildIndex:(NSInteger)childIndex
                underParentIndex:(NSInteger)parentIndex;
- (NSString *)titleLabelForChildIndex:(NSInteger)childIndex underParentIndex:(NSInteger)parentIndex;
- (NSString *)subtitleLabelForChildIndex:(NSInteger)childIndex underParentIndex:(NSInteger)parentIndex;

@end



@interface SubTableView : UITableViewCell <UITableViewDataSource,UITableViewDelegate> {
    UITableView *insideTableView;
    __weak id delegate;
    UIColor *bgColor;
    UIColor *fgColor;
    UIFont *font;
}

@property (nonatomic,strong) UITableView *insideTableView;
@property (nonatomic,weak,getter = getDelegate, setter = setDelegate:) id<SubTableViewCellDelegate> delegate;
@property (nonatomic) NSInteger parentIndex;

@property (nonatomic, strong, getter = getSubTableForegroundColor, setter = setSubTableForegroundColor:) UIColor *fgColor;
@property (nonatomic, strong, getter = getSubTableBackgroundColor, setter = setSubTableBackgroundColor:) UIColor *bgColor;
@property (nonatomic, strong, getter = getSubTableFont, setter = setSubTableFont:) UIFont *font;

- (void)reload;

@end
