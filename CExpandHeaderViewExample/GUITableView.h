
#import <UIKit/UIKit.h>

@class ScrollTestViewController;

@interface GUITableView : UITableView

@property (nonatomic, assign) ScrollTestViewController* parentControl;
@property (nonatomic, assign) BOOL passTouchEvent;

@end
