//
//  Line.m
//  kokuban20131005
//
//  Created by HIRATSUKA SHUNSUKE on 2014/02/18.
//  Copyright (c) 2014年 HIRATSUKA SHUNSUKE. All rights reserved.
//

#import "Line.h"

#define kCellIdentifier @"CellIdentifier"

@interface Line ()

@end

@implementation Line

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [UIApplication sharedApplication].statusBarHidden = NO;
    
    if (floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_6_1) {
    
        [UINavigationBar appearance].barTintColor = [UIColor colorWithRed:0.000 green:0.549 blue:0.890 alpha:1.000];
    }else{
        [UINavigationBar appearance].tintColor = [UIColor colorWithRed:0.000 green:0.549 blue:0.890 alpha:1.000];
        CGRect rect1 = [[UIScreen mainScreen] bounds];
        _navbar.center = CGPointMake(rect1.size.width/2, _navbar.frame.size.height/2);
    }
    
    
    [UINavigationBar appearance].titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
    
    if (floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_6_1) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return [[UIView alloc] initWithFrame:CGRectZero];  // zeroSizeView_ = [[UIView alloc] initWithFrame:CGRectZero];
    } else {
        return nil;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 0.0;
    } else {
        return tableView.sectionHeaderHeight;
    }
}

//--------------------------------------------------------------//
#pragma mark -- UITableViewDataSource --
//--------------------------------------------------------------//
- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
    if (!cell){
        cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:kCellIdentifier];
    }
    // Configure the cell...
    cell.accessoryType = UITableViewCellAccessoryNone;
    if(indexPath.row == 0){
        cell.imageView.image = [ UIImage imageNamed:@"sen5.png" ];
        cell.textLabel.text = @"5mm幅";
    }
    if(indexPath.row == 1){
        cell.imageView.image = [ UIImage imageNamed:@"sen10.png" ];
        cell.textLabel.text = @"10mm幅(デフォルト)";
    }
    if(indexPath.row == 2){
        cell.imageView.image = [ UIImage imageNamed:@"sen15.png" ];
        cell.textLabel.text = @"15mm幅";
    }
    if(indexPath.row == 3){
        cell.imageView.image = [ UIImage imageNamed:@"sen20.png" ];
        cell.textLabel.text = @"20mm幅";
    }
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    if(indexPath.row == 0){
        [ud setInteger:5 forKey:@"linedepth"];
    }
    if(indexPath.row == 1){
        [ud setInteger:10 forKey:@"linedepth"];
    }
    if(indexPath.row == 2){
        [ud setInteger:15 forKey:@"linedepth"];
    }
    if(indexPath.row == 3){
        [ud setInteger:20 forKey:@"linedepth"];
    }
    [self dismissViewControllerAnimated:YES completion:NULL];
    
    
}

- (UIBarPosition)positionForBar:(id<UIBarPositioning>)bar
{
	return UIBarPositionTopAttached;
}


@end
