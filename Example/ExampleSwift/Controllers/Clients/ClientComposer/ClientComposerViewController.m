//
//  ClentComposerViewController.m
//  ThreadsDemoObjc
//
//  Created by Vitaliy Kuzmenko on 23/07/2019.
//  Copyright © 2019 Threads. All rights reserved.
//

#import "ClientComposerViewController.h"
#import "Client.h"
#import "SignatureService.h"
#import "Storage.h"

@interface ClientComposerViewController () <UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UILabel *cleintIdLabel;

@property (strong, nonatomic) IBOutlet UITextField *clientIdTextField;

@property (strong, nonatomic) IBOutlet UITextField *clientNameTextField;

@property (strong, nonatomic) IBOutlet UITextField *appMarkerTextField;

@property (strong, nonatomic) IBOutlet UITextField *signatureTextField;

@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activityView;

@property (strong, nonatomic) IBOutlet UIBarButtonItem *saveBarButton;

@end

@implementation ClientComposerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.clientIdTextField becomeFirstResponder];
}

- (IBAction)saveClient:(id)sender {
    if (!self.clientIdTextField.text.length) {
        self.cleintIdLabel.textColor = [UIColor redColor];
        self.cleintIdLabel.text = NSLocalizedString(@"Client Id (Required)", "");
        return;
    } else if ([self hasClientWithId:self.clientIdTextField.text]) {
        self.cleintIdLabel.textColor = [UIColor redColor];
        self.cleintIdLabel.text = NSLocalizedString(@"Client Id (Exist)", "");
        return;
    } else {
        self.cleintIdLabel.textColor = [UIColor blackColor];
        self.cleintIdLabel.text = NSLocalizedString(@"Client Id", "");
    
        [self startAnimating];
        
        __weak typeof(self) weakSelf = self;
        [self getClientWithCompletion:^(Client * _Nonnull client) {
            if (!weakSelf) { return; }
            [weakSelf stopAnimating];
            [weakSelf addClient:client];
            [weakSelf complete];
        }];
    }
}

- (BOOL)hasClientWithId:(NSString *)id {
    NSArray<Client *> *clients = [[Storage sharedInstance] getClients];
    
    __block NSInteger foundIndex = NSNotFound;
    
    [clients enumerateObjectsUsingBlock:^(Client * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj.id isEqualToString:id]) {
            foundIndex = idx;
            *stop = YES;
        }
    }];
    
    return foundIndex != NSNotFound;
}

#pragma mark - Client Methods

- (void)getClientWithCompletion:(void(^)(Client * _Nonnull client))completion {
    Client *client = [Client clientWithId:self.clientIdTextField.text
                                     name:self.clientNameTextField.text
                                appMarker:self.appMarkerTextField.text
                                signature:self.signatureTextField.text];
    if (client.signature.length) {
        completion(client);
    } else {
        __weak typeof(self) weakSelf = self;
        [[SignatureService sharedInstance] getSignatureForClientId:client.id withCompletion:^(NSString * _Nullable signature, NSError * _Nullable error) {
            if (!weakSelf) { return; }
            if (signature) {
                client.signature = signature;
            }
            if (error) {
                [weakSelf presentSignatureLoadingFailedAlertWithError:error continueHandler:^{
                    completion(client);
                }];
            } else {
                completion(client);
            }
        }];
    }
}

- (void)addClient:(Client * _Nonnull)client {
    [[Storage sharedInstance] addClient:client];
}

#pragma mark - UI Methods

- (void)presentSignatureLoadingFailedAlertWithError:(NSError *)error continueHandler:(void(^)(void))continueHandler {
    NSString *message = [NSString stringWithFormat:NSLocalizedString(@"Signature loading failed with error: %@", ""), error.localizedDescription];
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"Signature", "") message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"Continue", "") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        continueHandler();
    }]];
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
    self.navigationItem.rightBarButtonItem = self.saveBarButton;
    self.view.userInteractionEnabled = YES;
}

- (void)complete {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    switch (textField.tag) {
        case 0:
            [self.clientNameTextField becomeFirstResponder];
            break;
        case 1:
            [self.appMarkerTextField becomeFirstResponder];
            break;
        case 2:
            [self.signatureTextField becomeFirstResponder];
            break;
        case 3:
            [self.signatureTextField resignFirstResponder];
            break;
    }
    return YES;
}

@end
