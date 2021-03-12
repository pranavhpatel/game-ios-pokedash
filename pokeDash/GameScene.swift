//
//  GameScene.swift
//  pokeDash
//
//  Created by Prism Student on 2020-04-17.
//  Copyright © 2020 Pranav Patel. All rights reserved.
//

import UIKit
import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate{
    
    var pokemon: SKSpriteNode!
    var obj: SKSpriteNode!
    var background: SKSpriteNode!
    var deadpokemon: SKSpriteNode!
    var playButton: SKSpriteNode!
    var saveButton: SKSpriteNode!
    var exitButton: SKSpriteNode!
    var disableTouchNode: SKSpriteNode!
    var nameLabel = SKLabelNode(fontNamed: "Marker Felt")
    var TextureAtlas = SKTextureAtlas()
    var TextureArray = [SKTexture]()
    var textField: UITextField!
    let theSharedCollection = PokemonCollection()
    var currentScore = 0
    var collision = false
    var added = false
    var textureAdded = false
    var musicPlayer = CustomMusicClass.sharedInstance()
    var instructionLabel = SKLabelNode(fontNamed: "Marker Felt")
    var levelTimerLabel = SKLabelNode(fontNamed: "Marker Felt")
    var levelEndLabel = SKLabelNode(fontNamed: "Marker Felt")

    //Immediately after leveTimerValue variable is set, update label's text
    var levelTimerValue: Int = 0 {
        didSet {
            levelTimerLabel.text = "Score: \(levelTimerValue)"
        }
    }
    
    override func didMove(to view: SKView){
        // load elements
        addBackground()
        addPokemon()
        addObstacles()
        addInstruction()
        addScore()
        physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        physicsWorld.contactDelegate = self
    }
    
    override func update(_ currentTime: CFTimeInterval){
        
    }
    
    func addInstruction(){
        instructionLabel.fontColor = SKColor.black
        instructionLabel.fontSize = 30
        instructionLabel.position = CGPoint(x: frame.size.width*0.5, y: frame.size.height*0.5)
        instructionLabel.text = "Tap to jump"
        instructionLabel.zPosition = CGFloat(2)
        self.addChild(instructionLabel)
    }
    
    func addScore(){
        levelTimerLabel.fontColor = SKColor.black
        levelTimerLabel.fontSize = 35
        levelTimerLabel.position = CGPoint(x: frame.size.width*0.5, y: frame.size.height*0.7)
        levelTimerLabel.text = "Score: \(levelTimerValue)"
        levelTimerLabel.zPosition = CGFloat(2)
        self.addChild(levelTimerLabel)

        let wait = SKAction.wait(forDuration: 0.5) //change countdown speed here
        let block = SKAction.run({
            [unowned self] in
            self.levelTimerValue = self.levelTimerValue + 1
        })
        let sequence = SKAction.sequence([wait,block])

        levelTimerLabel.run(SKAction.repeatForever(sequence))
    }
    func addTextField() {
        nameLabel.fontColor = SKColor.black
        nameLabel.fontSize = 30
        nameLabel.position = CGPoint(x: frame.size.width*0.3, y: frame.size.height*0.87)
        nameLabel.text = "Enter name:"
        nameLabel.zPosition = CGFloat(2)
        self.addChild(nameLabel)
        
        textField = UITextField(frame:CGRect(x: frame.size.width*0.6, y: frame.size.height*0.1, width: 100.0, height: 30.0))
        textField.textAlignment = NSTextAlignment.center
        textField.textColor = UIColor.blue
        textField.borderStyle = UITextField.BorderStyle.line
        textField.autocapitalizationType = UITextAutocapitalizationType.words // If you need any capitalization
        self.view!.addSubview(textField)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view!.endEditing(true)
    }
    
    func addPokemon(){
        //let currentPokemon = "abra"
        let currentPokemon = theSharedCollection.getName().lowercased()
        pokemon = SKSpriteNode(imageNamed: currentPokemon)
        pokemon.xScale = -1
        //pokemon.anchorPoint = CGPoint(x: 0.0, y: 0.0)
        pokemon.size = CGSize(width: self.frame.size.width/3, height: self.frame.size.height/4)
        pokemon.position = CGPoint(x: self.frame.size.width*0.1, y: self.frame.size.height*0.1)
        pokemon.physicsBody = SKPhysicsBody(circleOfRadius: pokemon.size.width*0.07) // define boundary of body
        pokemon.zPosition = 2
        pokemon.physicsBody?.isDynamic = true // 2
        pokemon.physicsBody?.categoryBitMask = PhysicsCategory.Pokemon //
        pokemon.physicsBody?.contactTestBitMask = PhysicsCategory.Obj // Contact with obj
        pokemon.physicsBody?.collisionBitMask = PhysicsCategory.None // No bouncing on collision
        self.addChild(pokemon)
    }
    
    func addObstacles(){
        let speedFactor = CGFloat(50.0)
        let enterDuration = CFTimeInterval(6)
        let enterRange = CFTimeInterval(4)
        let width = CGFloat(pokemon.size.width/2)
        let height = CGFloat(pokemon.size.width/2)
        let wait = SKAction.wait(forDuration: enterDuration, withRange: enterRange)
        let spawn = SKAction.run{
            let whichImg = Int.random(in: 0 ..< 2) // randomly pick background image
            let imgName: String!
            switch whichImg{
                case 0:
                    imgName = "obj1"
                default:
                    imgName = "obj"
            }
            self.obj = SKSpriteNode(imageNamed: imgName)
            self.obj.zPosition = 2
            //self.obj.anchorPoint = CGPoint(x: 0.0, y: 0.0)
            self.obj.size = CGSize(width: width, height: height)
            self.obj.position = CGPoint(x: self.frame.size.width, y: self.frame.size.height*0.1)
            self.obj.physicsBody = SKPhysicsBody(rectangleOf: self.obj.size)
            //pokemon.physicsBody = SKPhysicsBody(circleOfRadius: pokemon.size.width*0.05) // define boundary of body
            
            self.obj.physicsBody?.isDynamic = true
            self.obj.physicsBody?.categoryBitMask = PhysicsCategory.Obj
            self.obj.physicsBody?.contactTestBitMask = PhysicsCategory.Pokemon
            self.obj.physicsBody?.collisionBitMask = PhysicsCategory.None
            self.obj.physicsBody?.usesPreciseCollisionDetection = true
            self.addChild(self.obj)
        }
        let move = SKAction.run{
            self.moveNodesLeft(node: self.obj)
        }
        let sequence = SKAction.sequence([spawn,move,wait])
        sequence.speed = 1.0+(2*CGFloat(levelTimerValue)/speedFactor)
        self.run(SKAction.repeatForever(sequence))
    }
    //move nodes left
    func moveNodesLeft(node: SKSpriteNode){
        let speedFactor = CGFloat(50.0)
        let objDuration = CFTimeInterval(3)
        let moveLeft = SKAction.moveBy(x: -frame.size.width*1.1, y: 0, duration: objDuration)
        let delete = SKAction.run{
            node.removeFromParent()
        }
        let sequence = SKAction.sequence([moveLeft,delete])
        sequence.speed = 1.0+(2*CGFloat(levelTimerValue)/speedFactor)
        //print(1.0+CGFloat(levelTimerValue)/speedFactor)
        node.run(SKAction.repeatForever(sequence))
    }
    
    func addBackground(){
        if (textureAdded == false){
            TextureAtlas = SKTextureAtlas(named: "assets.atlas")
            //print(TextureAtlas.textureNames.count)
            for i in 1...TextureAtlas.textureNames.count{
                let Name = "pic\(i).png"
                TextureArray.append(SKTexture(imageNamed: Name))
            }
            textureAdded = true
        }
        
        let animate = SKAction.animate(with: TextureArray, timePerFrame: 0.1)
        let forever = SKAction.repeatForever(animate)
        
        background = SKSpriteNode(imageNamed: TextureAtlas.textureNames[0] )
        background.size = CGSize(width: self.frame.size.width*3, height: self.frame.size.height)
        background.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        background.zPosition = 1
        self.addChild(background)
        background.run(forever)
    }
    
    
    //collision detectObj
    func pokemonDidCollideWithObj(_ pokemon:SKSpriteNode, obj:SKSpriteNode) {
        deadpokemon = SKSpriteNode(imageNamed: "dead")
        deadpokemon.zPosition = 2
        deadpokemon.size = CGSize(width: pokemon.size.width*2, height: pokemon.size.height*1.5)
        deadpokemon.position = CGPoint(x: frame.size.width*0.5, y: frame.size.height*0.5)
        pokemon.removeFromParent()
        obj.removeFromParent()
        addChild(deadpokemon)
        musicPlayer.playSound("crash.mp3")
        collision = true
        //background.removeAllActions()
        self.removeAllActions()
        levelTimerLabel.removeAllActions()
        self.instructionLabel.removeFromParent()
        addEndMessage()
        addOptionsButton()
        addTextField()
        //let nextScene = LoseScene(size: view!.bounds.size)
        //let transition = SKTransition.doorway(withDuration: deadTime)
        //self.view?.presentScene(nextScene, transition: transition)
     }
     
     // we must implement this delegate method
    func didBegin(_ contact: SKPhysicsContact) {
         // bodyA and bodyB collide, we have to sort them by their bitmasks
         var firstBody: SKPhysicsBody
         var secondBody: SKPhysicsBody
         if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
             firstBody = contact.bodyA
             secondBody = contact.bodyB
         } else {
             firstBody = contact.bodyB
             secondBody = contact.bodyA
         }
         
         if ((firstBody.categoryBitMask & PhysicsCategory.Pokemon != 0) &&
             (secondBody.categoryBitMask & PhysicsCategory.Obj != 0)) {
                 pokemonDidCollideWithObj(firstBody.node as! SKSpriteNode, obj: secondBody.node as! SKSpriteNode)
         }
         
     } //didBeginContact
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        _ = SharingScoresCollection()
        SharingScoresCollection.sharedScoresCollection.scoresCollection = ScoresCollection()
        let theSharedCollection = SharingScoresCollection.sharedScoresCollection.scoresCollection
        let up = CFTimeInterval(0.5)
        let down = CFTimeInterval(0.7)
        let back = CFTimeInterval(0.3)
        let jumpFactor = CGFloat(1.75)
        // remove instructions
        if (self.levelTimerValue > 5){
            self.instructionLabel.removeFromParent()
        }
        if (self.obj != nil && self.pokemon != nil && self.pokemon.position.y < self.obj.size.height * jumpFactor){
            let jumpSound = SKAction.run{
                self.musicPlayer.playSound("jump.mp3")
            }
            let moved = CGFloat(10)
            let jumpUpAction = SKAction.moveBy(x: moved, y: obj.size.height * jumpFactor, duration:up)
            let jumpDownAction = SKAction.moveBy(x: moved, y:-(obj.size.height * jumpFactor), duration:down)
            let moveBackAction = SKAction.moveBy(x: -(moved*2), y: 0, duration:back)
            // sequence of move up then down
            let jumpSequence = SKAction.sequence([jumpSound, jumpUpAction, jumpDownAction, moveBackAction])

            // make player run sequence
            pokemon.run(jumpSequence)
        }
        if (collision == true){
            for touch: AnyObject in touches {
                let location = touch.location(in: self)
                // button to play clicked
                if playButton.contains(location){
                    if let view = self.view {
                        if textField != nil {
                            textField.isHidden = true
                        }
                        view.isMultipleTouchEnabled = false
                        let scene = GameScene(size: view.bounds.size)
                        // Set the scale mode to scale to fit the window
                        scene.scaleMode = .aspectFill
                        // Present the scene
                        view.presentScene(scene)
                    }
                    SharingScoresCollection.sharedScoresCollection.saveScoresCollection()  // archive data
                }
                if exitButton.contains(location){
                    //musicPlayer.stopMusic()
                    if (MusicInstance.musicStatus == true){
                        musicPlayer.playMusic("menuMusic.mp3")
                    }
                    SharingScoresCollection.sharedScoresCollection.saveScoresCollection()  // archive data
                    restartApplication()
                }
                if saveButton.contains(location){
                    if (added == false){
                        if (textField.text == ""){ textField.text = "Default"}
                        theSharedCollection!.add(name: textField.text ?? "Unknown Player", score: String(levelTimerValue))
                        saveButton.removeFromParent()
                        levelEndLabel.text = "Score Saved"
                        added = true
                        levelEndLabel.fontColor = SKColor.green
                        SharingScoresCollection.sharedScoresCollection.saveScoresCollection()  // archive data
                    }
                }
            }
        }
    }
    func restartApplication() {
        //self.view?.window!.rootViewController?.dismiss(animated: true, completion: nil)
        UIApplication.shared.keyWindow?.rootViewController?.dismiss(animated: false, completion: nil)
    }

    func addOptionsButton(){
        let widthConstant = CGFloat(50)
        let heightConstant = widthConstant
        // play button
        playButton = SKSpriteNode(imageNamed: "replay")
        playButton.size = CGSize(width: widthConstant, height: heightConstant)
        playButton.position = CGPoint(x: frame.size.width*0.3, y: frame.size.height*0.2)
        playButton.zPosition = 3
        self.addChild(playButton)
        
        //save button
        saveButton = SKSpriteNode(imageNamed: "save")
        saveButton.size = CGSize(width: widthConstant, height: heightConstant)
        saveButton.position = CGPoint(x: frame.size.width*0.5, y: frame.size.height*0.2)
        saveButton.zPosition = 3
        self.addChild(saveButton)
        
        //exit button
        exitButton = SKSpriteNode(imageNamed: "exit")
        exitButton.size = CGSize(width: widthConstant, height: heightConstant)
        exitButton.position = CGPoint(x: frame.size.width*0.7, y: frame.size.height*0.2)
        exitButton.zPosition = 3
        self.addChild(exitButton)
    }
    
    func addEndMessage(){
        levelEndLabel.fontColor = SKColor.red
        levelEndLabel.fontSize = 40
        levelEndLabel.position = CGPoint(x: frame.size.width*0.5, y: frame.size.height*0.8)
        levelEndLabel.text = "You got captured!"
        levelEndLabel.zPosition = CGFloat(2)
        self.addChild(levelEndLabel)
    }
}
