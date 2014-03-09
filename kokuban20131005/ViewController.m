//
//  ViewController.m
//  kokuban20131005
//
//  Created by HIRATSUKA SHUNSUKE on 2013/10/05.
//  Copyright (c) 2013年 HIRATSUKA SHUNSUKE. All rights reserved.
//

#import "ViewController.h"
#import "Common.h"
#import "Line.h"


#define INDICATOR_TAG 100

@interface ViewController ()
- (BOOL)writeImage:(UIImage*)inImage toFile:(NSString*)fileName;
-(void)startAnimating;
-(void)stopAnimating;
-(void) elase;
-(void) Allstand : (int) stand;
-(IBAction) chook1 :(id) sender ;
-(IBAction) chook2 :(id) sender ;
-(IBAction) chook3 :(id) sender ;
-(IBAction) chook4 :(id) sender ;
-(IBAction) chook5 :(id) sender ;
-(IBAction) showActionSheet :(id) sender ;
-(IBAction)showEraseSheet:(id)sender;
-(void)store;
-(void)doUndo:(id)sender;
-(void)doAllUndo:(id)sender;
-(void)onTouchUpInsideBtnCapture;
-(UIImage *)takeGrabScreenImage;
-(void)gotoNext;

@end

@implementation ViewController

- (void)startAnimating {
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

// 何か処理を行って、準備できたらこれを呼ぶ
- (void)stopAnimating {
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

-(void)setPenColor:(NSInteger)idx {
	CGFloat components[] = {
        //   r     g     b     a
        1.0f, 1.0f, 1.0f, 1.0f,	// 0:白
		246 / 255.0f, 171 / 255.0f, 171 / 255.0f,  1.0f,	// 0:ピンク
		171 / 255.0f, 177 / 255.0f, 244 / 255.0f, 1.0f,	// 1:青
		238 / 255.0f, 241 / 255.0f, 174 / 255.0f, 1.0f,	// 2:き色
        171 / 255.0f, 244 / 255.0f, 177 / 255.0f, 1.0f,	// 3:緑
		0.0f, 0.0f, 0.0f, 0.0f,	// 0:消す
	};
	if ((idx >= 0) && (idx <= 5)) {
        penRed		= components[idx*4+0];
		penGreen	= components[idx*4+1];
		penBlue		= components[idx*4+2];
		penAlpha	= components[idx*4+3];
	}
}



#pragma mark -
#pragma mark 白チョークに変更
-(void) chook1 :(id) sender {
	[self Allstand:1];
	[self setPenColor:0];
    kokubanMode = YES;
}

#pragma mark -
#pragma mark 赤チョークに変更
-(void) chook2 :(id) sender {
	[self Allstand:2];
	[self setPenColor:1];
    kokubanMode = YES;
}

#pragma mark -
#pragma mark 青チョークに変更
-(void) chook3 :(id) sender {
	[self Allstand:3];
    [self setPenColor:2];
    kokubanMode = YES;
	
}

#pragma mark -
#pragma mark 黄色チョークに変更
-(void) chook4 :(id) sender {
	[self Allstand:4];
	[self setPenColor:3];
    kokubanMode = YES;
}

#pragma mark -
#pragma mark 緑色チョークに変更
-(void) chook5:(id)sender{
	[self Allstand:5];
	[self setPenColor:4];
    kokubanMode = YES;
}


-(void)elase{
	[self Allstand:10];
	[self setPenColor:5];
    kokubanMode = YES;
	
}

-(void)showEraseSheet:(id)sender{
	kokubanMode = YES;
	// アクションシートを作る
    
    aActionSheet = [[UIActionSheet alloc]
					initWithTitle:@"どうする？？"
					delegate:self
					cancelButtonTitle:@"Cancel"
					destructiveButtonTitle:nil
					otherButtonTitles:@"一つ前に戻る", @"全部消す", nil];
	aActionSheet.tag=1;
    
	
    // アクションシートを表示する
    [aActionSheet showInView:self.view];
}



-(void)showActionSheet:(id)sender{
	
	// アクションシートを作る
    
    aActionSheet = [[UIActionSheet alloc]
                    initWithTitle:@"どうする？？"
                    delegate:self
                    cancelButtonTitle:@"Cancel"
                    destructiveButtonTitle:nil
                    otherButtonTitles:@"写真を選ぶ", @"ライブラリに保存", @"黒板を表示",@"雪結晶",@"年を使う",@"雪だるまを使う",@"チョークを使う",@"線の太さを選ぶ",nil];
	aActionSheet.tag=2;
   
	
    // アクションシートを表示する
    [aActionSheet showInView:self.view];
}

/**
 *
 *	アクションシートが選択されたら
 */
- (void)actionSheet:(UIActionSheet*)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
	// ボタンインデックスをチェックする
    NSLog(@"%d",buttonIndex);
    if (buttonIndex >= 9) {
        return;
    }
	if(actionSheet.tag == 2){
        
		switch (buttonIndex) {
			case 0: {
				//写真を選ぶ
                //				[self store];
                sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                
                // 使用可能かどうかチェックする
                if (![UIImagePickerController isSourceTypeAvailable:sourceType]) {
                    return;
                }
                
                // イメージピッカーを作る
                UIImagePickerController*    imagePicker;
                imagePicker = [[UIImagePickerController alloc] init];
                imagePicker.sourceType = sourceType;
                imagePicker.allowsImageEditing = YES;
                imagePicker.delegate = self;
                
                
                // イメージピッカーを表示する
                [self presentModalViewController:imagePicker animated:YES];
                kokubanMode = YES;
				break;
			}
			case 1: {
				[self startAnimating];
                //                CGRect screenRect = [[UIScreen mainScreen] bounds];
                //                UIGraphicsBeginImageContext(screenRect.size);
                //
                //                CGContextRef ctx = UIGraphicsGetCurrentContext();
                //                [[UIColor blackColor] set];
                //                CGContextFillRect(ctx, screenRect);
                //
                //                [pastDrawingView.layer renderInContext:ctx];
                //
                //                UIImage *screenImage = UIGraphicsGetImageFromCurrentImageContext();
                //				UIImageWriteToSavedPhotosAlbum(screenImage,
                //											   self,
                //											   @selector(image:didFinishSavingWithError:contextInfo:), nil);
                //                UIGraphicsEndImageContext();
                [self onTouchUpInsideBtnCapture];
                kokubanMode = YES;
				break;
                
			}
            case 2: {
                NSLog(@"testtestts");
				[aImageView setFrame:CGRectMake(0.0, 0.0, deviceWidth, deviceHeight)];
                [aImageView setImage:[UIImage imageNamed:@"back.png"]];
                kokubanMode = YES;
				break;
                
			}
            case 3: {
                kokubanMode = NO;
                yukiMode = YES;
                yukidarumaMode = NO;
                yearMode = NO;
				break;
                
			}
            case 4: {
                kokubanMode = NO;
                yukiMode = NO;
                yukidarumaMode = NO;
                yearMode = YES;
				break;
                
			}
            case 5: {
                kokubanMode = NO;
                yukiMode = NO;
                yukidarumaMode = YES;
                yearMode = NO;
				break;
                
			}
            case 6: {
                kokubanMode = YES;
				break;
                
			}
            case 7: {
                kokubanMode = YES;
                [self gotoNext];
				break;
                
			}
            

                
		}
	}else if(actionSheet.tag == 1){
		switch (buttonIndex) {
			case 0: {
				//指消し
				//[self elase];
                [self doUndo:nil];
				break;
			}
			case 1: {
                [self doAllUndo:nil];
                break;
			}
				
		}
	}
	
}


- (void)imagePickerControllerDidCancel:(UIImagePickerController*)picker
{
    // イメージピッカーを隠す
    [self dismissModalViewControllerAnimated:YES];
}

#pragma mark -
#pragma mark 撮影した場合
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    NSString *mediaType = [info objectForKey:@"UIImagePickerControllerMediaType"];
    UIImage *mediaImage = nil;
    NSLog(@"info:%@",info);
    
    
    NSDictionary *tiff =  [info objectForKey:@"TIFF"];
    if(pickImage != nil){
        pickImage=nil;
    }
    
    if(sourceType == UIImagePickerControllerSourceTypePhotoLibrary){
        [self dismissModalViewControllerAnimated:YES];
    }
    
    
    if([mediaType isEqualToString:@"public.image"]){
        
        
        pickImage = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        
        // おまじない始まり
        UIGraphicsBeginImageContext(pickImage.size);
        [pickImage drawInRect:CGRectMake(0, 0, pickImage.size.width, pickImage.size.height)];
        pickImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        
        [aImageView setFrame:CGRectMake(0.0, 0.0, deviceWidth, (pickImage.size.height*deviceWidth)/pickImage.size.width)];

        
        // おまじない終わり
        [aImageView setImage:pickImage];
        
        NSLog(@"width:%f",pickImage.size.width);
        NSLog(@"height:%f",pickImage.size.height);
        
        
        
    }
    
    
	
}

