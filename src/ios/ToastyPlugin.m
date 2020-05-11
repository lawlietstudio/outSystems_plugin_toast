#import "ToastyPlugin.h"
#import <Cordova/CDV.h>

@implementation ToastyPlugin

- (UIViewController*) getTopMostViewController {
  UIViewController *presentingViewController = [[UIApplication sharedApplication] keyWindow].rootViewController;
  while (presentingViewController.presentedViewController != nil) {
    presentingViewController = presentingViewController.presentedViewController;
  }
  return presentingViewController;
}

- (void)show:(CDVInvokedUrlCommand*)command
{
    NSDictionary* options = [command argumentAtIndex:0];
    NSString *message  = options[@"message"];
    NSString *duration = options[@"duration"];
    
    NSTimeInterval durationMS;
    if ([duration.lowercaseString isEqualToString: @"short"]) {
      durationMS = 2000;
    } else if ([duration.lowercaseString isEqualToString: @"long"]) {
      durationMS = 4000;
    } else {
      durationMS = [duration intValue];
    }
    
    if (!isShowToast) {
        isShowToast = YES;
        lblToastMessage = [[UILabel alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - MARGIN_BOTTOM_TOAST_MESSAGE - 20,
                                                                    SCREEN_WIDTH, 20)];
        [lblToastMessage setText:message];
        [lblToastMessage setTextAlignment:NSTextAlignmentCenter];
        [lblToastMessage setTextColor:[UIColor colorWithRed:0.902 green:0.902 blue:0.902 alpha:1.0]];
        [lblToastMessage setBackgroundColor:[UIColor clearColor]];
        [lblToastMessage setOpaque:NO];
        [lblToastMessage setFont:[UIFont fontWithName:FONT_TYPE_TOAST_MESSAGE size:FONT_SIZE_TOAST_MESSAGE]];
        [lblToastMessage setAlpha:0];
        [lblToastMessage sizeToFit];
        [lblToastMessage setFrame:CGRectMake((SCREEN_WIDTH - lblToastMessage.frame.size.width) / 2, lblToastMessage.frame.origin.y,
                                             lblToastMessage.frame.size.width, 20)];
        
        viewToastMessageBg = [[UIView alloc] initWithFrame:CGRectMake(lblToastMessage.frame.origin.x - 15,
                                                                      lblToastMessage.frame.origin.y - 5,
                                                                      lblToastMessage.frame.size.width + 30,
                                                                      lblToastMessage.frame.size.height + 10)];
        [viewToastMessageBg setBackgroundColor:[UIColor grayColor]];
        [viewToastMessageBg setAlpha:0];
        [[viewToastMessageBg layer] setCornerRadius:6];
        [[viewToastMessageBg layer] setMasksToBounds:YES];
        [[viewToastMessageBg layer] setBorderWidth:1.5];
        [[viewToastMessageBg layer] setBorderColor:[[UIColor colorWithRed:0.702 green:0.702 blue:0.702 alpha:1.0] CGColor]];
        
        UIViewController *vc = [self getTopMostViewController];
        UIView *v = [vc view];
        [v addSubview:viewToastMessageBg];
        [v addSubview:lblToastMessage];
        
        [UIView animateWithDuration:ANIMATION_DURATION_TOAST_MESSAGE animations:^{
            [viewToastMessageBg setAlpha:1];
            [lblToastMessage setAlpha:1];
        } completion:^(BOOL finished){
            [NSTimer scheduledTimerWithTimeInterval:durationMS / 1000
                                             target:self
                                           selector:@selector(dismissToastMessage)
                                           userInfo:nil
                                            repeats:NO];
        }];
    }
}

- (void)dismissToastMessage
{
    if (isShowToast) {
        [UIView animateWithDuration:ANIMATION_DURATION_TOAST_MESSAGE animations:^{
            [viewToastMessageBg setAlpha:0];
            [lblToastMessage setAlpha:0];
        } completion:^(BOOL finished){
            isShowToast = NO;
            [lblToastMessage removeFromSuperview];
            [viewToastMessageBg removeFromSuperview];
            lblToastMessage = nil;
            viewToastMessageBg = nil;
        }];
    }
}


@end
