
#import "GUIScrollView.h"
#import "ScrollTestViewController.h"
#import "GUITableView.h"
#import "GDefine.h"


//@implementation UIScrollView(UITouchEvent)
//
//-(void) touchesBegan:(NSSet*)touches withEvent:(UIEvent*)event
//{
//	[[self nextResponder] touchesBegan:touches withEvent:event];
//	[super touchesBegan:touches withEvent:event];
//}
//-(void) touchesMoved:(NSSet*)touches withEvent:(UIEvent*)event
//{
//	[[self nextResponder] touchesMoved:touches withEvent:event];
//	[super touchesMoved:touches withEvent:event];
//}
//-(void) touchesEnded:(NSSet*)touches withEvent:(UIEvent*)event
//{
//	[[self nextResponder] touchesEnded:touches withEvent:event];
//	[super touchesEnded:touches withEvent:event];
//}
//
//@end

@interface GUIScrollView ()

//@property (weak, nonatomic) IBOutlet UITableView *tableVIew;

@end

@implementation GUIScrollView
{
//    CExpandHeader *_header;
	CGPoint beginPt;
	float oldOffsetY;
}

-(id) initWithFrame:(CGRect)frame
{
	if((self=[super initWithFrame:frame]))
	{
	}
	return self;
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

-(UIView*) hitTest:(CGPoint)point withEvent:(UIEvent*)event
{
    UIView* hitView=[super hitTest:point withEvent:event];
    if(hitView==self)
    {
		if(!_passTouchEvent)
			return self;
		
		for(UIView* subview in self.subviews)
		{
			CGPoint pt=[self convertPoint:point toView:subview];
			if(ValidClass(subview, GUITableView) && [self pointInside:pt withView:subview])
			{
				return subview;
			}
		}
    }
	else
	{
//		LOGA(hitView);
//		LOGFUN;
	}
	
//	if(![self.parentControl checkCanScroll])
//	{
//		return self;
//	}
//	else
//	{
//		for(UIView* subview in self.subviews)
//		{
////			if([subview pointInside:point withEvent:event])
//			CGPoint pt=[self convertPoint:point toView:subview];
//			if([self pointInside:pt withView:subview])
//				return subview;
//		}
//	}
	return nil;
}

-(BOOL) pointInside:(CGPoint)pt withView:(UIView*)view
{
	if(pt.x >=0 && pt.x<=view.frame.size.width && pt.y>=0 && pt.y<=view.frame.size.height)
		return YES;
	
	return NO;
}

-(void) touchesBegan:(NSSet*)touches withEvent:(UIEvent*)event
{
	LOGFUN;
//	UITouch* touch=[touches anyObject];
//	beginPt=[touch locationInView:[self.parentControl tableView]];
	
	[super touchesBegan:touches withEvent:event];
}

//-(void) touchesMoved:(NSSet*)touches withEvent:(UIEvent*)event
//{
////	LOGFUN;
//	if([self.parentControl checkCanScroll])
//	{
//		for(UIView* subview in self.subviews)
//		{
//			CGPoint pt=[self convertPoint:beginPt toView:subview];
//			if((subview==[self.parentControl tableView]) && [self pointInside:pt withView:subview])
//			{
//				[subview touchesMoved:touches withEvent:event];
//				return;
//			}
//		}
//	}
//	
//	[super touchesMoved:touches withEvent:event];
//}
//
//-(void) touchesEnded:(NSSet *)touches withEvent:(UIEvent*)event
//{
////	LOGFUN;
//	[super touchesEnded:touches withEvent:event];
//}

//- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
//	if (condition) {
//	} else {
//		[super touchesMoved:touches withEvent:event];
//	}
//}

//-(void) scrollViewDidScroll:(UIScrollView*)scrollView
//{
//	if([self.parentControl checkCanScroll])
//	{
//		[super scrollViewDidScroll:scrollView];
//		return;
//	}
//}

@end
