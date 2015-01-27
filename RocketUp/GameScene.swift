//
//  GameScene.swift
//  RocketUp
//
//  Created by Ajay Venkat on 26/01/2015.
//  Copyright (c) 2015 AJTech. All rights reserved.
//

import SpriteKit
import UIKit
import AVFoundation

enum BodyType:UInt32 {
    
    case me = 1
    case baddie = 2

    
}


class GameScene: SKScene,SKPhysicsContactDelegate{
    
    
    
    var backgroundMusicPlayer: AVAudioPlayer!
    let emitter = SKEmitterNode(fileNamed: "explosion.sks")
    var spawnEnemies :NSTimer = NSTimer()
    var bool = Bool()
    var bool2 = Bool()
    let endLabel = SKLabelNode(text: "Game Over")
    let endLabel2 = SKLabelNode(text: "Tap to begin!")
    let mutableArray : NSMutableArray = NSMutableArray()
    let sprite = SKSpriteNode(imageNamed:"spacemonkey_fly02")
    let ground = SKSpriteNode()
    let label = SKLabelNode(text: "Touch to begin!")
    let points = SKLabelNode(text: "0")
    var numPoints : Int = 0
    let pointWall = SKSpriteNode()
    
    let balloonHitCategory = 1
    let spikeHitCategory = 2
    
    
    
    override func didMoveToView(view: SKView) {

playMusic("BackgroundMusic")
        
        
        let scene = GameScene(size:self.frame.size)
        setBackground()
        createSprite()
        
        bool = false;
        
        
        makeGround()
        
        bool2 = false
        physicsWorld.contactDelegate = self
        
        
        label.position = CGPoint(x: self.frame.size.width/2, y: self.frame.size.height/2)
        label.fontColor = UIColor.whiteColor()
        label.fontSize = 100
        addChild(label)
        
        points.position = CGPoint(x: self.frame.size.width/2, y: self.frame.size.height/2 - 200)
        points.fontColor = UIColor.whiteColor()
        points.fontSize = 200
        addChild(points)
       


    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        if (bool2 == false) {
            let xNSNumber = numPoints as NSNumber
            let xString : String = xNSNumber.stringValue
            points.text = xString
        if sprite.physicsBody?.pinned == true {
            
                      sprite.physicsBody?.dynamic = true
            sprite.physicsBody?.pinned = false
            label.hidden = true;
            
          
            createEnemies()
            
            let ranTime = random(min: 0.6, max: 1.2)
            
            
    spawnEnemies = NSTimer .scheduledTimerWithTimeInterval(NSTimeInterval(ranTime), target: self, selector: Selector("createEnemies"), userInfo: nil, repeats: true)
            
        }
        
            
            
        else {
            let xNSNumber = numPoints as NSNumber
            let xString : String = xNSNumber.stringValue
            points.text = xString
        let vec =  CGVector(dx: 0, dy: 1000)
        sprite.physicsBody?.applyImpulse(vec)
        println("getting called")
        }
         
        }
        
        else if (bool2 == true) {
            
  
            scene?.removeAllActions()
            scene?.removeAllChildren()
            numPoints = 0;
            
            
            didMoveToView(view!)

            

        
        
    }
        
    }
    
   
    override func update(currentTime: CFTimeInterval) {
        
        
        if (CGRectIntersectsRect(sprite.frame, ground.frame)) {

            EndGame2()

        }
        
        if (bool == false) {
        /* Called before each frame is rendered */
        for en in mutableArray {
            
            if CGRectIntersectsRect(en.frame, pointWall.frame)
            {
                
                println("Getta Point")
                
                             en.removeFromParent()
                

                
mutableArray.removeObject(en)
                
                
                numPoints = numPoints + 1
                
                let xNSNumber = numPoints as NSNumber
                let xString : String = xNSNumber.stringValue
                points.text = xString
            
            
            }
            else {
                numPoints = numPoints + 0

            }
     
            }

      
            
    
        }
        
        
        else if (bool == true) {
            
            
        }
        
        
      
        
        
    
    }
    
