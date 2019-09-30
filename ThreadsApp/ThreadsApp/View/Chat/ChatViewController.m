//
//  ChatViewController.m
//  ThreadsApp
//
//  Created by Nikolay Kagala on 31/05/16.
//  Copyright © 2016 Brooma Service. All rights reserved.
//

#import "ChatViewController.h"
#import <MMDrawerController/UIViewController+MMDrawerController.h>
#import <MMDrawerController/MMDrawerBarButtonItem.h>

#import <Threads/Threads.h>
#import "AboutViewController.h"
//#import <ThreadsApp-Swift.h>

#import "CellTypeHelper.h"
#import "TextCell.h"
#import "LabelCell.h"
#import "ButtonCell.h"
#import "SelectCell.h"
#import "SwitchCell.h"
#import "ClientCell.h"
#import "Client.h"
#import "TAStorage.h"
#import <MFMSPushLite/MFMSPushLite.h>
#import "ChatFragmentViewController.h"
#import "ServerAPI.h"
#import "UIColor+AltColor.h"

@interface ChatViewController () <UITableViewDelegate, UITableViewDataSource, UICollectionViewDataSource,
UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UITabBarControllerDelegate,
TextCellDelegate, ButtonCellDelegate, SelectCellDelegate, SwitchCellDelegate, ClientCellDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic) BOOL inputVisible;

@property (nonatomic) CGFloat bottomSpacing;

@property (strong, nonatomic) THRAttributes *attributes;

@property (assign, nonatomic) THRDesign design;

@property (assign, nonatomic) BOOL canShowDebugScreen;

@property (strong) NSMutableArray<Client*>* clients;
@property NSInteger currentClientPage;

@end

@implementation ChatViewController

#pragma mark - Life Cycle

- (void) viewDidLoad {
    [super viewDidLoad];
    
    [self configureNavigationBar];
    [self configureDrawer];
    [self configureClientsPager];
    [self configureTableView];
    
    [self.tabBarController setDelegate:self];
    
    self.design = THRDesignDefault;
    self.canShowDebugScreen = NO;
    _inputVisible = YES;
    _bottomSpacing = self.tabBarController.tabBar.frame.size.height;
}

#pragma mark - Configguring Controller

- (void) configureNavigationBar {
    NSString *appName = [[[NSBundle mainBundle] infoDictionary] objectForKey: @"CFBundleDisplayName"];
    self.navigationItem.title = appName;
}

- (void) configureDrawer {
    SEL sel = @selector(rightDrawerButtonPress:);
    MMDrawerBarButtonItem *rightDrawerButton = [[MMDrawerBarButtonItem alloc] initWithTarget: self
                                                                                      action: sel];
    [self.navigationItem setRightBarButtonItem:rightDrawerButton animated:YES];
}

- (void) configureClientsPager {
    self.clientsPager.delegate = self;
    self.clientsPager.dataSource = self;
    self.clients = [[TAStorage sharedInstance] getClients];
}

- (void) configureTableView {
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    self.tableView.estimatedRowHeight = 44.0f;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.tableFooterView = [UIView new];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

#pragma mark - Actions

- (void) didTap {
    [self.view endEditing: YES];
}

- (void) rightDrawerButtonPress:(id)sender{
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideRight animated:YES completion:^(BOOL finished) {}];
}

#pragma mark - Configuring Chat

- (void) showChat: (UIButton *) button type: (CellType) type {
    [self.view endEditing:YES];
    
    if (self.clients.count > 0) {
        Client* client = [self getCurrentClient];
        if (client.clientId.length > 0) {
            
            [Threads setClientId: client.clientId];
            [Threads setClientIdSignature: client.clientIdSignature];
            [Threads setClientName: client.name];
            [Threads setAppMarker: client.appMarker];
            
            [self configureThreads];
            
            [self registerAndShow: button type: type];
            
        } else {
            [self showAlert: NSLocalizedString(@"input_login_alert", @"")];
        }
    } else {
        [self showAlert: NSLocalizedString(@"input_login_alert", @"")];
    }
}

