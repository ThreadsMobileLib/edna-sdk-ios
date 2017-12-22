//
//  ChatViewController.m
//  ThreadsApp
//
//  Created by Nikolay Kagala on 31/05/16.
//  Copyright © 2016 Sequenia. All rights reserved.
//

#import "ChatViewController.h"
#import <MMDrawerController/UIViewController+MMDrawerController.h>
#import <MMDrawerController/MMDrawerBarButtonItem.h>

#import <Threads/Threads.h>
#import "AboutViewController.h"

#import "CellTypeHelper.h"
#import "TextCell.h"
#import "LabelCell.h"
#import "ButtonCell.h"
#import "SelectCell.h"
#import "SwitchCell.h"
#import "ClientCell.h"
#import "Client.h"
#import "TAStorage.h"
#import <PushServerAPI/PushServerAPI-Swift.h>

@interface ChatViewController () <UITableViewDelegate, UITableViewDataSource, UICollectionViewDataSource, UICollectionViewDelegate,
TextCellDelegate, ButtonCellDelegate, SelectCellDelegate, SwitchCellDelegate, ClientCellDelegate>

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

- (void) configureDesign {
    if (self.design == THRDesignDefault) {
        self.attributes = [THRAttributes defaultAttributes];
        self.attributes.showWaitingForSpecialistProgress = NO;
        self.attributes.canShowSpecialistInfo = YES;
        self.attributes.navigationBarVisible = YES;
        self.attributes.canShowDebugScreen = self.canShowDebugScreen;
        self.attributes.historyLoadingCount = @(25);
    } else {
        self.attributes = [THRAttributes defaultAttributes];
        self.attributes.refreshColor = [UIColor colorWithRed:131.f/255.f green:177.f/255.f blue:67.f/255.f alpha:1.f];
        self.attributes.navigationBarBackgroundColor = [UIColor colorWithRed:131.f/255.f green:177.f/255.f blue:67.f/255.f alpha:1.f];
        self.attributes.navigationBarTintColor = [UIColor whiteColor];
        self.attributes.navigationBarTitleFont = [UIFont fontWithName:@"Lato-Semibold" size:18.f];
        self.attributes.navigationBarSubtitleFont = [UIFont fontWithName:@"Lato-Semibold" size:13.f];
        self.attributes.placeholderImage = [UIImage imageNamed:@"placeholder_image"];
        self.attributes.backgroundColor = [UIColor colorWithRed:234.f/255.f green:240.f/255.f blue:240.f/255.f alpha:1.f];
        self.attributes.placeholderTitleColor = [UIColor colorWithRed:51.f/255.f green:51.f/255.f blue:51.f/255.f alpha:0.7];
        self.attributes.placeholderSubtitleColor = [UIColor colorWithRed:51.f/255.f green:51.f/255.f blue:51.f/255.f alpha:0.5];
        self.attributes.placeholderTitleFont = [UIFont fontWithName:@"Lato-Semibold" size:19.f];
        self.attributes.placeholderSubtitleFont = [UIFont fontWithName:@"Lato-Regular" size:15.f];
        self.attributes.myMessageFont = [UIFont fontWithName:@"Lato-Regular" size:16.f];
        self.attributes.attachButtonColor = [UIColor colorWithRed:131.f/255.f green:177.f/255.f blue:67.f/255.f alpha:1.f];
        self.attributes.attachButtonHighlightColor = [UIColor colorWithRed:131.f/255.f green:177.f/255.f blue:67.f/255.f alpha:0.7f];
        self.attributes.sendButtonColor = [UIColor colorWithRed:131.f/255.f green:177.f/255.f blue:67.f/255.f alpha:1.f];
        self.attributes.sendButtonHighlightColor = [UIColor colorWithRed:131.f/255.f green:177.f/255.f blue:67.f/255.f alpha:0.7f];
        self.attributes.waitingSpecialistBorderColor = [UIColor clearColor];
        self.attributes.waitingSpecialistSpinnerColor = [UIColor colorWithRed:131.f/255.f green:177.f/255.f blue:67.f/255.f alpha:1.f];
        self.attributes.outgoingBubbleColor = [UIColor colorWithRed:131.f/255.f green:177.f/255.f blue:67.f/255.f alpha:1.f];
        self.attributes.outgoingBubbleTextColor = [UIColor whiteColor];
        self.attributes.failedBubbleColor = [UIColor colorWithRed:244.f/255.f green:67.f/255.f blue:54.f/255.f alpha:1.f];
        self.attributes.incomingBubbleTextColor = [UIColor colorWithRed:51.f/255.f green:51.f/255.f blue:51.f/255.f alpha:1.f];
        self.attributes.bubbleMessageFont = [UIFont fontWithName:@"Lato-Regular" size:17.f];
        self.attributes.bubbleTimeFont = [UIFont fontWithName:@"Lato-Regular" size:12.f];
        self.attributes.failedMessageFont = [UIFont fontWithName:@"Lato-Semibold" size:12.f];
        self.attributes.messageHeaderFont = [UIFont fontWithName:@"Lato-Semibold" size:13.f];
        self.attributes.specialisConnectTitleFont = [UIFont fontWithName:@"Lato-Semibold" size:17.f];
        self.attributes.specialisConnectSubtitleFont = [UIFont fontWithName:@"Lato-Regular" size:12.f];
        self.attributes.specialisConnectTitleColor = [UIColor colorWithRed:51.f/255.f green:51.f/255.f blue:51.f/255.f alpha:1.f];
        self.attributes.specialisConnectSubtitleColor = [UIColor colorWithRed:51.f/255.f green:51.f/255.f blue:51.f/255.f alpha:1.f];
        self.attributes.toolbarTintColor = [UIColor redColor];
        self.attributes.toolbarQuotedMessageAuthorFont = [UIFont fontWithName:@"Lato-Regular" size:17.f];
        self.attributes.toolbarQuotedMessageFont = [UIFont fontWithName:@"Lato-Light" size:17.f];
        self.attributes.toolbarQuotedMessageAuthorColor = [UIColor colorWithRed:51.f/255.f green:51.f/255.f blue:51.f/255.f alpha:1.f];
        self.attributes.toolbarQuotedMessageColor = [UIColor colorWithRed:51.f/255.f green:51.f/255.f blue:51.f/255.f alpha:0.5f];
        self.attributes.quoteAuthorFont = [UIFont fontWithName:@"Lato-Semibold" size:17.f];
        self.attributes.quoteMessageFont = [UIFont fontWithName:@"Lato-Light" size:17.f];
        self.attributes.quoteFilesizeFont = [UIFont fontWithName:@"Lato-Regular" size:13.f];
        self.attributes.quoteTimeFont = [UIFont fontWithName:@"Lato-Regular" size:13.f];
        self.attributes.outgoingQuoteSeparatorColor = [UIColor whiteColor];
        self.attributes.outgoingQuoteAuthorColor = [UIColor whiteColor];
        self.attributes.outgoingQuoteMessageColor = [UIColor whiteColor];
        self.attributes.outgoingQuoteTimeColor = [UIColor whiteColor];
        self.attributes.outgoingQuoteFilesizeColor = [UIColor whiteColor];
        self.attributes.incomingQuoteSeparatorColor = [UIColor colorWithRed:131.f/255.f green:177.f/255.f blue:67.f/255.f alpha:1.f];
        self.attributes.incomingQuoteAuthorColor = [UIColor colorWithRed:51.f/255.f green:51.f/255.f blue:51.f/255.f alpha:1.f];
        self.attributes.incomingQuoteMessageColor = [UIColor colorWithRed:51.f/255.f green:51.f/255.f blue:51.f/255.f alpha:0.7f];
        self.attributes.incomingQuoteTimeColor = [UIColor colorWithRed:51.f/255.f green:51.f/255.f blue:51.f/255.f alpha:0.7f];
        self.attributes.incomingQuoteFilesizeColor = [UIColor colorWithRed:51.f/255.f green:51.f/255.f blue:51.f/255.f alpha:0.7f];
        self.attributes.incomingFileIconTintColor = [UIColor colorWithRed:131.f/255.f green:177.f/255.f blue:67.f/255.f alpha:1.f];
        self.attributes.incomingFileIconBgColor = [UIColor colorWithRed:234.f/255.f green:240.f/255.f blue:240.f/255.f alpha:1.f];
        self.attributes.clearSearchIcon = [UIImage imageNamed:@"ic_clear_search"];
        self.attributes.searchBarTintColor = [UIColor colorWithRed:51.f/255.f green:51.f/255.f blue:51.f/255.f alpha:1.f];
        self.attributes.searchBarTextColor = [UIColor colorWithRed:51.f/255.f green:51.f/255.f blue:51.f/255.f alpha:1.f];
        self.attributes.searchBarTextFont = [UIFont fontWithName:@"Lato-Regular" size:14.f];
        self.attributes.searchScopeBarTintColor = [UIColor colorWithRed:131.f/255.f green:177.f/255.f blue:67.f/255.f alpha:1.f];
        self.attributes.searchScopeBarFont = [UIFont fontWithName:@"Lato-Regular" size:13.f];
        self.attributes.findedMessageHeaderTextColor = [UIColor colorWithRed:51.f/255.f green:51.f/255.f blue:51.f/255.f alpha:0.5f];
        self.attributes.findedMessageHeaderBackgroundColor = [UIColor colorWithRed:234.f/255.f green:240.f/255.f blue:240.f/255.f alpha:1.f];
        self.attributes.findedMessageHeaderTextFont = [UIFont fontWithName:@"Lato-Regular" size:13.f];
        self.attributes.findMoreMessageTextColor = [UIColor colorWithRed:51.f/255.f green:51.f/255.f blue:51.f/255.f alpha:1.f];
        self.attributes.findMoreMessageTextFont = [UIFont fontWithName:@"Lato-Regular" size:15.f];
        self.attributes.searchMessageAuthorTextColor = [UIColor colorWithRed:51.f/255.f green:51.f/255.f blue:51.f/255.f alpha:1.f];;
        self.attributes.searchMessageTextColor = [UIColor colorWithRed:51.f/255.f green:51.f/255.f blue:51.f/255.f alpha:0.7f];
        self.attributes.searchMessageDateTextColor = [UIColor colorWithRed:51.f/255.f green:51.f/255.f blue:51.f/255.f alpha:0.7f];
        self.attributes.searchMessageFileTextColor = [UIColor colorWithRed:51.f/255.f green:51.f/255.f blue:51.f/255.f alpha:0.7f];
        self.attributes.searchMessageMatchTextColor = [UIColor colorWithRed:131.f/255.f green:177.f/255.f blue:67.f/255.f alpha:1.f];
        self.attributes.searchMessageAuthorTextFont = [UIFont fontWithName:@"Lato-Regular" size:17.f];
        self.attributes.searchMessageTextFont = [UIFont fontWithName:@"Lato-Regular" size:13.f];
        self.attributes.searchMessageFileTextFont = [UIFont fontWithName:@"Lato-Regular" size:13.f];
        self.attributes.searchMessageDateTextFont = [UIFont fontWithName:@"Lato-Regular" size:13.f];
        self.attributes.searchMessageMatchTextFont = [UIFont fontWithName:@"Lato-Medium" size:13.f];
        self.attributes.photoPickerCheckmarkIcon = [UIImage imageNamed:@"ic_checkmark"];
        self.attributes.photoPickerToolbarTintColor = [UIColor colorWithRed:131.f/255.f green:177.f/255.f blue:67.f/255.f alpha:1.f];
        self.attributes.photoPickerToolbarButtonFont = [UIFont fontWithName:@"Lato-Regular" size:17.f];
        self.attributes.photoPickerSheetTextColor = [UIColor colorWithRed:131.f/255.f green:177.f/255.f blue:67.f/255.f alpha:1.f];
        self.attributes.photoPickerSheetTextFont = [UIFont fontWithName:@"Lato-Regular" size:17.f];
        self.attributes.sendButtonFont = [UIFont fontWithName:@"Lato-Regular" size:17.f];
        self.attributes.messageBubbleFilledMaskImage = [UIImage imageNamed:@"rect_bubble_filled"];
        self.attributes.messageBubbleStrokedMaskImage = [UIImage imageNamed:@"rect_bubble_stroked"];
        self.attributes.typingText = @"печатает...";
        self.attributes.typingTextColor = [UIColor colorWithRed:51.f/255.f green:51.f/255.f blue:51.f/255.f alpha:0.5f];
        self.attributes.typingTextFont = [UIFont fontWithName:@"Lato-Medium" size:13.f];
        self.attributes.scheduleIcon = [UIImage imageNamed:@"schedule_alert"];
        self.attributes.scheduleAlertFont = [UIFont fontWithName:@"Lato-Semibold" size:17.f];
        self.attributes.scheduleAlertColor = [UIColor colorWithRed:51.f/255.f green:51.f/255.f blue:51.f/255.f alpha:1.f];
        self.attributes.scrollToBottomImage = [UIImage imageNamed:@"scroll_down_button_brs"];
        self.attributes.showWaitingForSpecialistProgress = NO;
        self.attributes.canShowSpecialistInfo = NO;
        self.attributes.showWaitingForSpecialistProgress = NO;
        self.attributes.canShowSpecialistInfo = YES;
        self.attributes.navigationBarVisible = YES;
        self.attributes.canShowDebugScreen = self.canShowDebugScreen;
        self.attributes.historyLoadingCount = @(25);
    }
}

