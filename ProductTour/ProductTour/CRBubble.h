//
//  CRBubble.h
//  ProductTour
//
//  Created by Clément Raussin on 12/02/2014.
//  Copyright (c) 2014 Clément Raussin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CRBubble : UIView
{
    NSArray *stringArray;
    int maxWidth;
}


typedef enum {
    CRArrowPositionTop,
    CRArrowPositionBottom,
    CRArrowPositionRight,
    CRArrowPositionLeft
} CRArrowPosition;

@property (nonatomic, strong) UIView *attachedView;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *description;
@property (nonatomic, assign) CRArrowPosition arrowPosition;

-(id)initWithAttachedView:(UIView*)view title:(NSString*)title description:(NSString*)description andArrow:(CRArrowPosition)arrowPosition;
-(CGSize)size;
-(CGRect)frame;
@end
