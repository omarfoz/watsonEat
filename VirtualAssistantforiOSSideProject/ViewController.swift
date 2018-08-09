/**
 * Copyright IBM Corporation 2018
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 **/

import UIKit
import NVActivityIndicatorView
import AssistantV1
import MessageKit
import MapKit
import BMSCore
import GooglePlaces
import GoogleMaps
import MapKit
import CoreLocation






class ViewController: MessagesViewController, NVActivityIndicatorViewable , CLLocationManagerDelegate {
    
    @IBOutlet weak var googlebt: UIButton!
    
    var locationManager = CLLocationManager()
    
    var near = [NearByObject]()
    
    // var resultFromWatson: [String: String] = [:]
    
    var lat : CLLocationDegrees = 24.7182251
    var long : CLLocationDegrees = 46.6843486
    
    var latnear : CLLocationDegrees = 0
    var longnear : CLLocationDegrees = 0
    
    fileprivate let kCollectionViewCellHeight: CGFloat = 12.5
    
    // Messages State
    var messageList: [AssistantMessages] = []
    
    var now = Date()
    
    // Conersation SDK
    var assistant: Assistant?
    var context: Context?
    
    // Watson Assistant Workspace
    var workspaceID: String?
    
    // Users
    var current = Sender(id: "123456", displayName: "Ginni")
    let watson = Sender(id: "654321", displayName: "Watson")
    
    
    
    // UIButton to initiate login
    
    
    @IBAction func googlemap(_ sender: Any) {
        
        
        
    }
    
    
    @IBOutlet weak var logo: UIImageView!
    
    
    @IBOutlet weak var logoutButton: UIButton!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        logo.image = UIImage.gif(name: "logo")
        
        
        
        
        // Instantiate Assistant Instance
        self.instantiateAssistant()
        
        // Instantiate activity indicator
        self.instantiateActivityIndicator()
        
        // Registers data sources and delegates + setup views
        self.setupMessagesKit()
        