-(UIImage *)takeGrabScreenImage{
    
    //スクリーンショットの対象となるview とサイズを指定
    UIGraphicsBeginImageContext(aImageView.frame.size);
    
    [(CALayer *)self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

/**
 *
 * 画面キャプチャー開始
 *
 */
- (void)onTouchUpInsideBtnCapture {
    [NSThread sleepForTimeInterval:0.5];
    elaser.hidden=YES;
    chook1.hidden=YES;
    chook2.hidden=YES;
    chook3.hidden=YES;
    chook4.hidden=YES;
    chook5.hidden=YES;
    menu.hidden=YES;
    //画面をキャプチャー
    NSLog(@"画面キャプチャー開始");
//    CGRect rect = [[UIScreen mainScreen] bounds];
//    UIGraphicsBeginImageContext(rect.size); //コンテクスト開始
//    UIApplication *app = [UIApplication sharedApplication];
//    
//    //#import <quartzcore quartzcore.h="">をしておかないとrenderInContextで警告が出る
//    [app.keyWindow.layer renderInContext:UIGraphicsGetCurrentContext()];
//    
//    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext(); //画像を取得してからコンテクスト終了
//    
//    //画像を「写真」に保存
//    //JPEGで保存され、クオリーティーはコントロールできないようだ。
//    //ImageMagickのidentifyによるとQuality=93らしい。
//    //UIImageWriteToSavedPhotosAlbum(img, nil, nil, nil); //完了通知が必要ない場合
    UIImage *img = [self takeGrabScreenImage];
    UIImageWriteToSavedPhotosAlbum(img, self, @selector(onCompleteCapture:didFinishSavingWithError:contextInfo:), nil);
    
}


/**
 *
 * 画面キャプチャー完了
 *
 */
- (void)onCompleteCapture:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void*)contextInfo {
    NSLog(@"画面キャプチャー完了");
    
    elaser.hidden=NO;
    chook1.hidden=NO;
    chook2.hidden=NO;
    chook3.hidden=NO;
    chook4.hidden=NO;
    chook5.hidden=NO;
    menu.hidden=NO;
    NSArray *languages = [NSLocale preferredLanguages];
    NSString *currentLanguage = [languages objectAtIndex:0];
    [self stopAnimating];
    if(error != nil){
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"エラー" message:@"保存に失敗しました" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[alert show];
		//[alert release];
	}else{
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"成功" message:@"保存しました" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[alert show];
		//[alert release];
	}
}






-(void)doUndo:(id)sender {
    kokubanMode = YES;
    //	NSLog(@"Undo");
	if ([aryStroke count] > 0) {
		[aryStroke removeLastObject];
		[pastDrawingView setAryData:aryStroke];
		[pastDrawingView setNeedsDisplay];
	}
}

-(void)doAllUndo:(id)sender {
    kokubanMode = YES;
    //	NSLog(@"Undo");
	if ([aryStroke count] > 0) {
        aryStroke = nil;
        aryStroke = [[NSMutableArray alloc] init];
		[pastDrawingView setAryData:aryStroke];
		[pastDrawingView setNeedsDisplay];
        
//        for (UIView* subview in subview.subviews) {
//            [subview removeFromSuperview];
//        }
        
	}
    int i=0;
    NSLog(@"%@",self.view.subviews);
    for (UIView *view in [self.view subviews]) {
        NSLog(@"%d",i);
        if(i >= default_view_count){
            [view removeFromSuperview];
        }
        i++;
        
    }
}




-(void) image:(UIImage *) image didFinishSavingWithError:(NSError *) error contextInfo:(void *) contextInfo {
	[self stopAnimating];
    //	NSLog(@"%@",error);
	if(error != nil){
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"エラー" message:@"保存に失敗しました" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[alert show];
		
	}else{
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"成功" message:@"保存しました" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[alert show];
		
	}
}


#pragma mark -
#pragma mark チョークを元の位置に戻す
-(void) Allstand : (int) stand {
	switch (select_chook) {
		case 1:
			chook1.transform	= CGAffineTransformMakeRotation(0);
			break;
		case 2:
			chook2.transform	= CGAffineTransformMakeRotation(0);
			break;
		case 3:
			chook3.transform	= CGAffineTransformMakeRotation(0);
			break;
		case 4:
			chook4.transform	= CGAffineTransformMakeRotation(0);
			break;
        case 5:
			chook5.transform	= CGAffineTransformMakeRotation(0);
			break;
		case 6:
			crower_on.alpha		= 0;
			crower.enabled		= YES;
			break;
		default:
			break;
	}
	switch (stand) {
		case 1:
			chook1.transform	= CGAffineTransformMakeRotation(10);
			break;
		case 2:
			chook2.transform	= CGAffineTransformMakeRotation(10);
			break;
		case 3:
			chook3.transform	= CGAffineTransformMakeRotation(10);
			break;
		case 4:
			chook4.transform	= CGAffineTransformMakeRotation(10);
			break;
		case 5:
			chook5.transform	= CGAffineTransformMakeRotation(10);
			break;
        case 6:
			crower_on.alpha		= 100;
			crower.enabled		= NO;
			break;
		default:
			break;
	}
	
	select_chook = stand;
	
}


#pragma mark -
#pragma mark 一時保存
-(void)store {
	[self writeImage:[Common imageFromView:pastDrawingView] toFile:@"CurtImage.png"];
}

- (BOOL)writeImage:(UIImage*)inImage toFile:(NSString*)fileName {
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	if (!documentsDirectory) {
		return NO;
	}
	NSString *appFile = [documentsDirectory stringByAppendingPathComponent:fileName];
	NSData* data = UIImagePNGRepresentation(inImage);
    return [data writeToFile:appFile atomically:YES];
}



/*
 // The designated initializer. Override to perform setup that is required before the view is loaded.
 - (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
 self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
 if (self) {
 // Custom initialization
 }
 return self;
 }
 */

/*
 // Implement loadView to create a view hierarchy programmatically, without using a nib.
 - (void)loadView {
 }
 */




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
    // Do any additional setup after loading the view from its nib.
    orien		= UIInterfaceOrientationPortrait;
    //AdlantisAdManager.sharedManager.publisherID = @"MTI4NTA%3D%0A";
    //[UIApplication sharedApplication].statusBarHidden = YES;
    if (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_6_1) {
        [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationFade];
    }
	//初期は白
	// ペンの色
	NSInteger colorIndex = 0;
	[self setPenColor:colorIndex];
    
    //チョークで書けるモード
    kokubanMode = YES;
    
    //初期のviewのカウント
    default_view_count = 3;
    
    CGRect rect1 = [[UIScreen mainScreen] bounds];
    deviceHeight = rect1.size.height;
    deviceWidth = rect1.size.width;
    NSLog(@"rect1.size.width : %f , rect1.size.height : %f", rect1.size.width, rect1.size.height);
    
    //線の太さ
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger:kLineDepth forKey:@"linedepth"];
    
}


