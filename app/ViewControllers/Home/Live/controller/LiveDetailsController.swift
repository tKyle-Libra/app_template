//
//  LiveDetailsController.swift
//  app
//
//  Created by harry on 2019/10/17.
//  Copyright © 2019 harry. All rights reserved.
//

import UIKit
import AuroraIMUI
import TXLiteAVSDK_Professional
import IJKMediaFramework

class LiveDetailsController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLive()
        setupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        txLivePlayer.stop()
        txLivePlayer = nil
    }
    
    @IBOutlet weak var liveView: UIView!
    
    @IBOutlet weak var messageList: IMUIMessageCollectionView!
    
    @IBOutlet weak var chatInputView: IMUIInputView!
    
    var txLivePlayer:IJKFFMoviePlayerController!
    
}

//  initialize
fileprivate extension LiveDetailsController{
    func setupUI(){
        let liveViewHeight = 200*global_scale()
        let chatInputViewHeight = CGFloat(50)
        
        txLivePlayer.view.frame = CGRect(x: 0,
                                         y: navigation_bar_height(),
                                         width: screen_width(),
                                         height: liveViewHeight)
        
        self.view.addSubview(txLivePlayer.view)
        
        let messageListHeight = screen_height()-navigation_bar_height()-liveViewHeight-chatInputViewHeight
        messageList.frame = CGRect(x: 0,
                                   y: txLivePlayer.view.frame.maxY,
                                   width: screen_width(),
                                   height: messageListHeight)
        self.view.addSubview(messageList)
        
        chatInputView.frame = CGRect(x: 0,
                                     y: messageList.frame.maxY,
                                     width: screen_width(),
                                     height: chatInputViewHeight)
        chatInputView.delegate = self
        configInputView()
        self.view.addSubview(chatInputView)
        
//        liveView.layer.borderColor = UIColor.red.cgColor
//        liveView.layer.borderWidth = 1
//        messageList.layer.borderColor = UIColor.blue.cgColor
//        messageList.layer.borderWidth = 1
//        chatInputView.layer.borderColor = UIColor.orange.cgColor
//        chatInputView.layer.borderWidth = 1
        
        configTestMessageData()
    }
    
    func setupLive(){
        let options = IJKFFOptions.byDefault();
        options?.setPlayerOptionIntValue(1, forKey: "videotoolbox")
        options?.setPlayerOptionIntValue(Int64(29.97), forKey: "r")
        options?.setPlayerOptionIntValue(512, forKey: "vol")
        
        IJKFFMoviePlayerController.setLogReport(false)
        txLivePlayer = IJKFFMoviePlayerController(contentURL: URL(string: "http://live.schoolm3.com/live/test1.flv"), with: options)
        txLivePlayer.scalingMode = .aspectFill
        txLivePlayer.shouldAutoplay = true
        txLivePlayer.shouldShowHudView = false
        
        txLivePlayer.prepareToPlay()
    }
    
    func setupIM(){
        
    }
    
    
    func configInputView(){
        let config = ["right":["send"]]
        chatInputView.setupDataWithDic(dic: config)
    }
    
    func configTestMessageData(){
        let outGoingmessage = LiveMessage(text: "12313", isOutGoing: true)
        let inCommingMessage = LiveMessage(text: "1231231231", isOutGoing: false)
        self.messageList.appendMessage(with: outGoingmessage)
        self.messageList.appendMessage(with: inCommingMessage)
    }
}

extension LiveDetailsController:IMUIInputViewDelegate{
    func sendTextMessage(_ messageText: String) {
        
    }
}


