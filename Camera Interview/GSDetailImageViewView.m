//
//  GSDetailImageViewViewController.m
//  Camera Interview
//
//  Created by Gowri Sammandhamoorthy on 9/2/15.
//  Copyright © 2015 Test. All rights reserved.
//

#import "GSDetailImageViewView.h"

@interface GSDetailImageViewView ()

@end

@implementation GSDetailImageViewView

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _imageView.image = _selectedImage;
  
}



- (IBAction)exitButtonPressed:(id)sender {
    exit(0);
}
@end