- (void) showAlert: (NSString*) alert {
    [[[UIAlertView alloc] initWithTitle:alert
                                message:@""
                               delegate:nil
                      cancelButtonTitle:@"OK"
                      otherButtonTitles:nil] show];
}

- (void) configureThreads {
    [self configureDesign];
    [Threads clearCachedFiles];
    [Threads setAttributes: self.attributes];
    [Threads setData: @"{\"param1\": \"value1\"}"];
}

- (void) registerAndShow: (UIButton *) button type: (CellType) type {
    button.enabled = NO;
    [Threads registerClientWithCompletion:^(BOOL state, NSError *error) {
        button.enabled = YES;
        NSLog(@"%@", error);
        if (state) {
            if (type == CellTypeToFragmentChat) {
                
                if (button == nil) {
                    ChatFragmentViewController* fragmentController = (ChatFragmentViewController*) self.tabBarController.viewControllers[2].childViewControllers.firstObject;
                    
                    [Threads showInView: fragmentController.chatContainer
                       parentController: fragmentController];
                    
                } else {
                    [Threads showInView: self.chatContainer
                       parentController: self];
                    [self.view bringSubviewToFront:self.chatContainer];
                }
                
            } else if (type == CellTypeToOtherChats) {
                [self performSegueWithIdentifier:@"showChatInStack" sender: self];
            } else {
                [Threads show];
            }
            
            [self configureUnreadCounter];
        }
        else {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Registration failed. Retry?" message:nil preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [self registerAndShow: button type: type];
            }];
            UIAlertAction *actionCancel = [UIAlertAction actionWithTitle:@"No" style:UIAlertActionStyleCancel handler:nil];
            [alert addAction:actionOk];
            [alert addAction:actionCancel];
            [self presentViewController:alert animated:YES completion:nil];
        }
    }];
}

- (void) configureUnreadCounter {
    [[Threads threads] setUnreadedMessagesCountChanged:^(NSInteger messagesCount) {
        UINavigationController *navController = self.tabBarController.viewControllers[1];
        AboutViewController *emp = navController.viewControllers.firstObject;
        [emp setCounterValue: messagesCount];
        NSString *badge = (messagesCount > 0) ? [NSString stringWithFormat:@"%ld", (long)messagesCount] : nil;

        if (self.tabBarController.selectedIndex != 2 || messagesCount == 0) {
            [self.tabBarController.tabBar.items[2] setBadgeValue: badge];
        }
    }];
    
    //For testing Swift integration:
//    CounterListener* listener = [[CounterListener alloc] init];
}

- (BOOL) tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    
    if ([viewController.childViewControllers.firstObject isKindOfClass: [ChatFragmentViewController class]]) {
        [self showChat:nil type:CellTypeToFragmentChat];
        [self.tabBarController.tabBar.items[2] setBadgeValue: nil];
    } else {
        NSInteger count = [Threads threads].unreadedMessagesCount;
        if (count > 0) {
            [self.tabBarController.tabBar.items[2] setBadgeValue: [NSString stringWithFormat:@"%ld", count]];
        } else {
            [self.tabBarController.tabBar.items[2] setBadgeValue: nil];
        }
    }
    
    return YES;
    
}

#pragma mark - Outside message

- (void)presentOutsideMessageAlert {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Outside Message"
                                                                   message:@"You can submit message outside chat. Message will be submitted from user."
                                                            preferredStyle:UIAlertControllerStyleAlert];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"Text";
    }];
    [alert addAction:[UIAlertAction actionWithTitle:@"Submit" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSString *text = [alert.textFields[0].text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        if (text.length > 0) {
            [self submitOutsideMessageWith:text];
        } else {
            [self presentViewController:alert animated:YES completion:nil];
        }
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        // nothing
    }]];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)submitOutsideMessageWith:(NSString *)text {
    
    Threads *threads = [Threads threads];
    
    if (![self prepareForSubmittingOutsideMessage]) {
        return;
    }
    
    [threads submitMessageWithText:text completion:^(BOOL success, NSError * _Nonnull error) {
        if (success) {
            [self presentSuccessfulySubmitedOutsideMessageAlert];
        } else {
            [self presentFailedSubmissionOutsideMessageAlertWithError:error];
        }
    }];
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
        [self submitOutsideImageMessageWithImage:chosenImage];
    }];
}

