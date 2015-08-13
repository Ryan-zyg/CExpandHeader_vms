//
//  CExpandHeader.m
//  CExpandHeaderViewExample
//
//  Created by cml on 14-8-27.
//  Copyright (c) 2014年 Mei_L. All rights reserved.
//

#define CExpandContentOffset @"contentOffset"

#import "CExpandHeader.h"

@implementation CExpandHeader
{
    __weak UIScrollView *_scrollView; //scrollView或者其子类
    __weak UIView *_expandView; //背景可以伸展的View
    
    CGFloat _expandHeight;
}

-(void) dealloc
{
    if (_scrollView)
	{
        [_scrollView removeObserver:self forKeyPath:CExpandContentOffset];
        _scrollView = nil;
    }
    _expandView = nil;
}

+(id) expandWithScrollView:(UIScrollView*)scrollView expandView:(UIView*)expandView
{
    CExpandHeader *expandHeader = [CExpandHeader new];
    [expandHeader expandWithScrollView:scrollView expandView:expandView];
    return expandHeader;
}

-(void) expandWithScrollView:(UIScrollView*)scrollView expandView:(UIView*)expandView
{
	_expandView = expandView;
	_expandHeight = CGRectGetHeight(expandView.frame);
    
    _scrollView = scrollView;
//    _scrollView.contentInset = UIEdgeInsetsMake(_expandHeight, 0, 0, 0);
//    [_scrollView insertSubview:expandView atIndex:0];
    [_scrollView addObserver:self forKeyPath:CExpandContentOffset options:NSKeyValueObservingOptionNew context:nil];
//    [_scrollView setContentOffset:CGPointMake(0, -180)];
	
    //使View可以伸展效果  重要属性
    _expandView.contentMode= UIViewContentModeScaleAspectFill;
    _expandView.clipsToBounds = YES;
	
	//重置_expandView位置
//	[_expandView setFrame:CGRectMake(0, -_expandHeight, CGRectGetWidth(_expandView.frame), _expandHeight)];
	[_expandView setFrame:CGRectMake(0, 0, CGRectGetWidth(_expandView.frame), _expandHeight)];
}

-(void) observeValueForKeyPath:(NSString*)keyPath ofObject:(id)object change:(NSDictionary*)change context:(void*)context
{
    if (![keyPath isEqualToString:CExpandContentOffset])
        return;

	[self scrollViewDidScroll:_scrollView];
}

-(void) scrollViewDidScroll:(UIScrollView*)scrollView
{
	CGFloat offsetY = scrollView.contentOffset.y;
//	NSLog(@"scrollViewDidScroll - offsetY:%f",offsetY);
	
	CGRect currentFrame = _expandView.frame;
//	if(offsetY>=0 || scrollView.decelerating)
//	{
//		currentFrame.origin.y = -offsetY;
//		currentFrame.size.height = _expandHeight;
//    }
//	else
//	{
//		currentFrame.size.height = _expandHeight-offsetY;
//	}
	
	currentFrame.origin.y = -offsetY;
	if(offsetY>=0)
		currentFrame.size.height = _expandHeight;
	else
		currentFrame.size.height = _expandHeight-offsetY;
	
//	if(scrollView.decelerating)
//	{
		if(currentFrame.origin.y>0)
			currentFrame.origin.y=0;
//		if(currentFrame.size.height+currentFrame.origin.y<offsetY)
//			currentFrame.size.height=offsetY-currentFrame.origin.y;
//	}
	
//	if(scrollView.decelerating)
////	if(currentFrame.size.height+currentFrame.origin.y<offsetY)
//		currentFrame.origin.y=offsetY-currentFrame.size.height;
	
	_expandView.frame = currentFrame;
}

// no use
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
	NSLog(@"scrollViewDidEndDragging");
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
	NSLog(@"scrollViewWillBeginDecelerating");
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
	NSLog(@"scrollViewDidEndDecelerating");
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
	NSLog(@"scrollViewDidEndScrollingAnimation");
}

@end
