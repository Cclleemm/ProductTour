//
//  CRProductTour.m
//  ProductTour
//
//  Created by Clément Raussin on 12/02/2014.
//  Copyright (c) 2014 Clément Raussin. All rights reserved.
//

#import "CRProductTour.h"

@implementation CRProductTour
static BOOL tourVisible=YES;
static NSMutableArray *arrayOfAllocatedTours;


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.bubblesArray = [[NSMutableArray alloc] init];
        [self setBackgroundColor:[UIColor clearColor]];
        [self setUserInteractionEnabled:NO];
        
    }
    if(arrayOfAllocatedTours==nil)
        arrayOfAllocatedTours = [[NSMutableArray alloc]init];
    [arrayOfAllocatedTours addObject:self];
    return self;
}

-(void)setBubbles:(NSMutableArray*)arrayOfBubbles
{
    self.bubblesArray=arrayOfBubbles;
    
    
    for (CRBubble *bubble in self.bubblesArray)
    {
        if(bubble.attachedView!=nil)
        {
        [self addSubview:bubble];
        
        if(!tourVisible)
            [bubble setAlpha:0.0];
        }
    }
}

-(void)setVisible:(bool)visible
{
    tourVisible=visible;
    [self refreshBubblesVisibility];
}

-(BOOL)isVisible
{
    return tourVisible;
}

-(void) refreshBubblesVisibility
{
    for(CRProductTour *tour in arrayOfAllocatedTours)
    {
    for (CRBubble *bubble in tour.bubblesArray)
    {
        if(tourVisible)
        {
            [UIView beginAnimations:nil context:NULL];
            [UIView setAnimationDuration:0.3];
            [bubble setAlpha:1.0];
            [UIView commitAnimations];
        }
        else
        {
            [UIView beginAnimations:nil context:NULL];
            [UIView setAnimationDuration:0.3];
            [bubble setAlpha:0.0];
            [UIView commitAnimations];
        }
    }
    }
}

-(void)dealloc
{
    [arrayOfAllocatedTours removeObject:self];
}


@end