        // Register observer
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(didBecomeActive),
                                               name: .UIApplicationDidBecomeActive,
                                               object: nil)
        
        
        self.locationManager.requestAlwaysAuthorization()
        
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        
        
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        print("locations = \(locValue.latitude) \(locValue.longitude)")
        lat = locValue.latitude
        long = locValue.longitude
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func didBecomeActive(_ notification: Notification) {
        
        
    }
    
    // google pleaces api
    func performGoogleSearch(searchfor: String ,lat: CLLocationDegrees, lon: CLLocationDegrees){
        
        var RadiusArea : Int = 1000
        var rate:Float = 0.0
        
        var components = URLComponents(string: "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=\(lat),\(lon)&radius=\(RadiusArea)&keyword=\(searchfor)&key=AIzaSyCreKqjOjlnqwJL1MuxvkgQTov_0cL_VdM")!
        
        let key = URLQueryItem(name: "key", value: "AIzaSyCreKqjOjlnqwJL1MuxvkgQTov_0cL_VdM") // use your key
        
        let task = URLSession.shared.dataTask(with: components.url!) { data, response, error in
            guard let data = data, let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200, error == nil else {
                print(String(describing: response))
                print(String(describing: error))
                return
            }
            
            guard let json = try! JSONSerialization.jsonObject(with: data) as? [String: Any] else {
                print("not JSON format expected")
                print(String(data: data, encoding: .utf8) ?? "Not string?!?")
                return
            }
            
            guard let results = json["results"] as? [[String: Any]],
                
                
                let status = json["status"] as? String,
                status == "OK" else {
                    print("no results")
                    print(String(describing: json))
                    return
            }
            
            
            
            
            
            DispatchQueue.main.async {
                
                
                
                
                
                
                
                self.near.removeAll()
                for re in results{
                    var nearby = NearByObject()
                    
                    
                    /*
                     if let rates = re["rating"] as? String {
                     
                     print("rate \(rates)")
                     
                     rate = Double(rates)!
                     
                     }
                     */
                    
                    if let ratess = re["rating"] as? Float64 {
                        
                        print("rate \(ratess)")
                        
                        rate =  Float(ratess)
                        
                        nearby.rate = rate
                    }
                    
                    
                    
                    
                    if let geom = re["geometry"] as? [String : AnyObject] {
                        if let locat = geom["location"] as? [String : AnyObject] {
                            if let lat = locat["lat"] as? CLLocationDegrees {
                                print("WOOOOOOOW lat= \(lat)")
                                nearby.Latitude = lat
                            }
                            if let lng = locat["lng"] as? CLLocationDegrees {
                                print("WOOOOOOOW lan= \(lng)")
                                nearby.longitude = lng
                            }
                        }
                    }
                    if let name = re["name"] as? String {
                        print("WOOOOOOOW name= \(name)")
                        nearby.name = name
                    }
                    
                    
                    
                    if let address = re["vicinity"] as? String{
                        print("WOOOOOOOW address= \(address)")
                        nearby.Address = address
                        
                    }
                    
                    if let icon = re["icon"] as? String{
                        print("WOOOOOOOW icon= \(icon)")
                        nearby.icon = icon
                        self.near.append(nearby)
                    }
                    
                }
            }
            
        }
        task.resume()
    }
    
    
    // MARK: - Setup Methods
    
    // Method to instantiate assistant service
    func instantiateAssistant() {
        
        // Start activity indicator
        startAnimating( message: "Connecting to Watson", type: NVActivityIndicatorType.ballScaleRipple)
        
        // Create a configuration path for the BMSCredentials.plist file then read in the Watson credentials
        // from the plist configuration dictionary
        guard let configurationPath = Bundle.main.path(forResource: "BMSCredentials", ofType: "plist"),
            let configuration = NSDictionary(contentsOfFile: configurationPath) else {
                
                showAlert(.missingCredentialsPlist)
                return
        }
        
        // API Version Date to initialize the Assistant API
        let date = "2018-02-01"
        
        // Set the Watson credentials for Assistant service from the BMSCredentials.plist
        // If using IAM authentication
        if let apikey = configuration["conversationApikey"] as? String,
            let url = configuration["conversationUrl"] as? String {
            
            // Initialize Watson Assistant object
            let assistant = Assistant(version: date, apiKey: apikey)
            
            // Set the URL for the Assistant Service
            assistant.serviceURL = url
            
            self.assistant = assistant
            
            // If using user/pwd authentication
        } else if let password = configuration["conversationPassword"] as? String,
            let username = configuration["conversationUsername"] as? String,
            let url = configuration["conversationUrl"] as? String {
            
            // Initialize Watson Assistant object
            let assistant = Assistant(username: username, password: password, version: date)
            
            // Set the URL for the Assistant Service
            assistant.serviceURL = url
            
            self.assistant = assistant
            
        } else {
            showAlert(.missingAssistantCredentials)
        }
        
        // Lets Handle the Workspace creation or selection from here.
        // If a workspace is found in the plist then use that WorkspaceID that is provided , otherwise
        // look up one from the service directly, Watson provides a sample so this should work directly
        if let workspaceID = configuration["workspaceID"] as? String {
            
            print("Workspace ID:", workspaceID)
            
            // Set the workspace ID Globally
            self.workspaceID = workspaceID
            
            // Ask Watson for its first message
            retrieveFirstMessage()
            
        } else {
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.5) {
                NVActivityIndicatorPresenter.sharedInstance.setMessage("Checking for Training...")
            }
            
            // Retrieve a list of Workspaces that have been trained and default to the first one
            // You can define your own WorkspaceID if you have a specific Assistant model you want to work with
            guard let assistant = assistant else {
                return
            }
            
            assistant.listWorkspaces(failure: failAssistantWithError,
                                     success: workspaceList)
            
        }
    }
    
    // Method to start convesation from workspace list
    func workspaceList(_ list: WorkspaceCollection) {
        
        // Lets see if the service has any training model deployed
        guard let workspace = list.workspaces.first else {
            showAlert(.noWorkspacesAvailable)
            return
        }
        
        // Check if we have a workspace ID
        guard !workspace.workspaceID.isEmpty else {
            showAlert(.noWorkspaceId)
            return
        }
        
        // Now we have an WorkspaceID we can ask Watson Assisant for its first message
        self.workspaceID = workspace.workspaceID
        
        // Ask Watson for its first message
        retrieveFirstMessage()
        
    }
    
    // Method to handle errors with Watson Assistant
    func failAssistantWithError(_ error: Error) {
        showAlert(.error(error.localizedDescription))
    }
    
    // Method to set up the activity progress indicator view
    func instantiateActivityIndicator() {
        let size: CGFloat = 50
        let x = self.view.frame.width/2 - size
        let y = self.view.frame.height/2 - size
        
        let frame = CGRect(x: x, y: y, width: size, height: size)
        
        _ = NVActivityIndicatorView(frame: frame, type: NVActivityIndicatorType.ballScaleRipple)
    }
    
    // Method to set up messages kit data sources and delegates + configure
    func setupMessagesKit() {
        
        // Register datasources and delegates
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDisplayDelegate = self
        messagesCollectionView.messageCellDelegate = self
        messageInputBar.delegate = self
        
        // Configure views
        messageInputBar.sendButton.tintColor = UIColor(red: 69/255, green: 193/255, blue: 89/255, alpha: 1)
        scrollsToBottomOnKeybordBeginsEditing = true // default false
        maintainPositionOnKeyboardFrameChanged = true // default false
    }
    
    // Retrieves the first message from Watson
    func retrieveFirstMessage() {
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.5) {
            NVActivityIndicatorPresenter.sharedInstance.setMessage("Talking to Watson...")
        }
        
        guard let assistant = self.assistant else {
            showAlert(.missingAssistantCredentials)
            return
        }
        
        guard let workspace = workspaceID else {
            showAlert(.noWorkspaceId)
            return
        }
        
        // Initial assistant message from Watson
        assistant.message(workspaceID: workspace, failure: failAssistantWithError) { response in
            
            for watsonMessage in response.output.text {
                
                // Set current context
                
                self.context = response.context
                
                DispatchQueue.main.async {
                    
                    // Add message to assistant message array
                    let uniqueID = UUID().uuidString
                    let date = self.dateAddingRandomTime()
                    
                    let attributedText = NSAttributedString(string: watsonMessage,
                                                            attributes: [.font: UIFont.systemFont(ofSize: 14),
                                                                         .foregroundColor: UIColor.blue])
                    
                    // Create a Message for adding to the Message View
                    let message = AssistantMessages(attributedText: attributedText, sender: self.watson, messageId: uniqueID, date: date)
                    if message.messageId == "H" {
                        
                        let attributedText = NSAttributedString(string: "holaaaaa",
                                                                attributes: [.font: UIFont.systemFont(ofSize: 14),
                                                                             .foregroundColor: UIColor.blue])
                        
                        
                        let message2 = AssistantMessages(attributedText: attributedText, sender: self.watson, messageId: uniqueID, date: date)
                        self.messageList.insert(message2, at: 0)
                        self.messagesCollectionView.reloadData()
                        self.messagesCollectionView.scrollToBottom()
                        self.stopAnimating()
                    } else{
                        
                        // Add the response to the Message View
                        self.messageList.insert(message, at: 0)
                        self.messagesCollectionView.reloadData()
                        self.messagesCollectionView.scrollToBottom()
                        self.stopAnimating()
                    }
                }
            }
        }
    }
    
    // Method to create a random date
    func dateAddingRandomTime() -> Date {
        let randomNumber = Int(arc4random_uniform(UInt32(10)))
        var date: Date?
        if randomNumber % 2 == 0 {
            date = Calendar.current.date(byAdding: .hour, value: randomNumber, to: now) ?? Date()
        } else {
            let randomMinute = Int(arc4random_uniform(UInt32(59)))
            date = Calendar.current.date(byAdding: .minute, value: randomMinute, to: now) ?? Date()
        }
        now = date ?? Date()
        return now
    }
    
    // Method to show an alert with an alertTitle String and alertMessage String
    func showAlert(_ error: AssistantError) {
        // Log the error to the console
        print(error)
        
        DispatchQueue.main.async {
            
            // Stop animating if necessary
            self.stopAnimating()
            
            // If an alert is not currently being displayed
            if self.presentedViewController == nil {
                // Set alert properties
                let alert = UIAlertController(title: error.alertTitle,
                                              message: error.alertMessage,
                                              preferredStyle: .alert)
                // Add an action to the alert
                alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil))
                // Show the alert
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    // Method to retrieve assistant avatar
    func getAvatarFor(sender: Sender) -> Avatar {
        switch sender {
        case current:
            return Avatar(image: UIImage(named: "avatar_small"), initials: "GR")
        case watson:
            return Avatar(image: UIImage(named: "watson_avatar"), initials: "WAT")
        default:
            return Avatar()
        }
    }
}

