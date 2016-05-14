#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

/*
 *  1 - Create a collectionView embedded in a navigation controller. The collection view should have 9 cells, 3x3.
 *  2 - The right bar button item should have a custom camera image.
 *  3 - Once the camera button is clicked, access the camera and take a picture.
 *  4 - Once the picture is taken, scale the image down to 640x640 and upload the image using the method provided.
 *  5 - Get the URL from the response and save the URL to NSUserDefaults.
 *  6 - Implement pull to refresh to load the same image into the 9 cells.
 *  7 - Add an indicator view to show while the image is downloading and removed once it is finished.
 *  8 - (If time permits) - Create a "media detailed view" that has a 640x640 imageview to present the image.
 * A) - Once a cell is selected, present the "media detailed view" modally.
 *  9 - (If time permits) - Add a different image filter to each cell (9 different filters).
 */

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
