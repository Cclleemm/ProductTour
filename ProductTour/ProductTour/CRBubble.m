//
//  CRBubble.m
//  ProductTour
//
//  Created by Clément Raussin on 12/02/2014.
//  Copyright (c) 2014 Clément Raussin. All rights reserved.
//

#import "CRBubble.h"
#define CR_PADDING 8
#define CR_RADIUS 6
#define COLOR_GLUE_BLUE [UIColor colorWithRed:0.0 green:0.48 blue:1.0 alpha:1.0]
#define COLOR_DARK_GRAY [UIColor colorWithWhite:0.13 alpha:1.0]
#define CR_TITLE_FONT_SIZE 24
#define CR_DESCRIPTION_FONT_SIZE 14

#define SHOW_ZONE NO

@implementation CRBubble
@synthesize fontName;

#pragma mark - Constructor


-(id)initWithAttachedView:(UIView*)view title:(NSString*)title description:(NSString*)description arrowPosition:(CRArrowPosition)arrowPosition andColor:(UIColor*)color
{
    self = [super init];
    if(self)
    {
        if(color!=nil)
            self.color=color;
        else
            self.color=COLOR_GLUE_BLUE;
        self.attachedView = view;
        self.title = title;
        self.description = description;
        self.arrowPosition = arrowPosition;
        [self setBackgroundColor:[UIColor clearColor]];
        if(fontName==NULL)
            fontName=@"BebasNeue";
            
        float actualXPosition = [self offsets].width+CR_PADDING;
        float actualYPosition = [self offsets].height+CR_PADDING;
        float actualWidth =self.frame.size.width;
        float actualHeight = CR_TITLE_FONT_SIZE;
        
        if (self.title && ![self.title isEqualToString:@""]) {
            titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(actualXPosition, actualYPosition, actualWidth, actualHeight)];
            [titleLabel setTextColor:[UIColor blackColor]];
            [titleLabel setAlpha:0.6];
            [titleLabel setFont:[UIFont fontWithName:fontName size:CR_TITLE_FONT_SIZE]];
            [titleLabel setText:title];
            [titleLabel setBackgroundColor:[UIColor clearColor]];
            [self addSubview:titleLabel];
        }
        
        if (!self.title || [self.title isEqualToString:@""])
            actualYPosition = [self offsets].height;
        
        stringArray=[self.description componentsSeparatedByString:@"\n"];
        
        for (NSString *descriptionLine in stringArray) {
            
            if (self.title && ![self.title isEqualToString:@""])
                actualYPosition+=actualHeight;
            
            actualWidth =self.frame.size.width;
            actualHeight =CR_DESCRIPTION_FONT_SIZE;
            
            UILabel *descriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(actualXPosition, actualYPosition, actualWidth, actualHeight+CR_ARROW_SPACE)];
            [descriptionLabel setTextColor:COLOR_DARK_GRAY];
            [descriptionLabel setFont:[UIFont systemFontOfSize:CR_DESCRIPTION_FONT_SIZE]];
            [descriptionLabel setText:descriptionLine];
            [descriptionLabel setBackgroundColor:[UIColor clearColor]];
            [self addSubview:descriptionLabel];
            
            if (!self.title || [self.title isEqualToString:@""])
                actualYPosition+=actualHeight;
            
        }
        
        if(SHOW_ZONE){
            UIView *myview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.attachedView.frame.size.width, self.attachedView.frame.size.height)];
            [myview setBackgroundColor:self.color];
            [myview setAlpha:0.3];
            [myview setUserInteractionEnabled:NO];
            [self.attachedView addSubview:myview];
        }
        
        [self setFrame:[self frame]];
        [self setNeedsDisplay];
    }
    
    
    return self;
}


#pragma mark - Customs methods


-(void)setFontName:(NSString *)theFontName
{
    fontName=theFontName;
    [titleLabel setFont:[UIFont fontWithName:fontName size:CR_TITLE_FONT_SIZE]];
    
}

#pragma mark - Drawing methods


-(CGRect)frame
{
    //Calculation of the bubble position
    float x = self.attachedView.frame.origin.x;
    float y = self.attachedView.frame.origin.y;
    
    if(self.arrowPosition==CRArrowPositionLeft||self.arrowPosition==CRArrowPositionRight)
    {
        y+=self.attachedView.frame.size.height/2-[self size].height/2;
        x+=(self.arrowPosition==CRArrowPositionLeft)? CR_ARROW_SPACE+self.attachedView.frame.size.width : -(CR_ARROW_SPACE*2+[self size].width);
        
    }else if(self.arrowPosition==CRArrowPositionTop||self.arrowPosition==CRArrowPositionBottom)
    {
        x+=self.attachedView.frame.size.width/2-[self size].width/2;
        y+=(self.arrowPosition==CRArrowPositionTop)? CR_ARROW_SPACE+self.attachedView.frame.size.height : -(CR_ARROW_SPACE*2+[self size].height);
    }
    
    float width = [self size].width+CR_ARROW_SIZE;
    float height = [self size].height+CR_ARROW_SIZE;
    
    if (x + width > [[UIScreen mainScreen] bounds].size.width && width < [[UIScreen mainScreen] bounds].size.width)
        x = [[UIScreen mainScreen] bounds].size.width - width;
    else if (x < 0)
        x = 0;
    
    if (y > [[UIScreen mainScreen] bounds].size.height && height < [[UIScreen mainScreen] bounds].size.height)
        y = [[UIScreen mainScreen] bounds].size.height - height;
    else if (y < 0)
        y = 0;
    
    return CGRectMake(x, y, width, height);
}

