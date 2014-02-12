//
//  CRProductTour.m
//  ProductTour
//
//  Created by Clément Raussin on 12/02/2014.
//  Copyright (c) 2014 Clément Raussin. All rights reserved.
//

#import "CRProductTour.h"
#import "CRBubble.h"

@implementation CRProductTour

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        bubbleArray = [[NSMutableArray alloc] init];
        UIView *attachedView = [[UIView alloc] initWithFrame:CGRectMake(150, 300, 40, 20)];
        [attachedView setBackgroundColor:[UIColor darkGrayColor]];
        [self addSubview:attachedView];
        
        CRBubble *bubble = [[CRBubble alloc] initWithAttachedView:attachedView title:@"1. Add Devices" description:@"Setup your show with all \nyour connected DMX devices" andArrow:CRArrowPositionBottom];
        
        [bubbleArray addObject:bubble];
        
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    
    for (CRBubble *bubble in bubbleArray)
    {
        [self addSubview:bubble];
    }
   
   
}


@end
