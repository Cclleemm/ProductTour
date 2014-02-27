iOS Product Tour
======

This popup control is a Garaband(iOS) like user help system.
Show bubble next to your buttons, uiview zones (ext...) to help the user in your application
Example
============
![PreviewImage](https://raw.github.com/Cclleemm/ProductTour/master/screenshots/ProductTour.gif?raw=true) 

Integration
============
```
productTourView = [[CRProductTour alloc] initWithFrame:self.view.frame] ;

//Setup your bubbles
CRBubble *bubbleButton1 = [[CRBubble alloc] initWithAttachedView:_button1 title:@"My Title" description:@"A smal description" arrowPosition:CRArrowPositionBottom andColor:[UIColor redColor]];

NSMutableArray *bubbleArray = [[NSMutableArray alloc] initWithObjects:bubbleButton1, nil];
    
[productTourView setBubbles:bubbleArray];
    
[self.view addSubview:productTourView];
```
Don't forget to add BebasNeue font if you want the same result

Features
============

*   Easy integration
*   Color, font size customization
*   Different arrow directions
*   Multi-line or mono-line for description
*   Two differents animations for dismiss/appear bubbles (BOOL activeAnimation=YES; //YES for full animation, NO for fade animation)
*   Integration example