-(CGSize)size
{
    //Cacultation of the bubble size
    float height = CR_PADDING*3;
    float width = CR_PADDING*3;
    
    float titleWidth = 0;
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        CGRect stringRect = [self.title boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width, CR_TITLE_FONT_SIZE)
                                                     options:NSStringDrawingUsesLineFragmentOrigin
                                                  attributes:@{ NSFontAttributeName:[UIFont fontWithName:fontName size:CR_TITLE_FONT_SIZE] }
                                                     context:nil];
        titleWidth = stringRect.size.width;
    }
    else {
        titleWidth = [self.title length]*CR_TITLE_FONT_SIZE/2.5;
    }
    
    if(self.title && ![self.title isEqual:@""])
    {
        height+=CR_TITLE_FONT_SIZE+CR_PADDING;
        
    }
    height-=CR_DESCRIPTION_FONT_SIZE;
    float descriptionWidth=0;
    for (NSString *descriptionLine in  stringArray) {
        
        float stringWidth = 0;
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
            CGRect stringRect = [descriptionLine boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width, CR_DESCRIPTION_FONT_SIZE)
                                                              options:NSStringDrawingUsesLineFragmentOrigin
                                                           attributes:@{ NSFontAttributeName:[UIFont systemFontOfSize:CR_DESCRIPTION_FONT_SIZE] }
                                                              context:nil];
            stringWidth = stringRect.size.width;
        }
        else {
            stringWidth = [descriptionLine length]*CR_DESCRIPTION_FONT_SIZE/2.1;
        }
        
        if (descriptionWidth < stringWidth)
            descriptionWidth = stringWidth;
        height+=CR_DESCRIPTION_FONT_SIZE;
    }
    
    if (descriptionWidth>titleWidth) {
        width+=descriptionWidth;
    }else{
        width+=titleWidth;
    }
    
    return CGSizeMake(width, height);
}

-(CGSize) offsets
{
    return CGSizeMake((self.arrowPosition==CRArrowPositionLeft)? CR_ARROW_SIZE : 0, (self.arrowPosition==CRArrowPositionTop)? CR_ARROW_SIZE : 0);
}


- (void)drawRect:(CGRect)rect
{
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSaveGState(ctx);
    
    
    CGPathRef clippath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake([self offsets].width,[self offsets].height, [self size].width, [self size].height) cornerRadius:CR_RADIUS].CGPath;
    CGContextAddPath(ctx, clippath);
    
    CGContextSetFillColorWithColor(ctx, self.color.CGColor);
    
    CGContextClosePath(ctx);
    CGContextFillPath(ctx);
    
    [self.color set];
    
    CGPoint startPoint = CGPointMake(0, CR_ARROW_SIZE);
    CGPoint thirdPoint = CGPointMake(CR_ARROW_SIZE/2, 0);
    CGPoint endPoint = CGPointMake(CR_ARROW_SIZE, CR_ARROW_SIZE);
    
    
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:startPoint];
    [path addLineToPoint:endPoint];
    [path addLineToPoint:thirdPoint];
    [path addLineToPoint:startPoint];
    
    
    if(self.arrowPosition==CRArrowPositionTop)
    {
        float xPosition = CGRectGetMidX(self.attachedView.frame) - CGRectGetMinX(self.frame) -(CR_ARROW_SIZE)/2;
        CGAffineTransform trans = CGAffineTransformMakeTranslation(xPosition, 0);
        [path applyTransform:trans];
    }else if(self.arrowPosition==CRArrowPositionBottom)
    {
        float xPosition = CGRectGetMidX(self.attachedView.frame) - CGRectGetMinX(self.frame) +(CR_ARROW_SIZE)/2;
        CGAffineTransform rot = CGAffineTransformMakeRotation(M_PI);
        CGAffineTransform trans = CGAffineTransformMakeTranslation(xPosition, [self size].height+CR_ARROW_SIZE);
        [path applyTransform:rot];
        [path applyTransform:trans];
    }else if(self.arrowPosition==CRArrowPositionLeft)
    {
        float yPosition = CGRectGetMidY(self.attachedView.frame) - CGRectGetMinY(self.frame) +(CR_ARROW_SIZE)/2;
        CGAffineTransform rot = CGAffineTransformMakeRotation(M_PI*1.5);
        CGAffineTransform trans = CGAffineTransformMakeTranslation(0, yPosition);
        [path applyTransform:rot];
        [path applyTransform:trans];
    }else if(self.arrowPosition==CRArrowPositionRight)
    {
        float yPosition = CGRectGetMidY(self.attachedView.frame) - CGRectGetMinY(self.frame) -(CR_ARROW_SIZE)/2;
        CGAffineTransform rot = CGAffineTransformMakeRotation(M_PI*0.5);
        CGAffineTransform trans = CGAffineTransformMakeTranslation([self size].width+CR_ARROW_SIZE, yPosition);
        [path applyTransform:rot];
        [path applyTransform:trans];
    }
    
    [path closePath]; // Implicitly does a line between p4 and p1
    [path fill]; // If you want it filled, or...
    [path stroke]; // ...if you want to draw the outline.
    CGContextRestoreGState(ctx);
}

@end
