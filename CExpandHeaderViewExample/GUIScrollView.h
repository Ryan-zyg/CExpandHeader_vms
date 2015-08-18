
#import <UIKit/UIKit.h>

@class ScrollTestViewController;

//@interface  UIScrollView(UITouchEvent)
//
//-(void) touchesBegan:(NSSet*)touches withEvent:(UIEvent*)event;
//-(void) touchesMoved:(NSSet*)touches withEvent:(UIEvent*)event;
//-(void) touchesEnded:(NSSet*)touches withEvent:(UIEvent*)event;
//
//@end


@interface GUIScrollView : UIScrollView

@property (nonatomic, assign) ScrollTestViewController* parentControl;
@property (nonatomic, assign) BOOL passTouchEvent;

@end