- (void)submitOutsideImageMessageWithImage:(UIImage *)image {
    Threads *threads = [Threads threads];

    if (![self prepareForSubmittingOutsideMessage]) {
        return;
    }
    
    [threads submitMessageWithImage:image completion:^(BOOL success, NSError * _Nonnull error) {
        if (success) {
            [self presentSuccessfulySubmitedOutsideMessageAlert];
        } else {
            [self presentFailedSubmissionOutsideMessageAlertWithError:error];
        }
    }];
}

- (BOOL)prepareForSubmittingOutsideMessage {
    Threads *threads = [Threads threads];
    
    if (self.clients.count > 0) {
        Client *client = [self getCurrentClient];
        
        if ([threads isConfigured] && threads.clientId == client.clientId) {
            return YES;
        } else if (client.clientId.length > 0) {
            [Threads setClientId: client.clientId];
            [Threads setClientIdSignature: client.clientIdSignature];
            [Threads setClientName: client.name];
            [Threads setAppMarker: client.appMarker];
            [self configureThreads];
            return YES;
        } else {
            [self showAlert: NSLocalizedString(@"input_login_alert", @"")];
            return NO;
        }
    } else {
        [self showAlert: NSLocalizedString(@"input_login_alert", @"")];
        return NO;
    }
}

- (void)presentSuccessfulySubmitedOutsideMessageAlert {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Success"
                                                                   message:@"Your message successfuly submited."
                                                            preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        // nothing
    }]];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)presentFailedSubmissionOutsideMessageAlertWithError:(NSError *)error {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Failed"
                                                                   message:error.userInfo[@"error_description"]
                                                            preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        // nothing
    }]];
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - Input

- (IBAction)addClientAction:(id)sender {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Add Client:" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    
    __block UITextField* clientIdInput = nil;
    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"Client Id (required)";
        clientIdInput = textField;
    }];
    
    __block UITextField* clientNameInput = nil;
    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"Client Name (optional)";
        clientNameInput = textField;
    }];
    
    __block UITextField* appMarkerInput = nil;
    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"App Marker (optional)";
        appMarkerInput = textField;
    }];
    
    __block UITextField* clientIdSignatureInput = nil;
    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"Signature (if empty - will load from server)";
        clientIdSignatureInput = textField;
    }];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //Cancel
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"Done" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSString* newClientId = clientIdInput.text;
        NSString* newClientName = clientNameInput.text;
        NSString* newAppMarker = appMarkerInput.text;
        NSString* newClientIdSignature = clientIdSignatureInput.text;
        if (newClientId.length > 0) {
            
            if (newClientIdSignature.length > 0) {
                [self addClient: [Client clientWithId:newClientId name:newClientName appMarker:newAppMarker clientIdsignature:newClientIdSignature]];
            } else {
            
                [ServerAPI getClientIdSignature: newClientId withCompletion:^(NSString * _Nullable signature, NSError * _Nullable error) {
                    
                    if (error) {
                        [self showAlert: @"Signature loading failed, left empty"];
                        NSLog(@"Signature loading failed, left empty");
                        signature = @"";
                    }
                    
                    [self addClient: [Client clientWithId:newClientId name:newClientName appMarker:newAppMarker clientIdsignature:signature]];
                }];
            }

        }
    }]];
    
    [self presentViewController:alert animated:YES completion:nil];
}

- (IBAction) showOrHideInput:(id)sender {
    if(_inputVisible) {
        _inputVisible = NO;
        [Threads hideToolbarAnimated:NO];
    }
    else {
        _inputVisible = YES;
        [Threads showToolbarAnimated:NO];
    }
}

#pragma mark - New Client Connected