// MARK: - MessagesDataSource
extension ViewController: MessagesDataSource {
    
    func currentSender() -> Sender {
        return current
    }
    
    func numberOfMessages(in messagesCollectionView: MessagesCollectionView) -> Int {
        return messageList.count
    }
    
    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageType {
        return messageList[indexPath.section]
    }
    
    func cellTopLabelAttributedText(for message: MessageType, at indexPath: IndexPath) -> NSAttributedString? {
        let name = message.sender.displayName
        return NSAttributedString(string: name, attributes: [NSAttributedStringKey.font: UIFont.preferredFont(forTextStyle: .caption1)])
    }
    
    func cellBottomLabelAttributedText(for message: MessageType, at indexPath: IndexPath) -> NSAttributedString? {
        
        struct AssistantDateFormatter {
            static let formatter: DateFormatter = {
                let formatter = DateFormatter()
                formatter.dateStyle = .medium
                return formatter
            }()
        }
        let formatter = AssistantDateFormatter.formatter
        let dateString = formatter.string(from: message.sentDate)
        return NSAttributedString(string: dateString, attributes: [NSAttributedStringKey.font: UIFont.preferredFont(forTextStyle: .caption2)])
    }
    
}

// MARK: - MessagesDisplayDelegate
extension ViewController: MessagesDisplayDelegate {
    