- (BOOL)prefersStatusBarHidden
{
    return YES;
}

- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation
{
    return UIStatusBarAnimationFade;
}

#pragma mark ストロークとタッチ
- (void)stockStroke:(NSSet *)touches {
	UITouch *touch = [touches anyObject];
	CGPoint pos = [touch locationInView:curDrawingView];
    //	NSLog(@"%d:%03.0f,%03.0f",[touch phase],pos.x,pos.y);
    
    if (! [[touch view] isEqual:curDrawingView]) {
		return;
	}
	switch ([touch phase]) {
		case UITouchPhaseBegan: // 始まり
			// ストロークの始まり。aStrokeを確保する。
			aStroke = [[NSMutableArray alloc] initWithCapacity:0];
			// 最初の4つは色情報
			[aStroke addObject:[NSNumber numberWithFloat:penRed]];
			[aStroke addObject:[NSNumber numberWithFloat:penGreen]];
			[aStroke addObject:[NSNumber numberWithFloat:penBlue]];
			[aStroke addObject:[NSNumber numberWithFloat:penAlpha]];
            [aStroke addObject:[NSNumber numberWithInt:linedepth]];
			// 一つ目の点を置く
			[aStroke addObject:[NSNumber numberWithInteger:(NSInteger)pos.x]];
			[aStroke addObject:[NSNumber numberWithInteger:(NSInteger)pos.y]];
			break;
		case UITouchPhaseMoved: // 移動
			if (aStroke) {
				// 移動先の点を置く
				[aStroke addObject:[NSNumber numberWithInteger:(NSInteger)pos.x]];
				[aStroke addObject:[NSNumber numberWithInteger:(NSInteger)pos.y]];
			}
			break;
		case UITouchPhaseStationary: // 変わっていない
			// 何もしない
			break;
		case UITouchPhaseEnded: // おわり
		case UITouchPhaseCancelled: // キャンセル
		default: // その他（その他はないはず）
			if (aStroke) {
				// 一筆書き分はここまで。
				[aStroke addObject:[NSNumber numberWithInteger:(NSInteger)pos.x]];
				[aStroke addObject:[NSNumber numberWithInteger:(NSInteger)pos.y]];
				// （aryがまだなければつくる）
				if (! aryStroke) {
					aryStroke = [[NSMutableArray alloc] initWithCapacity:0];
				}
				// aStrokeは過去保存用のaryStrokeへ持っていき、nilにする。
				[aryStroke addObject:aStroke];
				
				aStroke = nil;
				[pastDrawingView setAryData:aryStroke];
				[pastDrawingView setNeedsDisplay];
                NSLog(@"aryStroke:%@",aryStroke);
			}
			break;
	}
    NSLog(@"aStroke:%@",aStroke);
    [curDrawingView setAryData:aStroke];
	[curDrawingView setNeedsDisplay];
    
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	if(kokubanMode == YES){
        [self stockStroke:touches];
    }else{
        UIImage *image = nil;
        if(yukiMode == YES){
            image = [UIImage imageNamed:@"snow.png"];
        }else if(yearMode == YES){
            image = [UIImage imageNamed:@"2014uma.png"];
        }else{
            image = [UIImage imageNamed:@"yukidaruma.png"];
        }
        UIImageView *iv = [[UIImageView alloc] initWithImage:image];
        
        UITouch *touch = [touches anyObject];
        CGPoint location = [touch locationInView:self.view];
        NSLog(@"x,y=%.2f,%.2f",location.x,location.y);
        CGRect originalRect = iv.frame;
        originalRect.origin.x = location.x;
        originalRect.origin.y = location.y;
        iv.frame = originalRect;
        [self.view addSubview:iv];
        
    }
    
    
}
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    if(kokubanMode == YES){
        [self stockStroke:touches];
    }
	
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if(kokubanMode == YES){
        [self stockStroke:touches];
    }
	
}
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    if(kokubanMode == YES){
        [self stockStroke:touches];
    }
	
}




