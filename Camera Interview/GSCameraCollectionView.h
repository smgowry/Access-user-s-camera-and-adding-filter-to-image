//
//  CollectionViewController.h
//  Camera Interview
//
//  Created by Gowrie Sammandhamoorthy on 9/2/15.
//  Copyright (c) 2015 Test. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GSCameraCollectionView : UICollectionViewController

- (IBAction)cameraButtonPressed:(id)sender;
- (IBAction)exitButtonPressed:(id)sender;

@property NSMutableArray* imageArray;

@end
