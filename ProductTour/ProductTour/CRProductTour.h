//
//  CRProductTour.h
//  ProductTour
//
//  Created by Clément Raussin on 12/02/2014.
//  Copyright (c) 2014 Clément Raussin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CRBubble.h"

@interface CRProductTour : UIView

@property (nonatomic, strong)  NSMutableArray *bubblesArray;
-(void)setBubbles:(NSMutableArray*)arrayOfBubbles;
-(void)setVisible:(bool)visible;
-(BOOL)isVisible;
@end
