//
//  WHCToastView.h
//  WHCAPP
//
//  Created by Haochen Wang on 11/30/16.
//  Copyright © 2016 WHC. All rights reserved.
//

#define TOASTShown(text) [WHCToastView toastCreateWithText:text]

#import <UIKit/UIKit.h>

@interface WHCToastView : UIView

+(instancetype)toastCreateWithText:(NSString *)text;

@end
