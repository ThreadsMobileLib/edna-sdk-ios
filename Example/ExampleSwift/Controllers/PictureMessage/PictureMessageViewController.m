//
//  PictureMessageViewController.m
//  ThreadsDemoObjc
//
//  Created by Vitaliy Kuzmenko on 31/07/2019.
//  Copyright © 2019 Threads. All rights reserved.
//

#import "PictureMessageViewController.h"

@interface PictureMessageViewController () <UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (strong, nonatomic) IBOutlet UIBarButtonItem *sendBarButton;

@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activityView;

@property (strong, nonatomic) IBOutlet UIImageView *imageView;

@property (strong, nonatomic) IBOutlet UILabel *noImageLabel;

@end

@implementation PictureMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

- (IBAction)sendImage:(id)sender {
    UIImage *image = self.imageView.image;
    if (!image) {
        self.noImageLabel.textColor = [UIColor redColor];
        return;
    }
    self.noImageLabel.textColor = [UIColor lightGrayColor];
    [self sendOutsideImageMessageWithImage:image];
}

- (void)sendOutsideImageMessageWithImage:(UIImage *)image {
    
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) { return; }
    [self presentOutsideMessageImagePicker];
}

- (void)presentOutsideMessageImagePicker {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:picker animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *chosenImage = info[UIImagePickerControllerOriginalImage];
    [picker dismissViewControllerAnimated:YES completion:^{
        self.imageView.image = chosenImage;
    }];
}

- (void)presentSuccessfulySubmitedOutsideMessageAlert {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"Success", "")
                                                                   message:NSLocalizedString(@"Your message successfuly submited.", "")
                                                            preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        self.imageView.image = nil;
    }]];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)presentFailedSubmissionOutsideMessageAlertWithError:(NSError *)error {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Failed"
                                                                   message:error.userInfo[@"error_description"]
                                                            preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)startAnimating {
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:self.activityView];
    self.navigationItem.rightBarButtonItem = item;
    [self.activityView startAnimating];
    [self.view endEditing:YES];
    self.view.userInteractionEnabled = NO;
}

- (void)stopAnimating {
    [self.activityView stopAnimating];
    self.navigationItem.rightBarButtonItem = self.sendBarButton;
    self.view.userInteractionEnabled = YES;
}

@end
