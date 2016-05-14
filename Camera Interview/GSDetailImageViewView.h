//
//  GSDetailImageViewViewController.h
//  Camera Interview
//
//  Created by Gowri Sammandhamoorthy on 9/2/15.
//  Copyright © 2015 Test. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GSDetailImageViewView : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (strong, nonatomic) UIImage* selectedImage;

- (IBAction)exitButtonPressed:(id)sender;

@end