- (void) showChat: (UIButton *) button type: (CellType) type {
    [self.view endEditing:YES];
    
    if (self.clients.count > 0) {
        Client* client = [self getCurrentClient];
        if (client.clientId.length > 0) {
            
            [Threads setClientId:client.clientId];
            [Threads setClientName:client.name];
            
            [self configureThreads];
            [self registerAndShow: button type: type];
        }
    } else {
        [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"input_login_alert", @"")
                                    message:@""
                                   delegate:nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil] show];
    }
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
                [Threads showInView: self.chatContainer
                   parentController: self
                      bottomSpacing: self.tabBarController.tabBar.frame.size.height];
                [self.view bringSubviewToFront:self.chatContainer];
            } else {
                [Threads show];
            }
            [[Threads threads] setUnreadedMessagesCountChanged:^(NSInteger messagesCount) {
                UINavigationController *navController = self.tabBarController.viewControllers.lastObject;
                AboutViewController *emp = navController.viewControllers.firstObject;
                emp.counterLabel.text = [NSString stringWithFormat:@"%ld", (long)messagesCount];
                NSString *badge = (messagesCount > 0) ? emp.counterLabel.text : nil;
                [self.tabBarController.tabBar.items.lastObject setBadgeValue: badge];
            }];
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
    
    [alert addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //Cancel
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"Done" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSString* newClientId = clientIdInput.text;
        NSString* newClientName = clientNameInput.text;
        if (newClientId.length > 0) {
            [self addClient: [Client clientWithId:newClientId name:newClientName]];
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

- (IBAction) changeBottomSpacing:(id)sender {
    if(_bottomSpacing == 0) {
        _bottomSpacing = self.tabBarController.tabBar.frame.size.height;
    }
    else {
        _bottomSpacing = 0;
    }
    [Threads setMessageInputInset:_bottomSpacing animated:YES];
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
    [self showChat: cell.button type: cell.type];
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

@end
