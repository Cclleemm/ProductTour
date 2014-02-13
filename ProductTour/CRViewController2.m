//
//  CRViewController.m
//  ProductTour
//
//  Created by Clément Raussin on 12/02/2014.
//  Copyright (c) 2014 Clément Raussin. All rights reserved.
//

#import "CRViewController2.h"

@interface CRViewController2 ()

@end

@implementation CRViewController2

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.appTitle setFont:[UIFont fontWithName:@"BebasNeue" size:40]];
    
    
    productTourView = [[CRProductTour alloc] initWithFrame:self.view.frame] ;
    
    //SET BUBBLES TOUR VIEWS
    
    CRBubble *bubbleButton1 = [[CRBubble alloc] initWithAttachedView:_button1 title:@"Multiview control" description:@"You can activate/desactivate \nhelp from other view controllers \nit wi affect all your App \nProduct Tour bubbles" arrowPosition:CRArrowPositionBottom andColor:COLOR_DARK_MANGENTA];
    
    NSMutableArray *bubbleArray = [[NSMutableArray alloc] initWithObjects:bubbleButton1, nil];
    
    [productTourView setBubbles:bubbleArray];
    
    [self.view addSubview:productTourView];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)toogleHelpAction:(id)sender {
    [productTourView setVisible:![productTourView isVisible]];
}
@end
