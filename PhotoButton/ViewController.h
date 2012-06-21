//
//  ViewController.h
//  PhotoButton
//
//  Created by Andrey Tabachnik on 6/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PhotoButton;

@interface ViewController : UIViewController
{
}

@property (nonatomic, assign) IBOutlet PhotoButton *photoButton;

- (IBAction)photoSaved:(id)sender;

@end