/*!
 * Если в приложении банка был осуществлен вход с другого аккаунта,
 * то библиотеке Threads необходимо указать новые данные клиента (clientId
 * и clientName). После чего необходимо вызвать метод регистрации и отображения чата.
 * Библиотека сама поймет, что clientId сменился, поэтому сотрет всю историю
 * переписки, сгенерирует новый deviceAddress и отобразит чат, при необходимости
 * загрузив историю переписки. Метод ниже как раз выполняет то, что необходимо сделать
 * при подключении нового клиента.
 */
- (void) newClientConnected {
    //    [Threads setClientId: <# put new client id here #>];
    //    [Threads setClientName: <# put new client name here #>];
    //    [self registerAndShow];
}

- (void) addClient: (Client*) client {
    [self.clients addObject: client];
    [self.clientsPager reloadData];
    
    [[TAStorage sharedInstance] addClient: client];
}

#pragma mark - Table View

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return CellTypeCount;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CellType type = indexPath.row;
    
    switch (type) {
        case CellTypeVersion: {
            return [self labelCell: indexPath type: type];
        }
        case CellTypeToFragmentChat:
            //fallthrough
        case CellTypeToOtherChats:
            //fallthrough
        case CellTypeToOutsideTextMessage:
            //fallthrough
        case CellTypeToOutsideImageMessage:
            //fallthrough
        case CellTypeToFullChat: {
            return [self buttonCell: indexPath type: type];
        }
        case CellTypeDesign: {
            return [self selectCell: indexPath type: type];
        }
        case CellTypeDebugMode: {
            return [self switchCell: indexPath type: type];
        }
        default:
            return nil;
    }
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath: indexPath animated: YES];
    
    if (indexPath.row == CellTypeDesign) {
        SelectCell *cell = [tableView cellForRowAtIndexPath: indexPath];
        [cell showDesignControllerIn: self
                             designs: [SelectCell allDesigns]];
    }
}

- (LabelCell *) labelCell: (NSIndexPath *) indexPath
                     type: (CellType) type {
    NSString *identifier = NSStringFromClass([LabelCell class]);
    LabelCell *cell = [self.tableView dequeueReusableCellWithIdentifier: identifier
                                                           forIndexPath: indexPath];
    cell.type = type;
    [cell construct];
    return cell;
}

- (ButtonCell *) buttonCell: (NSIndexPath *) indexPath
                       type: (CellType) type {
    NSString *identifier = NSStringFromClass([ButtonCell class]);
    ButtonCell *cell = [self.tableView dequeueReusableCellWithIdentifier: identifier
                                                            forIndexPath: indexPath];
    cell.type = type;
    cell.delegate = self;
    [cell construct];
    return cell;
}

- (SelectCell *) selectCell: (NSIndexPath *) indexPath
                       type: (CellType) type {
    NSString *identifier = NSStringFromClass([SelectCell class]);
    SelectCell *cell = [self.tableView dequeueReusableCellWithIdentifier: identifier
                                                            forIndexPath: indexPath];
    cell.type = type;
    cell.selectedDesign = self.design;
    cell.delegate = self;
    [cell construct];
    return cell;
}

- (SwitchCell *) switchCell: (NSIndexPath *) indexPath
                       type: (CellType) type {
    NSString *identifier = NSStringFromClass([SwitchCell class]);
    SwitchCell *cell = [self.tableView dequeueReusableCellWithIdentifier: identifier
                                                            forIndexPath: indexPath];
    cell.type = type;
    cell.delegate = self;
    [cell construct];
    return cell;
}

#pragma mark - Delegates

- (void) buttonCellClicked: (ButtonCell *) cell {
    if (cell.type == CellTypeToOutsideTextMessage) {
        [self presentOutsideMessageAlert];
    } else if (cell.type == CellTypeToOutsideImageMessage) {
        [self presentOutsideMessageImagePicker];
    } else {
        [self showChat: cell.button type: cell.type];
    }
}

- (void) selectCellDidSelect: (THRDesign) design {
    self.design = design;
    [self configureThreads];
    [self.tableView reloadData];
}

- (void)switchCell: (SwitchCell *) cell switched: (BOOL) state {
    if (cell.type == CellTypeDebugMode) {
        PushServerAPI.PUSH_API_LOG_ENABLE = state;
        self.canShowDebugScreen = state;
        [self configureThreads];
    }
}

