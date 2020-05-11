#import <Cordova/CDV.h>



@interface ToastyPlugin : CDVPlugin {
    BOOL isShowToast;
    UIView *viewToastMessageBg;
    UILabel *lblToastMessage;
}
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height) // Included status bar height, even status bar is hidden
#define MARGIN_BOTTOM_TOAST_MESSAGE 70
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define FONT_TYPE_TOAST_MESSAGE @"ArialMT"
#define FONT_SIZE_TOAST_MESSAGE 13
#define ANIMATION_DURATION_TOAST_MESSAGE 0.4
#define ANIMATION_DURATION_TOAST_MESSAGE_APPEAR 2.5

- (void)show:(CDVInvokedUrlCommand*)command;

@end
