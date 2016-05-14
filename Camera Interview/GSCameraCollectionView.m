//
//  CollectionViewController.m
//  Camera Interview
//
//  Created by Gowrie Sammandhamoorthy on 9/2/15.
//  Copyright (c) 2015 Test. All rights reserved.
//

#import "GSCameraCollectionView.h"
#import "ImageUploader.h"
#import "GSDetailImageViewView.h"



@interface GSCameraCollectionView () <UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property UIImage* pictureImage;
@property  UIActivityIndicatorView* indicator;

@end

@implementation GSCameraCollectionView
@synthesize indicator;
static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    indicator = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake((self.view.frame.origin.x+self.view.frame.size.width/2)-75, 450, 150, 150)];
    indicator.transform = CGAffineTransformMakeScale(2.5, 2.5);
    indicator.color = [UIColor greenColor];
    [self.collectionView addSubview:indicator];
    
    // Register cell classes
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 9;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];

    // Configure the cell
    UIImageView* imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, cell.bounds.size.width, cell.bounds.size.height)];
    [cell addSubview:imageView];
    imageView.image = _imageArray[indexPath.row];
   
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
   
    GSDetailImageViewView* presentController = [self.storyboard instantiateViewControllerWithIdentifier:@"GSDetailImageViewView"];
    presentController.selectedImage = _imageArray[indexPath.row ];
    [self.navigationController pushViewController:presentController animated:YES];
}

- (IBAction)cameraButtonPressed:(id)sender {
    UIImagePickerController*picker = [[UIImagePickerController alloc]init];
    picker.delegate= self;
    
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        picker.sourceType=UIImagePickerControllerSourceTypeCamera;
    }
    else if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum]){
        
        picker.sourceType=UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    }
    [self presentViewController:picker animated:YES completion:nil];
    
}


-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    UIImage*image =info [UIImagePickerControllerEditedImage];
    if (!image) {
        image =info[UIImagePickerControllerOriginalImage];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
     [indicator startAnimating];
    
    CGRect rect = CGRectMake(0, 0, 640, 640);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 1);
    [image drawInRect:rect];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    NSData *imageData = UIImagePNGRepresentation(img);
    
    
    [ImageUploader uploadPhoto:imageData completionBlock:^(id data){
    NSDictionary* respo = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    NSString* imageString = [[respo objectForKey:@"data"]objectForKey:@"link"];
    NSURL*url = [NSURL URLWithString:imageString];
    NSData*pictureData = [NSData dataWithContentsOfURL:url];
    self.pictureImage = [UIImage imageWithData:pictureData];
    NSLog(@"%@",self.pictureImage);
       
        dispatch_async(dispatch_get_main_queue(), ^{
            [self addingFilterToImages];
        });
        
        [indicator stopAnimating];
               
        [self.collectionView reloadData];
        
    }];
     
    
    
}

-(void)addingFilterToImages{
    
    UIImage* finalImage1 = [self filterImageWithFilterName:@"CIGaussianBlur"];
    UIImage* finalImage2 = [self filterImageWithFilterName:@"CISepiaTone"];
    UIImage* finalImage3 = [self filterImageWithFilterName:@"CIColorMonochrome"];
    UIImage* finalImage4 = [self filterImageWithFilterName:@"CITemperatureAndTint"];
    UIImage* finalImage5 = [self filterImageWithFilterName:@"CIBoxBlur"];
    UIImage* finalImage6 = [self filterImageWithFilterName:@"CIColorCube"];
    UIImage* finalImage7 = [self filterImageWithFilterName:@"CIPhotoEffectFade"];
    UIImage* finalImage8 = [self filterImageWithFilterName:@"CIHueBlendMode"];
    UIImage* finalImage9 = [self filterImageWithFilterName:@"CIPinchDistortion"];

    self.imageArray = [NSMutableArray new];
    
     [self.imageArray addObject:finalImage1];
     [self.imageArray addObject:finalImage2];
     [self.imageArray addObject:finalImage3];
     [self.imageArray addObject:finalImage4];
     [self.imageArray addObject:finalImage5];
     [self.imageArray addObject:finalImage6];
     [self.imageArray addObject:finalImage7];
     [self.imageArray addObject:finalImage8];
     [self.imageArray addObject:finalImage9];
   
}

- (IBAction)exitButtonPressed:(id)sender {
    exit(0);
}

#pragma mark - reusable method to add filter

-(UIImage*)filterImageWithFilterName:(NSString*)filterName{
    CIImage* unfilteredImage=[[CIImage alloc]initWithCGImage:[self.pictureImage CGImage]];
    
    CIFilter* filter =[CIFilter filterWithName:filterName keysAndValues: kCIInputImageKey, unfilteredImage , nil];
    CIImage* filteredImage=[filter outputImage];
    UIImage* finalImage =[UIImage imageWithCIImage:filteredImage];
    return finalImage;
}
@end
