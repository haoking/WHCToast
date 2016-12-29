//
//  WHCToastView.m
//  WHCAPP
//
//  Created by Haochen Wang on 11/30/16.
//  Copyright © 2016 WHC. All rights reserved.
//

#import "WHCToastView.h"
#import "WHCTimer.h"
#import "WHCConstants.h"

#define DEFAULT_HEIGHT 40
#define FONT_SIZE 16
#define MARGIN_SIZE 30
#define PADDING_SIZE 10

@interface WHCToastView ()

@property (nonatomic, strong) UILabel * textLabel;
@property (nonatomic, strong) WHCTimer * timer;

@end

@implementation WHCToastView

+(instancetype)toastCreateWithText:(NSString *)text
{
    return [[self alloc] initWithText:text];
}

-(id)initWithText:(NSString *)text
{
    self = [super init];
    if (!self)
    {
        return nil;
    }
    self.frame = CGRectMake(0, 0, DEFAULT_HEIGHT, DEFAULT_HEIGHT);
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.8];
    self.textLabel = [[UILabel alloc] init];
    self.textLabel.numberOfLines = 0;
    self.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.textLabel.textAlignment = NSTextAlignmentCenter;
    [self.textLabel setFont:[UIFont systemFontOfSize:FONT_SIZE]];
    self.textLabel.textAlignment = NSTextAlignmentCenter;
    self.textLabel.backgroundColor = [UIColor clearColor];
    [self.textLabel setTextColor:[UIColor whiteColor]];
    [self setToastText:@"success"];
    [self addSubview:self.textLabel];

    [self setToastText:text];

    self.center = KEYWindow.center;
    [KEYWindow addSubview:self];
    self.timer = [WHCTimer timerCreateWithTimeInterval:1.5 target:self selector:@selector(fadeOut) repeats:NO];
    return self;
}

- (void)setToastText:(NSString *)text
{
    CGSize size = CGSizeZero;
    if (IOS_VERSION < 8.0)
    {
        #pragma clang diagnostic push
        #pragma clang diagnostic ignored "-Wdeprecated-declarations"
            size = [text sizeWithFont:self.textLabel.font constrainedToSize:CGSizeMake([UIScreen mainScreen].bounds.size.width - (MARGIN_SIZE + PADDING_SIZE) * 2, CGFLOAT_MAX) lineBreakMode:NSLineBreakByWordWrapping];
        #pragma clang diagnostic pop
    }
    else
    {
        size = [text boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width - (MARGIN_SIZE + PADDING_SIZE) * 2, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.textLabel.font} context:nil].size;
    }

    self.frame = CGRectMake(0, 0, size.width + PADDING_SIZE * 2, DEFAULT_HEIGHT > size.height + PADDING_SIZE * 2 ? DEFAULT_HEIGHT : size.height + PADDING_SIZE * 2);
    self.layer.cornerRadius = 10;
    self.layer.borderWidth = 1;
    self.layer.borderColor = [UIColor clearColor].CGColor;
    self.layer.masksToBounds = YES;

    self.textLabel.frame = CGRectMake(0, 0, size.width, size.height);
    self.textLabel.center = self.center;
    self.textLabel.text = text;
}

- (void)fadeOut
{
    [UIView animateWithDuration:0.5 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

@end
