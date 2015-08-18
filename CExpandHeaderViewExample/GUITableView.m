
#import "GUITableView.h"
#import "ScrollTestViewController.h"
#import "GDefine.h"

@interface GUITableView ()

//@property (weak, nonatomic) IBOutlet UITableView *tableVIew;

@end

@implementation GUITableView
{
//    CExpandHeader *_header;
	float oldOffsetY;
}

-(id) initWithFrame:(CGRect)frame
{
	if((self=[super initWithFrame:frame]))
	{
	}
	return self;
}

-(UIView*) hitTest:(CGPoint)point withEvent:(UIEvent*)event
{
	UIView* hitView=[super hitTest:point withEvent:event];
	if(hitView==self)
	{
		return (_passTouchEvent ? nil : self);
	}
	else
	{
//		LOGA(hitView);
//		LOGFUN;
	}

	return nil;
}

-(void) touchesBegan:(NSSet*)touches withEvent:(UIEvent*)event
{
	LOGFUN;
//	UITouch* touch=[touches anyObject];
//	beginPt=[touch locationInView:[self.parentControl tableView]];
	
	[super touchesBegan:touches withEvent:event];
}


//-(void) scrollViewDidScroll:(UIScrollView*)scrollView
//{
//}

//- (void)setContentOffset:(CGPoint)contentOffset
//{
//	if(![self.parentControl checkCanScroll:contentOffset.y-oldOffsetY])
//		return;
//	
//	[super setContentOffset:contentOffset];
//	oldOffsetY=contentOffset.y;
//}

@end