//Clients Collection Pager

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGRect screen = [UIScreen mainScreen].bounds;
    return CGSizeMake(screen.size.width - 10, 134);
}

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    ClientCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier: [ClientCell getReuseIdentifier] forIndexPath:indexPath];
    
    if (cell == nil) {
        cell = [ClientCell alloc];
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([cell isKindOfClass:[ClientCell class]]) {
        ClientCell* clientCell = (ClientCell*) cell;
        [clientCell setClient: [self.clients objectAtIndex:indexPath.row]];
        [clientCell setDelegate: self];
    }
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.clients.count;
}

- (void) logout:(Client *) client {
    [Threads logout: client.clientId];
    [self.clients removeObject: client];
    [self.clientsPager reloadData];
    [[TAStorage sharedInstance] removeClient: client];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGFloat pageWidth = self.clientsPager.frame.size.width;
    self.currentClientPage = ceil (self.clientsPager.contentOffset.x / pageWidth);
}

- (Client*) getCurrentClient {
    
    UICollectionViewCell* firstVisibleCell = [self.clientsPager.visibleCells objectAtIndex:0];
    if ([firstVisibleCell isKindOfClass: [ClientCell class]]) {
        return [((ClientCell*) firstVisibleCell) getClient];
    } else {
        return nil;
    }
}

- (void) appLaunchedWithNotification: (NSDictionary*) notification {
    
    if ([Threads isThreadsOriginPush: notification]) {
        NSString* appMarker = [Threads getAppMarkerFromPush: notification];
        
        //Starting the apropriate chat for received appMarker
        if (appMarker.length > 0) {
            if (self.clients == nil) {
                self.clients = [[TAStorage sharedInstance] getClients];
            }
            
            Client* pushClient = nil;
            for (Client* client in self.clients) {
                if ([appMarker isEqualToString:client.appMarker]) {
                    pushClient = client;
                }
            }
            
            if (pushClient != nil) {
                //Reconfigure for chat that should be opened
                [Threads setClientId: pushClient.clientId];
                [Threads setClientIdSignature: pushClient.clientIdSignature];
                [Threads setClientName: pushClient.name];
                [Threads setAppMarker:  pushClient.appMarker];
                
                if ([appMarker hasSuffix:@"CRG"]) {
                    self.design = THRDesignBRS;
                } else {
                    self.design = THRDesignDefault;
                }
                
                [self configureThreads];
                
                [self.tabBarController setSelectedIndex:2];
                [self registerAndShow: nil type: CellTypeToFragmentChat];
                
            }
        }
        
        [Threads reloadHistory];
    }
}