-(void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
    kokubanMode=YES;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    linedepth = [defaults integerForKey:@"linedepth"];
    if(linedepth == 0){
        linedepth = kLineDepth;
    }

}

-(void)viewWillDisappear:(BOOL)animated {
	
}




- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    if(interfaceOrientation == UIInterfaceOrientationPortrait){
		return YES;
	}else if(interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown){
		return YES;
	}else{
		return NO;
	}
	
}


//回転スタート時の向きに対してのメニュー位置変更
- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation) FromInterfaceOrientation duration:(NSTimeInterval) duration {
	
	orien = FromInterfaceOrientation;
	
}

//回転アニメーション直前に呼び出し
- (void) willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
	if(toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft || toInterfaceOrientation == UIInterfaceOrientationLandscapeRight){
		[curDrawingView setFrame:CGRectMake(0, 0, deviceHeight, 320)];
		[elaser setFrame:CGRectMake(100, 100, 50, 30)];
		[chook1 setFrame:CGRectMake(110, 275, 50, 20)];
		[chook2 setFrame:CGRectMake(200, 275, 50, 20)];
		[chook3 setFrame:CGRectMake(280, 275, 50, 20)];
		[chook4 setFrame:CGRectMake(360, 275, 50, 20)];
	}else if((toInterfaceOrientation == UIInterfaceOrientationPortrait ||
			  toInterfaceOrientation == UIInterfaceOrientationPortraitUpsideDown)){
		[curDrawingView setFrame:CGRectMake(0, 0, 320, deviceHeight)];
        //		[elaser setFrame:CGRectMake(20, 5, 50, 30)];
        //		[chook1 setFrame:CGRectMake(80, 435, 50, 20)];
        //		[chook2 setFrame:CGRectMake(140, 435, 50, 20)];
        //		[chook3 setFrame:CGRectMake(200, 435, 50, 20)];
        //		[chook4 setFrame:CGRectMake(260, 435, 50, 20)];
	}
}

//回転スタート終了時の向きに対してのメニュー位置変更
- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation) FromInterfaceOrientation {
	
	
	/*縦横調整用（未使用）
	 if(FromInterfaceOrientation == UIInterfaceOrientationPortrait || FromInterfaceOrientation == UIInterfaceOrientationPortraitUpsideDown){
	 NSLog(@"yoko2");
	 [canvasview setFrame:CGRectMake(0, -128, 1024, 1024)];
	 
	 } else {
	 NSLog(@"tate2");
	 [canvasview setFrame:CGRectMake(-128, 128, 1024, 1024)];
	 }*/
	
}

-(void)gotoNext{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone){
        Line *lc = [[Line alloc] initWithNibName:@"Line" bundle:nil];
        [self presentViewController:lc animated:YES completion:nil];
        lc = nil;
    }else{
        Line *lc = [[Line alloc] initWithNibName:@"Lineipad" bundle:nil];
        [self presentViewController:lc animated:YES completion:nil];
        lc = nil;
    }
    
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
