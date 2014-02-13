//
//  CRViewController.h
//  ProductTour
//
//  Created by Clément Raussin on 12/02/2014.
//  Copyright (c) 2014 Clément Raussin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CRProductTour.h"

@interface CRViewController2 : UIViewController
{
    CRProductTour *productTourView;
}
@property (weak, nonatomic) IBOutlet UIButton *button1;
@property (weak, nonatomic) IBOutlet UIButton *buttonHelp;
@property (weak, nonatomic) IBOutlet UILabel *appTitle;
- (IBAction)toogleHelpAction:(id)sender;

@end