    // MARK: - Text Messages
    
    func textColor(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> UIColor {
        return isFromCurrentSender(message: message) ? .white : .darkText
    }
    
    func detectorAttributes(for detector: DetectorType, and message: MessageType, at indexPath: IndexPath) -> [NSAttributedStringKey : Any] {
        return MessageLabel.defaultAttributes
    }
    
    func enabledDetectors(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> [DetectorType] {
        return [.url, .address, .phoneNumber, .date]
    }
    
    // MARK: - All Messages
    
    func backgroundColor(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> UIColor {
        return isFromCurrentSender(message: message) ? UIColor(red: 69/255, green: 193/255, blue: 89/255, alpha: 1) : UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
    }
    
    func messageStyle(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageStyle {
        let corner: MessageStyle.TailCorner = isFromCurrentSender(message: message) ? .bottomRight : .bottomLeft
        return .bubbleTail(corner, .curved)
    }
    
    func configureAvatarView(_ avatarView: AvatarView, for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) {
        
        let avatar = getAvatarFor(sender: message.sender)
        avatarView.set(avatar: avatar)
    }
    
    // MARK: - Location Messages
    func annotationViewForLocation(message: MessageType, at indexPath: IndexPath, in messageCollectionView: MessagesCollectionView) -> MKAnnotationView? {
        let annotationView = MKAnnotationView(annotation: nil, reuseIdentifier: nil)
        let pinImage = #imageLiteral(resourceName: "pin")
        annotationView.image = pinImage
        annotationView.centerOffset = CGPoint(x: 0, y: -pinImage.size.height / 2)
        return annotationView
    }
    
    func animationBlockForLocation(message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> ((UIImageView) -> Void)? {
        return { view in
            view.layer.transform = CATransform3DMakeScale(0, 0, 0)
            view.alpha = 0.0
            UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0, options: [], animations: {
                view.layer.transform = CATransform3DIdentity
                view.alpha = 1.0
            }, completion: nil)
        }
    }
}

// MARK: - MessagesLayoutDelegate
extension ViewController: MessagesLayoutDelegate {
    
    func avatarPosition(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> AvatarPosition {
        return AvatarPosition(horizontal: .natural, vertical: .messageBottom)
    }
    
    func messagePadding(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> UIEdgeInsets {
        if isFromCurrentSender(message: message) {
            return UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 4)
        } else {
            return UIEdgeInsets(top: 0, left: 4, bottom: 0, right: 30)
        }
    }
    
    func cellTopLabelAlignment(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> LabelAlignment {
        if isFromCurrentSender(message: message) {
            return .messageTrailing(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10))
        } else {
            return .messageLeading(UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0))
        }
    }
    
    func cellBottomLabelAlignment(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> LabelAlignment {
        if isFromCurrentSender(message: message) {
            return .messageLeading(UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0))
        } else {
            return .messageTrailing(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10))
        }
    }
    
    func footerViewSize(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> CGSize {
        
        return CGSize(width: messagesCollectionView.bounds.width, height: 10)
    }
    
    // MARK: - Location Messages
    
    func heightForLocation(message: MessageType, at indexPath: IndexPath, with maxWidth: CGFloat, in messagesCollectionView: MessagesCollectionView) -> CGFloat {
        return 200
    }
    
}

// MARK: - MessageCellDelegate

extension ViewController: MessageCellDelegate {
    
    func didTapAvatar(in cell: MessageCollectionViewCell) {
        print("Avatar tapped")
    }
    
    func didTapMessage(in cell: MessageCollectionViewCell) {
        print("Message tapped")
        
        if latnear != 0 && longnear != 0 {
            if (UIApplication.shared.canOpenURL(NSURL(string:"comgooglemaps://")! as URL)) {
                UIApplication.shared.openURL(NSURL(string:
                    "comgooglemaps://?saddr=&daddr=\(latnear),\(longnear)&directionsmode=driving")! as URL)
                latnear = 0
                longnear = 0
                
            }else{
                NSLog("Can't use comgooglemaps://");
            }
        }
        
    }
    
    func didTapTopLabel(in cell: MessageCollectionViewCell) {
        print("Top label tapped")
        
        
    }
    
    func didTapBottomLabel(in cell: MessageCollectionViewCell) {
        print("Bottom label tapped")
    }
    
}

// MARK: - MessageLabelDelegate

extension ViewController: MessageLabelDelegate {
    
    func didSelectAddress(_ addressComponents: [String : String]) {
        print("Address Selected: \(addressComponents)")
    }
    
    func didSelectDate(_ date: Date) {
        print("Date Selected: \(date)")
    }
    
    func didSelectPhoneNumber(_ phoneNumber: String) {
        print("Phone Number Selected: \(phoneNumber)")
    }
    
    func didSelectURL(_ url: URL) {
        print("URL Selected: \(url)")
    }
    
}

// MARK: - MessageInputBarDelegate

extension ViewController: MessageInputBarDelegate {
    
    
    
    
    func setmessage(i:String,inputBar: MessageInputBar) {
        
        let attributedText = NSAttributedString(string: i, attributes: [.font: UIFont.systemFont(ofSize: 14), .foregroundColor: UIColor.blue])
        let id = UUID().uuidString
        let message = AssistantMessages(attributedText: attributedText, sender: self.watson, messageId: id, date: Date())
        self.messageList.append(message)
        inputBar.inputTextView.text = String()
        self.messagesCollectionView.insertSections([self.messageList.count - 1])
        self.messagesCollectionView.scrollToBottom()
        
        
    }
    
    
    
    func messageInputBar(_ inputBar: MessageInputBar, didPressSendButtonWith text: String) {
        
        guard let assist = assistant else {
            showAlert(.missingAssistantCredentials)
            return
        }
        
        guard let workspace = workspaceID else {
            showAlert(.noWorkspaceId)
            return
        }
        
        
        let attributedText = NSAttributedString(string: text, attributes: [.font: UIFont.systemFont(ofSize: 14), .foregroundColor: UIColor.blue])
        
        
        let id = UUID().uuidString
        
        
        let message = AssistantMessages(attributedText: attributedText, sender: currentSender(), messageId: id, date: Date())
        messageList.append(message)
        inputBar.inputTextView.text = String()
        messagesCollectionView.insertSections([messageList.count - 1])
        messagesCollectionView.scrollToBottom()
        
        // cleanup text that gets sent to Watson, which doesn't care about whitespace or newline characters
        let cleanText = text
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .replacingOccurrences(of: "\n", with: ". ")
        
        // Lets pass the indent to Watson Assistant and see what the response is ?
        // Get response from Watson based on user text create a message Request first
        let messageRequest = MessageRequest(input: InputData(text:cleanText), context: self.context)
        
        // Call the Assistant API
        assist.message(workspaceID: workspace, request: messageRequest, failure: failAssistantWithError) { response in
            
            for watsonMessage in response.output.text {
                guard !watsonMessage.isEmpty else {
                    continue
                }
                // Set current context
                self.context = response.context
                DispatchQueue.main.async {
                    
                    
                    
                    //     self.performGoogleSearch(searchfor: "Restaurant",lat: self.lat, lon: self.long)
                    //  self.performGoogleSearch(searchfor: "Restaurant",lat: self.lat, lon: self.long)
                    
                    
                    // self.near = [NearByObject]()
                    //res = [String]()
                    
                    var  arrString:[String] = ["Restaurant","Burger","pizza","rice","coffee","Shawarma"]
                    
                    var arrStringRates:[String] = ["rate and restaurant","rate and burger","rate and pizza","rate and rice","rate and coffee","rate and Shawarma"]
                    var arrStringAll:[String] = ["all restaurant","all burger","all pizza","all rice","all coffee","all Shawarma"]
                    
                    /////
                    
                    
                    
                    /*
                     let id = UUID().uuidString
                     var pic = AssistantMessages(image: self.logo.image!, sender: self.watson, messageId: id, date: Date())
                     self.messageList.append(pic)
                     inputBar.inputTextView.text = String()
                     self.messagesCollectionView.insertSections([self.messageList.count - 1])
                     self.messagesCollectionView.scrollToBottom()
                     */
                    
                    
                    
                    if arrStringAll.contains(watsonMessage) {
                        
                        var nb = -1
                        for i in 0..<arrStringRates.count {
                            if arrStringAll[i] == watsonMessage {
                                nb = i
                            }
                            
                        }
                        
                        self.near  = [NearByObject]()
                        
                        if nb != -1 {
                            self.performGoogleSearch(searchfor: arrString[nb],lat: self.lat, lon: self.long)
                            
                        }
                        
                        
                        
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(2000)) {
                            
                            if !self.near.isEmpty {
                                
                                self.latnear =  0
                                self.longnear = 0
                                
                                //self.googlebt.setTitle(self.near[n].name, for: .normal)
                                // self.googlebt.isHidden = false
                                var n = 1
                                //self.setmessage(i: "The List is:", inputBar: inputBar)
                                var list = "The List is :"
                                for i in self.near {
                                    
                                    var name = String(i.name)
                                    print("after \(i.rate)  ")
                                    if i.rate != nil {
                                        var rate = String(i.rate)
                                        var s = "\(n)-: \(name), Rate is \(rate)."
                                        list.append("\n \(s) \n ")
                                        
                                        
                                        
                                        //self.setmessage(i: s, inputBar: inputBar)
                                        n = n + 1
                                    } else {
                                        
                                        var s = "\(n)-: \(name)."
                                        // self.setmessage(i: s, inputBar: inputBar)
                                        list.append("\n \(s)")
                                        
                                        n = n + 1
                                    }
                                    
                                }
                                self.setmessage(i: list, inputBar: inputBar)
                            } else {
                                self.setmessage(i: "no result", inputBar: inputBar)
                                
                            }
                            
                        }} else if arrStringRates.contains(watsonMessage) {
                        var nb = -1
                        for i in 0..<arrStringRates.count {
                            if arrStringRates[i] == watsonMessage {
                                nb = i
                            }
                            
                        }
                        
                        self.near  = [NearByObject]()
                        
                        if nb != -1 {
                            self.performGoogleSearch(searchfor: arrString[nb],lat: self.lat, lon: self.long)
                            
                        }
                        
                        
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(2000)) {
                            
                            if !self.near.isEmpty {
                                
                                var max = self.near[0].rate!
                                var maxnb = self.near[0]
                                for i in self.near {
                                    
                                    if i.rate > max {
                                        max = i.rate
                                        maxnb = i
                                    }
                                    
                                }
                                
                                self.latnear = maxnb.Latitude
                                self.longnear = maxnb.longitude
                                
                                //self.googlebt.setTitle(self.near[n].name, for: .normal)
                                // self.googlebt.isHidden = false
                                
                                var name = String(maxnb.name)
                                print("after \(maxnb.rate)  ")
                                if maxnb.rate != nil {
                                    var rate = String(maxnb.rate)
                                    var s = "the higest riting: \(name), Rate is \(rate)."
                                    self.setmessage(i: s, inputBar: inputBar)
                                    
                                } else {
                                    
                                    var s = "the higest riting: \(name)."
                                    self.setmessage(i: s, inputBar: inputBar)
                                }
                                
                            } else {
                                self.setmessage(i: "no result", inputBar: inputBar)
                                
                            }
                            
                        }}else if arrString.contains(watsonMessage) {
                        
                        self.near  = [NearByObject]()
                        self.performGoogleSearch(searchfor: watsonMessage,lat: self.lat, lon: self.long)
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(2000)) {
                            
                            if !self.near.isEmpty {
                                
                                let n = Int(arc4random_uniform(UInt32(self.near.count)))
                                
                                self.latnear = self.near[n].Latitude
                                self.longnear = self.near[n].longitude
                                
                                //self.googlebt.setTitle(self.near[n].name, for: .normal)
                                // self.googlebt.isHidden = false
                                
                                var name = String(self.near[n].name)
                                print("after \(self.near[n].rate)  ")
                                if self.near[n].rate != nil {
                                    var rate = String(self.near[n].rate)
                                    var s = "I suggest to you: \(name), Rate is \(rate)."
                                    self.setmessage(i: s, inputBar: inputBar)
                                    
                                } else {
                                    
                                    var s = "I suggest to you: \(name)."
                                    self.setmessage(i: s, inputBar: inputBar)
                                }
                                
                            } else {
                                self.setmessage(i: "no result", inputBar: inputBar)
                                
                            }
                            
                            
                        }}else {
                        
                        let attributedText = NSAttributedString(string: watsonMessage, attributes: [.font: UIFont.systemFont(ofSize: 14), .foregroundColor: UIColor.blue])
                        let id = UUID().uuidString
                        let message = AssistantMessages(attributedText: attributedText, sender: self.watson, messageId: id, date: Date())
                        self.messageList.append(message)
                        inputBar.inputTextView.text = String()
                        self.messagesCollectionView.insertSections([self.messageList.count - 1])
                        self.messagesCollectionView.scrollToBottom()
                        
                        
                    }
                    
                    
                    
                    
                    
                }
                
            }
            
        }
        
    }
    
}


