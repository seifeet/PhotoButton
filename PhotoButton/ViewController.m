//
//  ViewController.m
//  PhotoButton
//
//  Created by Andrey Tabachnik on 6/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"
#import "PhotoButton.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize photoButton;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.photoButton.viewController = self;
    self.photoButton.photoSize = CGSizeMake(256, 256);
    self.photoButton.photoName = @"ProfileUserPhoto.jpg";
    [self.photoButton addTarget:self action:@selector(photoSaved:) forControlEvents:UIControlEventValueChanged];
}

# pragma mark - selectors
- (IBAction)photoSaved:(id)sender {
    // will be once the image is saved locally
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

@end
