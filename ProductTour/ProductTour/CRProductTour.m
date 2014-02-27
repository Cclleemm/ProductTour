//
//  CRProductTour.m
//  ProductTour
//
//  Created by Clément Raussin on 12/02/2014.
//  Copyright (c) 2014 Clément Raussin. All rights reserved.
//

#import "CRProductTour.h"
#define ANIMATION_TRANSLATION 30
#define ANIMATION_DURATION 0.25

@implementation CRProductTour
static BOOL tourVisible=YES;
static BOOL activeAnimation=YES; //Active bubbles translations and animatins for dismiss/appear
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

-(void)makeDismissAnimation:(CRBubble*)bubble;
{
    if(activeAnimation)
    {
        CGAffineTransform moveTransform;
        if(bubble.arrowPosition == CRArrowPositionRight)
            moveTransform = CGAffineTransformMakeTranslation(+bubble.frame.size.width/2.0+CR_ARROW_SPACE+CR_ARROW_SIZE, -CR_ARROW_SIZE/2);
        else if(bubble.arrowPosition == CRArrowPositionLeft)
            moveTransform = CGAffineTransformMakeTranslation(-bubble.frame.size.width/2.0-(CR_ARROW_SPACE+CR_ARROW_SIZE), -CR_ARROW_SIZE/2);
        else if(bubble.arrowPosition == CRArrowPositionBottom)
            moveTransform = CGAffineTransformMakeTranslation(-CR_ARROW_SIZE/2, +bubble.frame.size.height/2.0+CR_ARROW_SPACE+CR_ARROW_SIZE);
        else
            moveTransform = CGAffineTransformMakeTranslation(-CR_ARROW_SIZE/2, -bubble.frame.size.height/2.0-(CR_ARROW_SPACE+CR_ARROW_SIZE));
        
        CGAffineTransform scaleTransform = CGAffineTransformScale(moveTransform, 0.1, 0.1);
        
        
        
        
        [UIView animateWithDuration:ANIMATION_DURATION
                              delay:0.0
                            options:(UIViewAnimationCurveEaseInOut|UIViewAnimationOptionAllowUserInteraction)
                         animations:^{
                             bubble.transform = scaleTransform;
                             [bubble setAlpha:0.0];
                         }
                         completion:^(BOOL finished){
                             
                             
                             CABasicAnimation* scaleDown2 = [CABasicAnimation animationWithKeyPath:@"transform"];
                             scaleDown2.duration = 0.2;
                             scaleDown2.fromValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.15, 1.15, 1.15)];
                             scaleDown2.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(1, 1, 1)];
                             [bubble.attachedView.layer addAnimation:scaleDown2 forKey:nil];
                             
                             
                         }];
    }
    else
    {
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:ANIMATION_DURATION];
        [bubble setAlpha:0.0];
        [UIView commitAnimations];
    }
    
    
    
}

-(void)makeAppearAnimation:(CRBubble*)bubble;
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:ANIMATION_DURATION];
    bubble.transform=CGAffineTransformIdentity;
    [bubble setAlpha:1.0];
    [UIView commitAnimations];
}

-(void) refreshBubblesVisibility
{
    for(CRProductTour *tour in arrayOfAllocatedTours)
    {
        for (CRBubble *bubble in tour.bubblesArray)
        {
            if(tourVisible)
            {
                
                [self makeAppearAnimation:bubble];
                
                
            }
            else
            {
                
                [self makeDismissAnimation:bubble];
                
            }
        }
    }
}

-(void)dealloc
{
    [arrayOfAllocatedTours removeObject:self];
}


@end
