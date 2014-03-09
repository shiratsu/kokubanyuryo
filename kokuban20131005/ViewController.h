//
//  ViewController.h
//  kokuban20131005
//
//  Created by HIRATSUKA SHUNSUKE on 2013/10/05.
//  Copyright (c) 2013年 HIRATSUKA SHUNSUKE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DrawingView.h"

@interface ViewController : UIViewController
<
UIImagePickerControllerDelegate,
UITextFieldDelegate,
UIActionSheetDelegate>
{
    UIActionSheet *aActionSheet;
	IBOutlet UIImageView *aImageView;
	IBOutlet UIButton *showBtn;
    IBOutlet UIButton *menu;
	IBOutlet UIButton *elaser;
	IBOutlet UIButton *chook1;
	IBOutlet UIButton *chook2;
	IBOutlet UIButton *chook3;
	IBOutlet UIButton *chook4;
    IBOutlet UIButton *chook5;
	IBOutlet UIButton *crower;
	IBOutlet UIButton *crower_on;
	IBOutlet DrawingView *curDrawingView;
    IBOutlet DrawingView *pastDrawingView;
	int mode;
	int select_chook;
    int default_view_count;
	UIInterfaceOrientation orien;
	//-- バナービュー追加！ --//
    UIActivityIndicatorView *activityIndicator;
    //    IBOutlet AdlantisView *adView;
    
    NSMutableArray *aryStroke;
	NSMutableArray *aStroke;
	CGFloat penWhite,penRed,penYellow,penBlue,penBlack,penGreen,penAlpha;//現在の色
    CGImageRef		lastImage;
    UIImagePickerControllerSourceType   sourceType;
    UIImage *pickImage;
    int deviceHeight;
    int deviceWidth;
    int linedepth;
    
    BOOL kokubanMode;
    BOOL yukiMode;
    BOOL yukidarumaMode;
    BOOL yearMode;
    
    BOOL launchFlag;
}


@end
