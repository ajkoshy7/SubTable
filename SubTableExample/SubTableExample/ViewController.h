//
//  ViewController.h
//  SubTableExample
//
//  Created by Alex Koshy on 7/16/14.
//  Copyright (c) 2014 ajkoshy7. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ParentTableView.h"

@interface ViewController : UIViewController <SubTableViewDelegate, SubTableViewDataSource>

@property (strong, nonatomic) IBOutlet ParentTableView *tableView;

@end
