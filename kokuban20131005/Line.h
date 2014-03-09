//
//  Line.h
//  kokuban20131005
//
//  Created by HIRATSUKA SHUNSUKE on 2014/02/18.
//  Copyright (c) 2014年 HIRATSUKA SHUNSUKE. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Line : UIViewController
<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) IBOutlet UITableView *lineView;
@property (nonatomic, strong) IBOutlet UINavigationBar *navbar;

@end