- (void) configureDesign {
    if (self.design == THRDesignDefault) {
        self.attributes = [THRAttributes defaultAttributes];
        self.attributes.showWaitingForSpecialistProgress = NO;
        self.attributes.canShowSpecialistInfo = YES;
        self.attributes.navigationBarVisible = YES;
        self.attributes.canShowDebugScreen = self.canShowDebugScreen;
        self.attributes.historyLoadingCount = @(25);
        
        if (@available(iOS 13.0, *)) {
            self.attributes.incomingBubbleColor = [UIColor colorNamed:@"threads_incomingBubbleColor" inBundle:[NSBundle mainBundle] compatibleWithTraitCollection:nil];
            self.attributes.outgoingBubbleColor = [UIColor colorNamed:@"threads_outgoingBubbleColor" inBundle:[NSBundle mainBundle] compatibleWithTraitCollection:nil];
        } else {
            self.attributes.incomingBubbleColor = [UIColor colorWithRed:53.f/255.f green:152.f/255.f blue:220.f/255.f alpha:1.f];
            self.attributes.outgoingBubbleColor = [UIColor colorWithRed:53.f/255.f green:152.f/255.f blue:220.f/255.f alpha:1.f];
        }
        
        self.attributes.incomingBubbleStroked = YES;
        self.attributes.shouldAnimateShowNavigation = NO;
        self.attributes.shouldAnimatePopNavigation = NO;
        self.attributes.navigationBarSubtitleShowOrgUnit = YES;
    } else {
        self.attributes = [THRAttributes defaultAttributes];
        
        self.attributes.refreshColor = [UIColor alt_refreshColor];
        self.attributes.statusBarStyle = UIStatusBarStyleDefault;
        self.attributes.navigationBarBackgroundColor = [UIColor alt_navigationBarBackgroundColor];
        self.attributes.navigationBarTintColor = [UIColor alt_navigationBarTintColor];
        self.attributes.navigationBarTitleFont = [UIFont fontWithName:@"Lato-Semibold" size:18.f];
        self.attributes.navigationBarSubtitleFont = [UIFont fontWithName:@"Lato-Semibold" size:13.f];
        self.attributes.placeholderImage = [UIImage imageNamed:@"placeholder_image"];
        self.attributes.backgroundColor = [UIColor alt_mainBackgroundColor];
        self.attributes.placeholderTitleColor = [UIColor alt_placeholderTitleColor];
        self.attributes.placeholderSubtitleColor = [UIColor alt_placeholderSubtitleColor];
        self.attributes.placeholderTitleFont = [UIFont fontWithName:@"Lato-Semibold" size:19.f];
        self.attributes.placeholderSubtitleFont = [UIFont fontWithName:@"Lato-Regular" size:15.f];
        self.attributes.myMessageFont = [UIFont fontWithName:@"Lato-Regular" size:16.f];
        self.attributes.attachButtonColor = [UIColor alt_attachButtonColor];
        self.attributes.attachButtonHighlightColor = [UIColor alt_attachButtonHighlightColor];
        self.attributes.sendButtonColor = [UIColor alt_sendButtonColor];
        self.attributes.sendButtonHighlightColor = [UIColor alt_sendButtonHighlightColor];
        self.attributes.waitingSpecialistBorderColor = [UIColor alt_waitingSpecialistBorderColor];
        self.attributes.waitingSpecialistSpinnerColor = [UIColor alt_waitingSpecialistSpinnerColor];
        self.attributes.outgoingBubbleColor = [UIColor alt_outgoingBubbleColor];
        self.attributes.outgoingBubbleTextColor = [UIColor alt_outgoingBubbleTextColor];
        self.attributes.outgoingBubbleLinkColor = [UIColor alt_outgoingBubbleLinkColor];
        self.attributes.failedBubbleColor = [UIColor alt_failedBubbleColor];
        self.attributes.incomingBubbleColor = [UIColor alt_incomingBubbleColor];
        self.attributes.incomingBubbleTextColor = [UIColor alt_incomingBubbleTextColor];
        self.attributes.incomingBubbleLinkColor = [UIColor alt_incomingBubbleLinkColor];
        self.attributes.bubbleMessageFont = [UIFont fontWithName:@"Lato-Regular" size:17.f];
        self.attributes.bubbleTimeFont = [UIFont fontWithName:@"Lato-Regular" size:12.f];
        self.attributes.failedMessageFont = [UIFont fontWithName:@"Lato-Semibold" size:12.f];
        self.attributes.messageHeaderFont = [UIFont fontWithName:@"Lato-Semibold" size:13.f];
        self.attributes.specialisConnectTitleFont = [UIFont fontWithName:@"Lato-Semibold" size:17.f];
        self.attributes.specialisConnectSubtitleFont = [UIFont fontWithName:@"Lato-Regular" size:12.f];
        self.attributes.specialisConnectTitleColor = [UIColor alt_specialisConnectTitleColor];
        self.attributes.specialisConnectSubtitleColor = [UIColor alt_specialisConnectSubtitleColor];
        self.attributes.toolbarTintColor = [UIColor alt_toolbarTintColor];
        self.attributes.toolbarQuotedMessageAuthorFont = [UIFont fontWithName:@"Lato-Regular" size:17.f];
        self.attributes.toolbarQuotedMessageFont = [UIFont fontWithName:@"Lato-Light" size:17.f];
        self.attributes.toolbarQuotedMessageAuthorColor = [UIColor alt_toolbarQuotedMessageAuthorColor];
        self.attributes.toolbarQuotedMessageColor = [UIColor alt_toolbarQuotedMessageColor];
        self.attributes.quoteAuthorFont = [UIFont fontWithName:@"Lato-Semibold" size:17.f];
        self.attributes.quoteMessageFont = [UIFont fontWithName:@"Lato-Light" size:17.f];
        self.attributes.quoteFilesizeFont = [UIFont fontWithName:@"Lato-Regular" size:13.f];
        self.attributes.quoteTimeFont = [UIFont fontWithName:@"Lato-Regular" size:13.f];
        self.attributes.outgoingQuoteSeparatorColor = [UIColor alt_outgoingQuoteSeparatorColor];
        self.attributes.outgoingQuoteAuthorColor = [UIColor alt_outgoingQuoteAuthorColor];
        self.attributes.outgoingQuoteMessageColor = [UIColor alt_outgoingQuoteMessageColor];
        self.attributes.outgoingQuoteTimeColor = [UIColor alt_outgoingQuoteTimeColor];
        self.attributes.outgoingQuoteFilesizeColor = [UIColor alt_outgoingQuoteFilesizeColor];
        self.attributes.incomingQuoteSeparatorColor = [UIColor alt_incomingQuoteSeparatorColor];
        self.attributes.incomingQuoteAuthorColor = [UIColor alt_incomingQuoteAuthorColor];
        self.attributes.incomingQuoteMessageColor = [UIColor alt_incomingQuoteMessageColor];
        self.attributes.incomingQuoteTimeColor = [UIColor alt_incomingQuoteTimeColor];
        self.attributes.incomingQuoteFilesizeColor = [UIColor alt_incomingQuoteFilesizeColor];
        self.attributes.incomingFileIconTintColor = [UIColor alt_incomingFileIconTintColor];
        self.attributes.incomingFileIconBgColor = [UIColor alt_incomingFileIconBgColor];
        self.attributes.clearSearchIcon = [UIImage imageNamed:@"ic_clear_search"];
        self.attributes.searchBarTintColor = [UIColor alt_searchBarTintColor];
        self.attributes.searchBarTextColor = [UIColor alt_searchBarTextColor];
        self.attributes.searchBarTextFont = [UIFont fontWithName:@"Lato-Regular" size:14.f];
        self.attributes.searchScopeBarTintColor = [UIColor alt_searchScopeBarTintColor];
        self.attributes.searchScopeBarFont = [UIFont fontWithName:@"Lato-Regular" size:13.f];
        self.attributes.findedMessageHeaderTextColor = [UIColor alt_findedMessageHeaderTextColor];
        self.attributes.findedMessageHeaderBackgroundColor = [UIColor alt_findedMessageHeaderBackgroundColor];
        self.attributes.findedMessageHeaderTextFont = [UIFont fontWithName:@"Lato-Regular" size:13.f];
        self.attributes.findMoreMessageTextColor = [UIColor alt_findMoreMessageTextColor];
        self.attributes.findMoreMessageTextFont = [UIFont fontWithName:@"Lato-Regular" size:15.f];
        self.attributes.searchMessageAuthorTextColor = [UIColor alt_searchMessageAuthorTextColor];
        self.attributes.searchMessageTextColor = [UIColor alt_searchMessageTextColor];
        self.attributes.searchMessageDateTextColor = [UIColor alt_searchMessageDateTextColor];
        self.attributes.searchMessageFileTextColor = [UIColor alt_searchMessageFileTextColor];
        self.attributes.searchMessageMatchTextColor = [UIColor alt_searchMessageMatchTextColor];
        self.attributes.searchMessageAuthorTextFont = [UIFont fontWithName:@"Lato-Regular" size:17.f];
        self.attributes.searchMessageTextFont = [UIFont fontWithName:@"Lato-Regular" size:13.f];
        self.attributes.searchMessageFileTextFont = [UIFont fontWithName:@"Lato-Regular" size:13.f];
        self.attributes.searchMessageDateTextFont = [UIFont fontWithName:@"Lato-Regular" size:13.f];
        self.attributes.searchMessageMatchTextFont = [UIFont fontWithName:@"Lato-Medium" size:13.f];
        self.attributes.photoPickerCheckmarkIcon = [UIImage imageNamed:@"ic_checkmark"];
        self.attributes.photoPickerToolbarTintColor = [UIColor alt_photoPickerToolbarTintColor];
        self.attributes.photoPickerToolbarButtonFont = [UIFont fontWithName:@"Lato-Regular" size:17.f];
        self.attributes.photoPickerSheetTextColor = [UIColor alt_photoPickerSheetTextColor];
        self.attributes.photoPickerSheetTextFont = [UIFont fontWithName:@"Lato-Regular" size:17.f];
        self.attributes.fileViewerNavBarBackgroundColor = self.attributes.navigationBarBackgroundColor;
        self.attributes.fileViewerTitleFont = self.attributes.navigationBarTitleFont;
        self.attributes.fileViewerNavBarTintColor = self.attributes.navigationBarTintColor;
        self.attributes.sendButtonFont = [UIFont fontWithName:@"Lato-Regular" size:17.f];
        self.attributes.messageBubbleFilledMaskImage = [UIImage imageNamed:@"rect_bubble_filled"];
        self.attributes.messageBubbleStrokedMaskImage = [UIImage imageNamed:@"rect_bubble_stroked"];
        self.attributes.typingText = @"печатает...";
        self.attributes.typingTextColor = [UIColor alt_typingTextColor];
        self.attributes.typingTextFont = [UIFont fontWithName:@"Lato-Medium" size:13.f];
        self.attributes.scheduleIcon = [UIImage imageNamed:@"schedule_alert"];
        self.attributes.scheduleAlertFont = [UIFont fontWithName:@"Lato-Semibold" size:17.f];
        self.attributes.scheduleAlertColor = [UIColor alt_scheduleAlertColor];
        self.attributes.scrollToBottomImage = [UIImage imageNamed:@"scroll_down_button_brs"];
        
        self.attributes.surveyTextFont = [UIFont fontWithName:@"Lato-Regular" size:17.f];
        self.attributes.surveyTextColor = [UIColor alt_surveyTextColor];
        self.attributes.surveyCompletionFont = [UIFont fontWithName:@"Lato-Regular" size:17.f];
        self.attributes.surveyCompletionColor = [UIColor alt_surveyCompletionColor];
        self.attributes.iconLikeFull = [[UIImage imageNamed:@"ic_like_filled"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        self.attributes.iconLikeEmpty  = [[UIImage imageNamed:@"ic_like_stroked"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        self.attributes.iconDislikeFull  = [[UIImage imageNamed:@"ic_dislike_filled"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        self.attributes.iconDislikeEmpty  = [[UIImage imageNamed:@"ic_dislike_stroked"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        self.attributes.iconStarRatingFull  = [[UIImage imageNamed:@"ic_heart_filled"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        self.attributes.iconStarRatingEmty = [[UIImage imageNamed:@"ic_heart_stroked"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        self.attributes.likeRatingColorEnabled = [UIColor alt_likeRatingColorEnabled];
        self.attributes.likeRatingColorDisabled = [UIColor alt_likeRatingColorDisabled];
        self.attributes.starRatingColorEnabled = [UIColor alt_starRatingColorEnabled];
        self.attributes.starRatingColorDisabled = [UIColor alt_starRatingColorDisabled];
        self.attributes.likeRatingColorCompleted = [UIColor alt_likeRatingColorCompleted];
        self.attributes.starRatingColorCompleted = [UIColor alt_starRatingColorCompleted];
        
        self.attributes.showWaitingForSpecialistProgress = NO;
        self.attributes.canShowSpecialistInfo = NO;
        self.attributes.showWaitingForSpecialistProgress = NO;
        self.attributes.canShowSpecialistInfo = YES;
        self.attributes.navigationBarVisible = YES;
        self.attributes.canShowDebugScreen = self.canShowDebugScreen;
        self.attributes.historyLoadingCount = @(25);
    }
    
}

@end
