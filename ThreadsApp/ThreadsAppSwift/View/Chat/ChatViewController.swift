//
//  ThreadsApp
//
//  Copyright © 2019 Brooma Service. All rights reserved.
//
import UIKit
import MFMSPushLite
import MMDrawerController
import Threads

class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UICollectionViewDataSource,
    UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UITabBarControllerDelegate,
ButtonCellDelegate, SelectCellDelegate, SwitchCellDelegate, ClientCellDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var chatContainer: UIView!
    @IBOutlet weak var clientsPager: UICollectionView!
    @IBOutlet weak var addClient: UIButton!
    @IBOutlet private weak var tableView: UITableView!
    private var inputVisible = false
    private var bottomSpacing: CGFloat = 0.0
    private var attributes: THRAttributes!
    private var design: THRDesign?
    private var canShowDebugScreen = false
    private var clients: [Client] = []
    private var currentClientPage: Int = 0
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationBar()
        configureDrawer()
        configureClientsPager()
        configureTableView()
        
        tabBarController?.delegate = self
        
        design = .Default
        canShowDebugScreen = false
        inputVisible = true
        bottomSpacing = tabBarController?.tabBar.frame.size.height ?? 0
    }
    
    // MARK: - Configguring Controller
    
    func configureNavigationBar() {
        let appName = Bundle.main.infoDictionary?["CFBundleDisplayName"] as? String
        navigationItem.title = appName
    }
    
    func configureDrawer() {
        let sel: Selector = #selector(self.rightDrawerButtonPress(_:))
        let rightDrawerButton = MMDrawerBarButtonItem(target: self, action: sel)
        navigationItem.setRightBarButton(rightDrawerButton, animated: true)
    }
    
    func configureClientsPager() {
        clientsPager.delegate = self
        clientsPager.dataSource = self
        clients = TAStorage.instance.getClients()
    }
    
    func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.keyboardDismissMode = .onDrag
        tableView.estimatedRowHeight = 44.0
        tableView.rowHeight = UITableView.automaticDimension
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
    }
    
    // MARK: - Drawer Actions
    
    func didTap() {
        view.endEditing(true)
    }
    
    @objc func rightDrawerButtonPress(_ sender: Any?) {
        mm_drawerController.toggle(MMDrawerSide.right, animated: true) { finished in
        }
    }
    
    // MARK: - TabBar
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        
        if (viewController.children.first is ChatFragmentViewController) {
            self.showChat(button: nil, type: .FragmentChat)
        }
        
        return true;
    }
    
    
    
    
    // MARK: - Table View
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CellType.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let type = CellType.allCases[indexPath.row]
        
        switch type {
            
        case .Version:
            return self.labelCell(indexPath: indexPath, type: type)
        case .Design:
            return self.selectCell(indexPath: indexPath, type: type)
        case .DebugMode:
            return self.switchCell(indexPath: indexPath, type: type)
        case .FragmentChat:
            return self.buttonCell(indexPath: indexPath, type: type)
        case .FullChat:
            return self.buttonCell(indexPath: indexPath, type: type)
        case .OtherChats:
            return self.buttonCell(indexPath: indexPath, type: type)
        case .OutsideText:
            return self.buttonCell(indexPath: indexPath, type: type)
        case .OutsideImage:
            return self.buttonCell(indexPath: indexPath, type: type)
        }
    }
    
    func labelCell(indexPath: IndexPath, type: CellType) -> LabelCell {
        
        let identifier = String(describing: LabelCell.self)
        let cell = self.tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! LabelCell
        cell.type = type
        cell.construct()
        
        return cell;
    }
    
    func buttonCell(indexPath: IndexPath, type: CellType) -> ButtonCell {
        
        let identifier = String(describing: ButtonCell.self)
        let cell = self.tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! ButtonCell
        cell.type = type
        cell.delegate = self
        cell.construct()
        
        return cell;
    }
    
    func selectCell(indexPath: IndexPath, type: CellType) -> SelectCell {
        
        let identifier = String(describing: SelectCell.self)
        let cell = self.tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! SelectCell
        cell.type = type
        cell.selectedDesign = self.design ?? .Default
        cell.delegate = self
        cell.construct()
        
        return cell;
    }
    
    func switchCell(indexPath: IndexPath, type: CellType) -> SwitchCell {
        
        let identifier = String(describing: SwitchCell.self)
        let cell = self.tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! SwitchCell
        cell.type = type
        cell.delegate = self;
        cell.construct()
        
        return cell;
    }
    
    // MARK: - TableView Actions
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)

        if let selectCell = tableView.cellForRow(at: indexPath) as? SelectCell, selectCell.type == .Design {
            selectCell.showDesignController(in: self, withDesigns: THRDesign.allCases)
        }
    }
    
    func buttonCellClicked(_ cell: ButtonCell) {
        switch cell.type {
        case .OutsideText:
            presentOutsideMessageAlert()
        case .OutsideImage:
            presentOutsideMessageImagePicker()
        default:
            showChat(button: cell.button, type: cell.type)
        }
    }
    
    func selectCellDidSelect(design: THRDesign) {
        self.design = design
        self.configureThreads()
        self.tableView.reloadData()
    }
    
    func switchCell(_ cell: SwitchCell, switched state: Bool) {
        if (cell.type == .DebugMode) {
            PushServerAPI.PUSH_API_LOG_ENABLE = state;
            self.canShowDebugScreen = state;
            self.configureThreads();
        }
    }
    
    // MARK: - Clients Collection Pager
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let screen = UIScreen.main.bounds
        return CGSize(width: screen.size.width - 10, height: 134);
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(withReuseIdentifier: ClientCell.getReuseIdentifier(), for: indexPath) as! ClientCell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        if (cell is ClientCell) {
            let clientCell = cell as! ClientCell
            clientCell.setClient(self.clients[indexPath.row])
            clientCell.delegate = self
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.clients.count
    }
    
    func addClient (client: Client) {
        self.clients.append(client)
        self.clientsPager.reloadData()
        TAStorage.instance.addClient(client)
    }
    
    func logout(client: Client) {
        Threads.logout(client.clientId)
        if let indexToRemove = self.clients.firstIndex(of: client) {
            self.clients.remove(at: indexToRemove)
        }
        self.clientsPager.reloadData()
        TAStorage.instance.removeClient(client)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageWidth = self.clientsPager.frame.size.width;
        self.currentClientPage = Int (self.clientsPager.contentOffset.x / pageWidth)
    }
    
    func getCurrentClient() -> Client {
        let firstVisibleCell = self.clientsPager.visibleCells[0]
        return (firstVisibleCell as! ClientCell).getClient()
    }
    
    // MARK: - Client creation
    
    @IBAction func addClientAction(_ sender: Any) {
        
        let alert = UIAlertController(title: "Add Client:", message: "", preferredStyle: UIAlertController.Style.alert)
        
        var clientIdInput: UITextField? = nil
        alert.addTextField(configurationHandler: { textField in
            textField.placeholder = "Client Id (required)"
            clientIdInput = textField
        })
        
        var clientNameInput: UITextField? = nil
        alert.addTextField(configurationHandler: { textField in
            textField.placeholder = "Client Name (optional)"
            clientNameInput = textField
        })
        
        var appMarkerInput: UITextField? = nil
        alert.addTextField(configurationHandler: { textField in
            textField.placeholder = "App Marker (optional)"
            appMarkerInput = textField
        })
        
        var clientIdSignatureInput: UITextField? = nil
        alert.addTextField(configurationHandler: { textField in
            textField.placeholder = "Signature (if empty - will load from server)"
            clientIdSignatureInput = textField
        })
        
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: { action in
            //Cancel
        }))
        
        alert.addAction(UIAlertAction(title: "Done", style: UIAlertAction.Style.default, handler: { action in
            
            let newClientId = clientIdInput?.text
            let newClientName = clientNameInput?.text
            let newAppMarker = appMarkerInput?.text
            let newClientIdSignature = clientIdSignatureInput?.text
            
            if let clientId = newClientId, !clientId.isEmpty {
                
                if (!(newClientIdSignature ?? "").isEmpty) {
                    self.addClient(client: Client(withId: clientId, name: newClientName,
                                                  appMarker: newAppMarker, clientIdSignature: newClientIdSignature))
                } else {
                    
                    ServerAPI.getSignature(forClientId: clientId, withCompletion: { (returnedSignature, error) in
                        
                        var signature = returnedSignature
                        
                        DispatchQueue.main.async {
                            if (error != nil) {
                                self.showAlert(alert: "Signature loading failed, left empty")
                                NSLog("Signature loading failed, left empty")
                                signature = ""
                            }
                            self.addClient(client: Client(withId: clientId, name: newClientName,
                                                          appMarker: newAppMarker, clientIdSignature: signature))
                        }
                    })
                    
                }
                
            }
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    
    // MARK: - Configure & Show Chat
    
    func showChat(button: (UIButton?), type: CellType) {
        
        self.view.endEditing(true)
        
        
        if (self.clients.count > 0) {
            let client = self.getCurrentClient()
            if (!client.clientId.isEmpty) {
                
                Threads.setClientId(client.clientId)
                Threads.setClientIdSignature(client.clientIdSignature ?? "")
                Threads.setClientName(client.name ?? "")
                Threads.setAppMarker(client.appMarker ?? "")
                self.configureThreads()
                self.registerAndShow(button:button, type:type)
                
            } else {
                self.showAlert(alert: NSLocalizedString("input_login_alert", comment:""))
            }
        } else {
            self.showAlert(alert: NSLocalizedString("input_login_alert", comment:""))
        }
    }
    
    
    func showAlert(alert: (String)) {
        UIAlertView(title: alert, message: "", delegate: nil, cancelButtonTitle: "OK", otherButtonTitles: "").show()
    }
    
    func configureThreads() {
        
        self.configureDesign()
        Threads.clearCachedFiles()
        Threads.setAttributes(self.attributes)
        Threads.setData("{\"param1\": \"value1\"}")
    }
    
    func registerAndShow(button: UIButton?, type: CellType) {
        
        button?.isEnabled = false;
        
        Threads.registerClient(completion: {(state, error) in
            
            button?.isEnabled = true;
            
            print("Registration Failed due to error: \(error.localizedDescription)")
            
            if (state) {
                if (type == .FragmentChat) {
                    
                    if (button == nil) {
                        
                        let fragmentController = self.tabBarController!.viewControllers![2].children.first as! ChatFragmentViewController
                        
                        Threads.show(in: fragmentController.chatContainer, parentController: fragmentController)
                        
                    } else {
                        Threads.show(in: self.chatContainer, parentController: self)
                        self.view.bringSubviewToFront(self.chatContainer)
                    }
                    
                } else if (type == .OtherChats) {
                    self.performSegue(withIdentifier: "showChatInStack", sender: self)
                } else {
                    Threads.show()
                }
                self.configureUnreadCounter()
                
            } else {
                
                let alert = UIAlertController(title:"Registration failed. Retry?", message:nil, preferredStyle:UIAlertController.Style.alert)
                
                let actionOk = UIAlertAction(title: "Yes", style: UIAlertAction.Style.default, handler: { action in
                    self.registerAndShow(button: button, type: type)
                })
                
                let actionCancel = UIAlertAction(title:"No", style:UIAlertAction.Style.cancel, handler:nil)
                alert.addAction(actionOk)
                alert.addAction(actionCancel)
                self.present(alert, animated:true, completion:nil)
            }
        })
    }
    
    @IBAction func showOrHideInput(_ sender: Any) {
        
        inputVisible ? Threads.hideToolbar(animated: false) : Threads.showToolbar(animated: false)
        inputVisible = !inputVisible
    }
    
    func configureUnreadCounter() {
        
        Threads.threads().unreadedMessagesCountChanged = { (messagesCount) in
            let navController = self.tabBarController?.viewControllers?[1] as? UINavigationController
            let aboutController = navController?.viewControllers.first as? AboutViewController
            aboutController?.setCounterValue(messagesCount)
            let badge = (messagesCount > 0) ? String(format: "%ld", messagesCount) : nil;
            if (self.tabBarController?.selectedIndex != 2 || messagesCount == 0) {
                self.tabBarController?.tabBar.items?[2].badgeValue = badge
            }
        }
    }
    
    // MARK: - Starting from push
    
    func appLaunched(withNotification notification: [AnyHashable : Any]?) {
        
        if (notification != nil && Threads.isThreadsOriginPush(notification!)) {
            let appMarker = Threads.getAppMarker(fromPush: notification!)
            
            //Starting the apropriate chat for received appMarker
            
            //Objc returns null as "", so here appMarker can't be null
            if (!appMarker.isEmpty) {
                
                if (self.clients.isEmpty) {
                    self.clients = TAStorage.instance.getClients()
                }
                
                var pushClient: Client?
                for client in self.clients {
                    if (appMarker == client.appMarker) {
                        pushClient = client;
                    }
                }
                
                if let client = pushClient {
                    //Reconfigure for chat that should be opened
                    Threads.setClientId(client.clientId)
                    Threads.setClientIdSignature(client.clientIdSignature ?? "")
                    Threads.setClientName(client.name ?? "")
                    Threads.setAppMarker(client.appMarker ?? "")
                    
                    if (appMarker.hasSuffix("CRG")) {
                        self.design = .BRS;
                    } else {
                        self.design = .Default;
                    }
                    
                    self.configureThreads()
                    
                    self.tabBarController?.selectedIndex = 2
                    self.registerAndShow(button: nil, type: .FragmentChat)
                    
                }
            }
            Threads.reloadHistory()
        }
    }
    
    // MARK: - Outside Message
    
    func presentOutsideMessageAlert() {
        let alert = UIAlertController(title: "Outside Message", message: "You can submit message outside chat. Message will be submitted from user.", preferredStyle: .alert)
        alert.addTextField(configurationHandler: { textField in
            textField.placeholder = "Text"
        })
        alert.addAction(UIAlertAction(title: "Submit", style: .default, handler: { action in
            let text = alert.textFields?[0].text?.trimmingCharacters(in: .whitespaces) ?? ""
            if !text.isEmpty {
                self.submitOutsideMessage(with: text)
            } else {
                self.present(alert, animated: true)
            }
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { action in
            // nothing
        }))
        present(alert, animated: true)
    }

    func submitOutsideMessage(with text: String) {
        
        let threads = Threads.threads()
        
        if !prepareForSubmittingOutsideMessage() {
            return
        }
        
        threads.submitMessage(withText: text) { success, error in
            if success {
                self.presentSuccessfulySubmitedOutsideMessageAlert()
            } else {
                self.presentFailedSubmissionOutsideMessageAlertWithError(error)
            }
        }
    }
    
    func presentOutsideMessageImagePicker() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        present(picker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let chosenImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
        picker.dismiss(animated: true) {
            self.submitOutsideImageMessage(with: chosenImage)
        }
    }
    
    func submitOutsideImageMessage(with image: UIImage) {
        let threads = Threads.threads()
        
        if !prepareForSubmittingOutsideMessage() {
            return
        }
        
        threads.submitMessage(with: image) { success, error in
            if success {
                self.presentSuccessfulySubmitedOutsideMessageAlert()
            } else {
                self.presentFailedSubmissionOutsideMessageAlertWithError(error)
            }
        }
    }

    func prepareForSubmittingOutsideMessage() -> Bool {
        let threads = Threads.threads()
        
        if clients.count > 0 {
            let client = getCurrentClient()
            
            if threads.isConfigured() && threads.clientId == client.clientId {
                return true
            } else if !client.clientId.isEmpty {
                Threads.setClientId(client.clientId)
                Threads.setClientIdSignature(client.clientIdSignature ?? "")
                Threads.setClientName(client.name ?? "")
                Threads.setAppMarker(client.appMarker ?? "")
                configureThreads()
                return true
            } else {
                showAlert(alert: NSLocalizedString("input_login_alert", comment: ""))
                return false
            }
        } else {
            showAlert(alert: NSLocalizedString("input_login_alert", comment: ""))
            return false
        }
    }

    func presentSuccessfulySubmitedOutsideMessageAlert() {
        let alert = UIAlertController(title: "Success", message: "Your message successfuly submited.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { action in
            // nothing
        }))
        present(alert, animated: true)
    }
    
    func presentFailedSubmissionOutsideMessageAlertWithError(_ error: Error) {
        let errorMessage = (error as NSError).userInfo["error_description"] as? String ?? "Submission failed"
        let alert = UIAlertController(title: "Failed", message: errorMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { action in
            // nothing
        }))
        present(alert, animated: true)
    }

    
    // MARK: - Configuring Chat Design
    
    func configureDesign() {
        
        if (design == .Default) {
            
            attributes = THRAttributes.default()
            
            attributes.showWaitingForSpecialistProgress = false;
            attributes.canShowSpecialistInfo = true;
            attributes.navigationBarVisible = true;
            attributes.canShowDebugScreen = self.canShowDebugScreen;
            attributes.historyLoadingCount = 25;
            
            attributes.incomingBubbleColor = UIColor(red: 53.0/255.0, green: 152.0/255.0, blue: 220.0/255.0, alpha: 1.0)
            
            attributes.incomingBubbleStroked = true;
            attributes.shouldAnimateShowNavigation = false;
            attributes.shouldAnimatePopNavigation = false;
            attributes.navigationBarTintColor = UIColor.yellow;
            attributes.navigationBarSubtitleShowOrgUnit = true;
        } else {
            attributes = THRAttributes.default()
            
            attributes.refreshColor = UIColor(red:131.0/255.0, green:177.0/255.0, blue:67.0/255.0, alpha:1.0)
            attributes.statusBarStyle = .default
            
            
            attributes.navigationBarBackgroundColor = UIColor(red:131.0/255.0, green:177.0/255.0, blue:67.0/255.0, alpha:1.0)
            attributes.navigationBarTintColor = UIColor.white
            
            let navigationBarTitleFont = UIFont(name: "Lato-Semibold", size: 18.0)
            if (navigationBarTitleFont != nil) {
                attributes.navigationBarTitleFont = navigationBarTitleFont!
            }
            
            let navigationBarSubtitleFont = UIFont(name: "Lato-Semibold", size:13.0)
            if (navigationBarSubtitleFont != nil) {
                attributes.navigationBarSubtitleFont = navigationBarSubtitleFont!
            }
            
            let placeholderImage = UIImage(named: "placeholder_image")
            if (placeholderImage != nil) {
                attributes.placeholderImage = placeholderImage!
            }
            
            attributes.backgroundColor = UIColor(red:234.0/255.0, green:240.0/255.0, blue:240.0/255.0, alpha:1.0)
            
            attributes.placeholderTitleColor = UIColor(red:51.0/255.0, green:51.0/255.0, blue:51.0/255.0, alpha:0.7)
            attributes.placeholderSubtitleColor = UIColor(red:51.0/255.0, green:51.0/255.0, blue:51.0/255.0, alpha:0.5)
            
            let placeholderTitleFont = UIFont(name: "Lato-Semibold", size:19.0)
            if (placeholderTitleFont != nil) {
                attributes.placeholderTitleFont = placeholderTitleFont!
            }
            
            let placeholderSubtitleFont = UIFont(name: "Lato-Regular", size:15.0)
            if (placeholderSubtitleFont != nil) {
                attributes.placeholderSubtitleFont = placeholderSubtitleFont!
            }
            
            let myMessageFont = UIFont(name: "Lato-Regular", size:16.0)
            if (myMessageFont != nil) {
                attributes.myMessageFont = myMessageFont!
            }
            
            attributes.attachButtonColor = UIColor(red:131.0/255.0, green:177.0/255.0, blue:67.0/255.0, alpha:1.0)
            attributes.attachButtonHighlightColor = UIColor(red:131.0/255.0, green:177.0/255.0, blue:67.0/255.0, alpha:0.7)
            
            attributes.sendButtonColor = UIColor(red:131.0/255.0, green:177.0/255.0, blue:67.0/255.0, alpha:1.0)
            attributes.sendButtonHighlightColor = UIColor(red:131.0/255.0, green:177.0/255.0, blue:67.0/255.0, alpha:0.7)
            
            attributes.waitingSpecialistBorderColor = UIColor.clear
            attributes.waitingSpecialistSpinnerColor = UIColor(red:131.0/255.0, green:177.0/255.0, blue:67.0/255.0, alpha:1.0)
            
            attributes.outgoingBubbleColor = UIColor(red:131.0/255.0, green:177.0/255.0, blue:67.0/255.0, alpha:1.0)
            attributes.outgoingBubbleTextColor = UIColor.white
            attributes.outgoingBubbleLinkColor = UIColor.blue
            attributes.failedBubbleColor = UIColor(red:244.0/255.0, green:67.0/255.0, blue:54.0/255.0, alpha:1.0)
            attributes.incomingBubbleTextColor = UIColor(red:51.0/255.0, green:51.0/255.0, blue:51.0/255.0, alpha:1.0)
            attributes.incomingBubbleLinkColor = UIColor(red:131.0/255.0, green:177.0/255.0, blue:67.0/255.0, alpha:1.0)
            
            let bubbleMessageFont = UIFont(name: "Lato-Regular", size:17.0)
            if (bubbleMessageFont != nil) {
                attributes.bubbleMessageFont = bubbleMessageFont!
            }
            
            let bubbleTimeFont = UIFont(name: "Lato-Regular", size:12.0)
            if (bubbleTimeFont != nil) {
                attributes.bubbleTimeFont = bubbleTimeFont!
            }
            
            let failedMessageFont = UIFont(name: "Lato-Semibold", size:12.0)
            if (failedMessageFont != nil) {
                attributes.failedMessageFont = failedMessageFont!
            }
            
            let messageHeaderFont = UIFont(name: "Lato-Semibold", size:13.0)
            if (messageHeaderFont != nil) {
                attributes.messageHeaderFont = messageHeaderFont!
            }
            
            let specialisConnectTitleFont = UIFont(name: "Lato-Semibold", size:17.0)
            if (specialisConnectTitleFont != nil) {
                attributes.specialisConnectTitleFont = specialisConnectTitleFont!
            }
            
            let specialisConnectSubtitleFont = UIFont(name: "Lato-Regular", size:12.0)
            if (specialisConnectSubtitleFont != nil) {
                attributes.specialisConnectSubtitleFont = specialisConnectSubtitleFont!
            }
            
            attributes.specialisConnectTitleColor = UIColor(red:51.0/255.0, green:51.0/255.0, blue:51.0/255.0, alpha:1.0)
            attributes.specialisConnectSubtitleColor = UIColor(red:51.0/255.0, green:51.0/255.0, blue:51.0/255.0, alpha:1.0)
            
            attributes.toolbarTintColor = UIColor.red
            
            let toolbarQuotedMessageAuthorFont = UIFont(name: "Lato-Regular", size:17.0)
            if (toolbarQuotedMessageAuthorFont != nil) {
                attributes.toolbarQuotedMessageAuthorFont = toolbarQuotedMessageAuthorFont!
            }
            
            let toolbarQuotedMessageFont = UIFont(name: "Lato-Light", size:17.0)
            if (toolbarQuotedMessageFont != nil) {
                attributes.toolbarQuotedMessageFont = toolbarQuotedMessageFont!
            }
            
            attributes.toolbarQuotedMessageAuthorColor = UIColor(red:51.0/255.0, green:51.0/255.0, blue:51.0/255.0, alpha:1.0)
            attributes.toolbarQuotedMessageColor = UIColor(red:51.0/255.0, green:51.0/255.0, blue:51.0/255.0, alpha:0.5)
            
            let quoteAuthorFont = UIFont(name: "Lato-Semibold", size:17.0)
            if (quoteAuthorFont != nil) {
                attributes.quoteAuthorFont = quoteAuthorFont!
            }
            
            let quoteMessageFont = UIFont(name: "Lato-Light", size:17.0)
            if (quoteMessageFont != nil) {
                attributes.quoteMessageFont = quoteMessageFont!
            }
            
            let quoteFilesizeFont = UIFont(name: "Lato-Regular", size:13.0)
            if (quoteFilesizeFont != nil) {
                attributes.quoteFilesizeFont = quoteFilesizeFont!
            }
            
            let quoteTimeFont = UIFont(name: "Lato-Regular", size:13.0)
            if (quoteTimeFont != nil) {
                attributes.quoteTimeFont = quoteTimeFont!
            }
            
            attributes.outgoingQuoteSeparatorColor = UIColor.white
            attributes.outgoingQuoteAuthorColor = UIColor.white
            attributes.outgoingQuoteMessageColor = UIColor.white
            attributes.outgoingQuoteTimeColor = UIColor.white
            attributes.outgoingQuoteFilesizeColor = UIColor.white
            
            attributes.incomingQuoteSeparatorColor = UIColor(red:131.0/255.0, green:177.0/255.0, blue:67.0/255.0, alpha:1.0)
            attributes.incomingQuoteAuthorColor = UIColor(red:51.0/255.0, green:51.0/255.0, blue:51.0/255.0, alpha:1.0)
            attributes.incomingQuoteMessageColor = UIColor(red:51.0/255.0, green:51.0/255.0, blue:51.0/255.0, alpha:0.7)
            attributes.incomingQuoteTimeColor = UIColor(red:51.0/255.0, green:51.0/255.0, blue:51.0/255.0, alpha:0.7)
            attributes.incomingQuoteFilesizeColor = UIColor(red:51.0/255.0, green:51.0/255.0, blue:51.0/255.0, alpha:0.7)
            attributes.incomingFileIconTintColor = UIColor(red:131.0/255.0, green:177.0/255.0, blue:67.0/255.0, alpha:1.0)
            attributes.incomingFileIconBgColor = UIColor(red:234.0/255.0, green:240.0/255.0, blue:240.0/255.0, alpha:1.0)
            
            let clearSearchIcon = UIImage(named:"ic_clear_search")
            if (clearSearchIcon != nil) {
                attributes.clearSearchIcon = clearSearchIcon!
            }
            attributes.searchBarTintColor = UIColor(red:51.0/255.0, green:51.0/255.0, blue:51.0/255.0, alpha:1.0)
            attributes.searchBarTextColor = UIColor(red:51.0/255.0, green:51.0/255.0, blue:51.0/255.0, alpha:1.0)
            
            let searchBarTextFont = UIFont(name: "Lato-Regular", size:14.0)
            if (searchBarTextFont != nil) {
                attributes.searchBarTextFont = searchBarTextFont!
            }
            attributes.searchScopeBarTintColor = UIColor(red:131.0/255.0, green:177.0/255.0, blue:67.0/255.0, alpha:1.0)
            
            let searchScopeBarFont = UIFont(name: "Lato-Regular", size:13.0)
            if (searchScopeBarFont != nil) {
                attributes.searchScopeBarFont = searchScopeBarFont!
            }
            
            attributes.findedMessageHeaderTextColor = UIColor(red:51.0/255.0, green:51.0/255.0, blue:51.0/255.0, alpha:0.5)
            attributes.findedMessageHeaderBackgroundColor = UIColor(red:234.0/255.0, green:240.0/255.0, blue:240.0/255.0, alpha:1.0)
            
            let findedMessageHeaderTextFont = UIFont(name: "Lato-Regular", size:13.0)
            if (findedMessageHeaderTextFont != nil) {
                attributes.findedMessageHeaderTextFont = findedMessageHeaderTextFont!
            }
            
            attributes.findMoreMessageTextColor = UIColor(red:51.0/255.0, green:51.0/255.0, blue:51.0/255.0, alpha:1.0)
            let findMoreMessageTextFont = UIFont(name: "Lato-Regular", size:15.0)
            if (findMoreMessageTextFont != nil) {
                attributes.findMoreMessageTextFont = findMoreMessageTextFont!
            }
            
            attributes.searchMessageAuthorTextColor = UIColor(red:51.0/255.0, green:51.0/255.0, blue:51.0/255.0, alpha:1.0);
            attributes.searchMessageTextColor = UIColor(red:51.0/255.0, green:51.0/255.0, blue:51.0/255.0, alpha:0.7)
            attributes.searchMessageDateTextColor = UIColor(red:51.0/255.0, green:51.0/255.0, blue:51.0/255.0, alpha:0.7)
            attributes.searchMessageFileTextColor = UIColor(red:51.0/255.0, green:51.0/255.0, blue:51.0/255.0, alpha:0.7)
            attributes.searchMessageMatchTextColor = UIColor(red:131.0/255.0, green:177.0/255.0, blue:67.0/255.0, alpha:1.0)
            
            let searchMessageAuthorTextFont = UIFont(name: "Lato-Regular", size:17.0)
            if (searchMessageAuthorTextFont != nil) {
                attributes.searchMessageAuthorTextFont = searchMessageAuthorTextFont!
            }
            
            let searchMessageTextFont = UIFont(name: "Lato-Regular", size:13.0)
            if (searchMessageTextFont != nil) {
                attributes.searchMessageTextFont = searchMessageTextFont!
            }
            
            let searchMessageFileTextFont = UIFont(name: "Lato-Regular", size:13.0)
            if (searchMessageFileTextFont != nil) {
                attributes.searchMessageFileTextFont = searchMessageFileTextFont!
            }
            
            let searchMessageDateTextFont = UIFont(name: "Lato-Regular", size:13.0)
            if (searchMessageDateTextFont != nil) {
                attributes.searchMessageDateTextFont = searchMessageDateTextFont!
            }
            
            let searchMessageMatchTextFont = UIFont(name: "Lato-Medium", size:13.0)
            if (searchMessageMatchTextFont != nil) {
                attributes.searchMessageMatchTextFont = searchMessageMatchTextFont!
            }
            
            let photoPickerCheckmarkIcon = UIImage(named:"ic_checkmark")
            if (photoPickerCheckmarkIcon != nil) {
                attributes.photoPickerCheckmarkIcon = photoPickerCheckmarkIcon!
            }
            attributes.photoPickerToolbarTintColor = UIColor(red:131.0/255.0, green:177.0/255.0, blue:67.0/255.0, alpha:1.0)
            
            let photoPickerToolbarButtonFont = UIFont(name: "Lato-Regular", size:17.0)
            if (photoPickerToolbarButtonFont != nil) {
                attributes.photoPickerToolbarButtonFont = photoPickerToolbarButtonFont!
            }
            
            attributes.photoPickerSheetTextColor = UIColor(red:131.0/255.0, green:177.0/255.0, blue:67.0/255.0, alpha:1.0)
            
            let photoPickerSheetTextFont = UIFont(name: "Lato-Regular", size:17.0)
            if (photoPickerSheetTextFont != nil) {
                attributes.photoPickerSheetTextFont = photoPickerSheetTextFont!
            }
            
            attributes.fileViewerNavBarBackgroundColor = attributes.navigationBarBackgroundColor;
            attributes.fileViewerTitleFont = attributes.navigationBarTitleFont;
            attributes.fileViewerNavBarTintColor = attributes.navigationBarTintColor;
            
            let sendButtonFont = UIFont(name: "Lato-Regular", size:17.0)
            if (sendButtonFont != nil) {
                attributes.sendButtonFont = sendButtonFont!
            }
            
            let messageBubbleFilledMaskImage = UIImage(named:"rect_bubble_filled")
            if (messageBubbleFilledMaskImage != nil) {
                attributes.messageBubbleFilledMaskImage = messageBubbleFilledMaskImage!
            }
            
            let messageBubbleStrokedMaskImage = UIImage(named:"rect_bubble_stroked")
            if (messageBubbleStrokedMaskImage != nil) {
                attributes.messageBubbleStrokedMaskImage = messageBubbleStrokedMaskImage!
            }
            
            attributes.typingText = "печатает...";
            attributes.typingTextColor = UIColor(red:51.0/255.0, green:51.0/255.0, blue:51.0/255.0, alpha:0.5)
            
            let typingTextFont = UIFont(name: "Lato-Medium", size:13.0)
            if (typingTextFont != nil) {
                attributes.typingTextFont = typingTextFont!
            }
            
            let scheduleIcon = UIImage(named:"schedule_alert")
            if (scheduleIcon != nil) {
                attributes.scheduleIcon = scheduleIcon!
            }
            
            let scheduleAlertFont = UIFont(name: "Lato-Semibold", size:17.0)
            if (scheduleAlertFont != nil) {
                attributes.scheduleAlertFont = scheduleAlertFont!
            }
            attributes.scheduleAlertColor = UIColor(red:51.0/255.0, green:51.0/255.0, blue:51.0/255.0, alpha:1.0)
            
            let scrollToBottomImage = UIImage(named:"scroll_down_button_brs")
            if (scrollToBottomImage != nil) {
                attributes.scrollToBottomImage = scrollToBottomImage!
            }
            
            let surveyTextFont = UIFont(name: "Lato-Regular", size:17.0)
            if (surveyTextFont != nil) {
                attributes.surveyTextFont = surveyTextFont!
            }
            attributes.surveyTextColor = UIColor(red:131.0/255.0, green:177.0/255.0, blue:67.0/255.0, alpha:1.0)
            
            let surveyCompletionFont = UIFont(name: "Lato-Regular", size:17.0)
            if (surveyCompletionFont != nil) {
                attributes.surveyCompletionFont = surveyCompletionFont!
            }
            attributes.surveyCompletionColor = UIColor(red:131.0/255.0, green:177.0/255.0, blue:67.0/255.0, alpha:1.0)
            
            let iconLikeFull = UIImage(named:"ic_like_filled")?.withRenderingMode(.alwaysTemplate)
            if (iconLikeFull != nil) {
                attributes.iconLikeFull = iconLikeFull!
            }
            
            let iconLikeEmpty = UIImage(named:"ic_like_stroked")?.withRenderingMode(.alwaysTemplate)
            if (iconLikeEmpty != nil) {
                attributes.iconLikeEmpty = iconLikeEmpty!
            }
            
            let iconDislikeFull = UIImage(named:"ic_dislike_filled")?.withRenderingMode(.alwaysTemplate)
            if (iconDislikeFull != nil) {
                attributes.iconDislikeFull = iconDislikeFull!
            }
            
            let iconDislikeEmpty = UIImage(named:"ic_dislike_stroked")?.withRenderingMode(.alwaysTemplate)
            if (iconDislikeEmpty != nil) {
                attributes.iconDislikeEmpty = iconDislikeEmpty!
            }
            
            let iconStarRatingFull = UIImage(named:"ic_heart_filled")?.withRenderingMode(.alwaysTemplate)
            if (iconStarRatingFull != nil) {
                attributes.iconStarRatingFull = iconStarRatingFull!
            }
            
            let iconStarRatingEmty = UIImage(named:"ic_heart_stroked")?.withRenderingMode(.alwaysTemplate)
            if (iconStarRatingEmty != nil) {
                attributes.iconStarRatingEmty = iconStarRatingEmty!
            }
            
            attributes.likeRatingColorEnabled = UIColor(red:131.0/255.0, green:177.0/255.0, blue:67.0/255.0, alpha:1.0)
            attributes.likeRatingColorDisabled = UIColor(red:131.0/255.0, green:177.0/255.0, blue:67.0/255.0, alpha:1.0)
            attributes.starRatingColorEnabled = UIColor.red
            attributes.starRatingColorDisabled = UIColor.red
            attributes.likeRatingColorCompleted = UIColor.yellow
            attributes.starRatingColorCompleted = UIColor.red
            
            attributes.showWaitingForSpecialistProgress = false;
            attributes.canShowSpecialistInfo = false;
            attributes.showWaitingForSpecialistProgress = false;
            attributes.canShowSpecialistInfo = true;
            attributes.navigationBarVisible = true;
            attributes.canShowDebugScreen = self.canShowDebugScreen;
            attributes.historyLoadingCount = 25;
        }
    }
    
}