    override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
       
        
        
        

    }
    
    
    
    func setBackground() {
self.physicsBody = SKPhysicsBody(edgeLoopFromRect: self.frame)
        let background = SKSpriteNode(imageNamed:"Starsiphone6+")
   
        background.position = CGPoint(x: self.frame.size.width/2, y: self.frame.size.height/2)
        background.size = CGSize(width: self.frame.size.width, height: self.frame.size.height)
        
        
        addChild(background)
        
   
    }
    
    func createSprite() {

        
        let point = CGPoint(x:300, y: self.frame.size.height - (sprite.size.height * 2))
        sprite.position = point
        sprite.physicsBody = SKPhysicsBody(circleOfRadius:sprite.frame.size.width/2)
        sprite.physicsBody?.pinned = true;
        sprite.physicsBody?.categoryBitMask = BodyType.me.rawValue
        sprite.physicsBody?.contactTestBitMask = BodyType.baddie.rawValue;
        sprite.physicsBody?.collisionBitMask =  BodyType.baddie.rawValue;
        sprite.physicsBody?.allowsRotation = false
                sprite.physicsBody?.usesPreciseCollisionDetection = true;
              addChild(sprite)

       
        
        
        pointWall.position = CGPoint(x: 10, y: 0)
        pointWall.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        pointWall.size = CGSize(width: 40, height: 10000)
        addChild(pointWall)

        
        
        
    }
    
    func makeGround() {

        ground.position = CGPoint(x: self.frame.size.width/2, y: 100)
        ground.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        ground.size = CGSize(width: self.frame.size.width, height: 30)
                addChild(ground)

        
    
    
    }
    
    
    func random() -> CGFloat {
        return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
    }
    
    func random(#min: CGFloat, max: CGFloat) -> CGFloat {
        return random() * (max - min) + min
    }

    func createEnemies() {
        
        
        
        let ran = random(min: 0.8, max: 2)
        let ran2 = random(min: 60, max: self.frame.size.height - sprite.size.height - 10)
        let enemy = SKSpriteNode(imageNamed: "boss_ship")
        enemy.position = CGPoint(x: self.frame.size.width, y: ran2)
        enemy.size = CGSize(width: sprite.size.width - 5, height: sprite.size.height - 5)
        let point = CGPoint(x: 0 - enemy.frame.size.width, y: enemy.position.y)
        enemy.physicsBody = SKPhysicsBody(circleOfRadius: 10)
        enemy.physicsBody?.dynamic = false;
        enemy.physicsBody?.usesPreciseCollisionDetection = true;
        
        enemy.physicsBody?.affectedByGravity = false;
        enemy.physicsBody?.allowsRotation = false;
        enemy.physicsBody?.categoryBitMask = BodyType.baddie.rawValue;
        enemy.physicsBody?.contactTestBitMask = BodyType.me.rawValue;
        enemy.physicsBody?.collisionBitMask =  BodyType.me.rawValue;
        let act = SKAction.moveTo(point, duration:NSTimeInterval(ran))
        
        addChild(enemy)
        enemy.runAction(act)
        
        mutableArray.addObject(enemy)
    }
    
    func didBeginContact(contact: SKPhysicsContact) {
        
        //this gets called automatically when two objects begin contact with each other
        
        let contactMask = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        
        switch(contactMask) {
            
        case BodyType.me.rawValue | BodyType.baddie.rawValue:
            //either the contactMask was the bro type or the ground type
            println("contact made")
            
            let secondNode = contact.bodyB.node
            secondNode?.removeFromParent()
            let firstNode = contact.bodyA.node
            firstNode?.removeFromParent()
            bool = true;
            spawnEnemies.invalidate()
            backgroundMusicPlayer.stop()
            let explosion = SKAction.playSoundFileNamed("explosion.mp3", waitForCompletion: true)
            scene?.runAction(explosion)
            EndGame()
            
        default:
            return
            
        }
        
    }
    
    func didEndContact(contact: SKPhysicsContact) {
        
        //this gets called automatically when two objects end contact with each other
        
        let contactMask = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        
        switch(contactMask) {
            
        case BodyType.me.rawValue | BodyType.baddie.rawValue:
            //either the contactMask was the bro type or the ground type
            println("contact ended")
            

 

            
            

            
            
        default:
            return
            
        }
        
        
    
    }

    func EndGame() {
        endLabel.position = CGPoint(x: self.frame.size.width/2, y: self.frame.size.height/2)
        endLabel.fontColor = UIColor.blackColor()
        endLabel.fontSize = 100
        endLabel2.position = CGPoint(x: self.frame.size.width/2, y: self.frame.size.height/2 + endLabel.fontSize)
        endLabel2.fontColor = UIColor.blackColor()
        endLabel2.fontSize = 50
 emitter.position = CGPoint(x: self.frame.size.width/2, y: self.frame.size.height/2)
        points.fontColor = UIColor.blackColor()
        

        
        
    

        addChild(emitter)
        addChild(endLabel)
        addChild(endLabel2)
        bool2 = true
        
    }
    
    func EndGame2() {
        
        backgroundMusicPlayer.stop()
        bool = true;
        spawnEnemies.invalidate()
        
        let explosion = SKAction.playSoundFileNamed("explosion.mp3", waitForCompletion: true)
        scene?.runAction(explosion)
        
        scene?.removeAllActions()
        scene?.removeAllChildren()
        numPoints = 0;
        
        
        didMoveToView(view!)
        
        endLabel.position = CGPoint(x: self.frame.size.width/2, y: self.frame.size.height/2)
        endLabel.fontColor = UIColor.blackColor()
        endLabel.fontSize = 100
        endLabel2.position = CGPoint(x: self.frame.size.width/2, y: self.frame.size.height/2 + endLabel.fontSize)
        endLabel2.fontColor = UIColor.blackColor()
        endLabel2.fontSize = 50
        emitter.position = CGPoint(x: self.frame.size.width/2, y: self.frame.size.height/2)
        points.fontColor = UIColor.blackColor()
        
        
        
        
        
        
        addChild(emitter)
        addChild(endLabel)
        addChild(endLabel2)
        bool2 = true


        
    }
    
    
    
    func playMusic(fileName: String) -> Void {
        let fileURL: NSURL! = NSBundle.mainBundle().URLForResource(fileName, withExtension: "mp3")
        backgroundMusicPlayer = AVAudioPlayer(contentsOfURL: fileURL, error: nil)
        backgroundMusicPlayer.numberOfLoops = -1
       backgroundMusicPlayer.play()
    }
    
    
    
    
}



