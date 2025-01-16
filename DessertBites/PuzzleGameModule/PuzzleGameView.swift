import SwiftUI
import SpriteKit

class PuzzleGameData: ObservableObject {
    @Published var isLose = false
    @Published var isWin = false
    @Published var isPause = false
    @Published var isGetTapped = false
    @Published var currentLevel = 0
    @Published var timeLeft = 179
    @Published var correctPositionsX: [CGFloat] = []
    @Published var correctPositionsY: [CGFloat] = []
}

class PuzzleGameSpriteKit: SKScene, SKPhysicsContactDelegate {
    var game: PuzzleGameData?
    let data: PuzzleModel
    var time: SKLabelNode!
    var selectedPuzzlePart: SKSpriteNode?
    var timer: Timer?
    
    init(data: PuzzleModel) {
        self.data = data
        super.init(size: UIScreen.main.bounds.size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        let gameBackground = SKSpriteNode(texture: SKTexture(imageNamed: BitesImageName.background.rawValue))
        gameBackground.size = CGSize(width: size.width, height: size.height)
        gameBackground.position = CGPoint(x: size.width / 2, y: size.height / 2)
        addChild(gameBackground)
        
        time = SKLabelNode(fontNamed: "BowlbyOneSC-Regular")
        time.attributedText = NSAttributedString(string:"\(String(describing: (game?.timeLeft ?? 0) / 60)):\(String(describing: (game?.timeLeft ?? 0) % 60))", attributes: [
            NSAttributedString.Key.font: UIFont(name: "BowlbyOneSC-Regular", size: 34)!,
            NSAttributedString.Key.foregroundColor: Color(red: 255/255, green: 113/255, blue: 172/255).cgColor ?? UIColor.systemPink,
            NSAttributedString.Key.strokeColor: Color(red: 145/15, green: 15/255, blue: 37/255).cgColor ?? UIColor.red,
            NSAttributedString.Key.strokeWidth: -6
        ])
        time.position = CGPoint(x: size.width / 2, y: size.height / 1.16)
        addChild(time)
        
        let pauseBackground = SKSpriteNode(texture: SKTexture(imageNamed: BitesImageName.squareButtonBackground.rawValue))
        pauseBackground.size = CGSize(width: size.width * 0.15, height: size.width * 0.15)
        pauseBackground.position = CGPoint(x: size.width / 7, y: size.height / 1.14)
        pauseBackground.name = "pauseBackground"
        addChild(pauseBackground)
        
        let pause = SKSpriteNode(texture: SKTexture(imageNamed: BitesImageName.pause.rawValue))
        pause.size = CGSize(width: size.width * 0.06, height: size.width * 0.07)
        pause.name = "pause"
        pause.position = CGPoint(x: size.width / 7, y: size.height / 1.14)
        addChild(pause)
        
        let pauseLabel = SKLabelNode(fontNamed: "BowlbyOneSC-Regular")
        pauseLabel.attributedText = NSAttributedString(string:"PAUSE", attributes: [
            NSAttributedString.Key.font: UIFont(name: "BowlbyOneSC-Regular", size: 15)!,
            NSAttributedString.Key.foregroundColor: Color(red: 255/255, green: 113/255, blue: 172/255).cgColor ?? UIColor.systemPink,
            NSAttributedString.Key.strokeColor: Color(red: 145/15, green: 15/255, blue: 37/255).cgColor ?? UIColor.red,
            NSAttributedString.Key.strokeWidth: -6
        ])
        pauseLabel.position = CGPoint(x: size.width / 7, y: size.height / 1.23)
        addChild(pauseLabel)
        
        let restartBackground = SKSpriteNode(texture: SKTexture(imageNamed: BitesImageName.squareButtonBackground.rawValue))
        restartBackground.size = CGSize(width: size.width * 0.15, height: size.width * 0.15)
        restartBackground.position = CGPoint(x: size.width / 1.18, y: size.height / 1.14)
        restartBackground.name = "restartBackground"
        addChild(restartBackground)
        
        let restart = SKSpriteNode(texture: SKTexture(imageNamed: BitesImageName.restart.rawValue))
        restart.name = "restart"
        restart.size = CGSize(width: size.width * 0.08, height: size.width * 0.08)
        restart.position = CGPoint(x: size.width / 1.18, y: size.height / 1.14)
        addChild(restart)
        
        let restartLabel = SKLabelNode(fontNamed: "BowlbyOneSC-Regular")
        restartLabel.attributedText = NSAttributedString(string: "RESTART", attributes: [
            NSAttributedString.Key.font: UIFont(name: "BowlbyOneSC-Regular", size: 15)!,
            NSAttributedString.Key.foregroundColor: Color(red: 255/255, green: 113/255, blue: 172/255).cgColor ?? UIColor.systemPink,
            NSAttributedString.Key.strokeColor: Color(red: 145/15, green: 15/255, blue: 37/255).cgColor ?? UIColor.red,
            NSAttributedString.Key.strokeWidth: -6
        ])
        restartLabel.position = CGPoint(x: size.width / 1.18, y: size.height / 1.23)
        addChild(restartLabel)
        
        let puzzleBackground = SKSpriteNode(texture: SKTexture(imageNamed: BitesImageName.puzzleBackground.rawValue))
        puzzleBackground.size = CGSize(width: size.width * 0.9, height: size.height * 0.5)
        puzzleBackground.position = CGPoint(x: size.width / 2, y: size.height / 2)
        addChild(puzzleBackground)
        createPuzzlePart()
        setupRightPosition()
    }
    
    func createExplosion() {
         let explosion = SKSpriteNode(imageNamed: BitesImageName.win.rawValue)
         explosion.position = CGPoint(x: frame.midX, y: frame.midY)
         explosion.zPosition = 7
         explosion.alpha = 0
         explosion.xScale = 0.1
         explosion.yScale = 0.1
         addChild(explosion)
         animateExplosion(explosion: explosion)
     }
    
     func animateExplosion(explosion: SKSpriteNode) {
         let fadeIn = SKAction.fadeIn(withDuration: 0)
         let scaleUp = SKAction.scale(to: 1.5, duration: 2)
         let sequence = SKAction.sequence([fadeIn, scaleUp])
         explosion.run(sequence) {
             explosion.removeFromParent()
         }
     }
    
    func resetScene() {
        removeAllChildren()
        game!.timeLeft = 179
        setupView()
    }
    
    func winAnimation() {
        let winImage = SKSpriteNode(texture: SKTexture(imageNamed: data.image))
        winImage.size = CGSize(width: size.width * 0.91, height: size.height * 0.51)
        winImage.position = CGPoint(x: size.width / 2, y: size.height / 2)
        winImage.zPosition = 10
        let cornerRadius: CGFloat = 45
        let rect = CGRect(x: -winImage.size.width / 2, y: -winImage.size.height / 2, width: winImage.size.width, height: winImage.size.height)
        let path = UIBezierPath(roundedRect: rect, cornerRadius: cornerRadius)
        let border = SKShapeNode(path: path.cgPath)
        border.position = CGPoint(x: size.width / 2, y: size.height / 2)
        border.strokeColor = UIColor(red: 255/255, green: 113/255, blue: 172/255, alpha: 1)
        border.lineWidth = 10
        border.zPosition = 10
        border.fillColor = SKColor.clear
        addChild(border)
        addChild(winImage)
        
        let getBackground = SKSpriteNode(texture: SKTexture(imageNamed: BitesImageName.wideBackgroundButton.rawValue))
        getBackground.name = "getBackground"
        getBackground.size = CGSize(width: size.width * 0.5, height: size.height * 0.1)
        getBackground.position = CGPoint(x: size.width / 2, y: size.height / 7)
        addChild(getBackground)
        
        let getLabel = SKLabelNode(fontNamed: "BowlbyOneSC-Regular")
        getLabel.attributedText = NSAttributedString(string: "GET", attributes: [
            NSAttributedString.Key.font: UIFont(name: "BowlbyOneSC-Regular", size: 32)!,
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.strokeColor: Color(red: 145/15, green: 15/255, blue: 37/255).cgColor ?? UIColor.red,
            NSAttributedString.Key.strokeWidth: -6
        ])
        getLabel.position = CGPoint(x: size.width / 2.04, y: size.height / 8.2)
        addChild(getLabel)
    }
    
    func createPuzzlePart() {
        for (index, puzzle) in data.puzzleImages.enumerated() {
            let puzzlePart = SKSpriteNode(texture: SKTexture(imageNamed: puzzle))
            puzzlePart.xScale = 0.065
            puzzlePart.yScale = 0.08
            puzzlePart.zPosition = 4
            puzzlePart.name = "puzzlePart"
            puzzlePart.userData = NSMutableDictionary()
            puzzlePart.userData?.setValue(index, forKey: "index")
            
            let randomX = CGFloat.random(in: size.width * 0.2...size.width * 0.8)
            let randomY = CGFloat.random(in: size.height * 0.3...size.height * 0.75)
            puzzlePart.position = CGPoint(x: randomX, y: randomY)
            addChild(puzzlePart)
        }
    }
    
    func setupRightPosition() {
        for (index, x) in data.xPosition.enumerated() {
            game!.correctPositionsX.append(size.width / x)
            game!.correctPositionsY.append(size.height / data.yPosition[index])
        }
    }
    
    func checkForRightPuzzlePosition(location: CGPoint) {
        if let selectedPuzzlePart = selectedPuzzlePart {
            
            if let index = selectedPuzzlePart.userData?["index"] as? Int {
                let correctX = game!.correctPositionsX[index]
                let correctY = game!.correctPositionsY[index]
                
                if abs(selectedPuzzlePart.position.x - correctX) < 10 && abs(selectedPuzzlePart.position.y - correctY) < 10 {
                    selectedPuzzlePart.position = CGPoint(x: correctX, y: correctY)
                    selectedPuzzlePart.name = "fixedPuzzlePart"
                    selectedPuzzlePart.zPosition = 3
                } else {
                    selectedPuzzlePart.position = location
                }
            } else {
                selectedPuzzlePart.position = location
            }
            
            if checkAllPuzzlesAreInPlace() {
                handleAllPuzzlesInPlace()
            }
        }
    }
    
    func checkAllPuzzlesAreInPlace() -> Bool {
        var allInPlace = true
        
        for (index, _) in data.puzzleImages.enumerated() {
            let correctX = game!.correctPositionsX[index]
            let correctY = game!.correctPositionsY[index]
            
            for child in children {
                if child.name == "puzzlePart" {
                    if child.userData?["index"] as? Int == index {
                        if abs(child.position.x - correctX) > 10 || abs(child.position.y - correctY) > 10 {
                            allInPlace = false
                            break
                        }
                    }
                }
            }
            
            if !allInPlace {
                break
            }
        }
        
        return allInPlace
    }
    
    func handleAllPuzzlesInPlace() {
        game?.isWin = true
        timer?.invalidate()
        createExplosion()
        winAnimation()
    }
    
    func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            self.updateTimer()
        }
    }
    
    func updateTimer() {
        guard !game!.isPause else { return }
        if game?.timeLeft ?? 0 > 0 {
            game?.timeLeft -= 1
            time.attributedText = NSAttributedString(string:"\(String(describing: (game?.timeLeft ?? 0) / 60)):\(String(describing: (game?.timeLeft ?? 0) % 60))", attributes: [
                NSAttributedString.Key.font: UIFont(name: "BowlbyOneSC-Regular", size: 34)!,
                NSAttributedString.Key.foregroundColor: Color(red: 255/255, green: 113/255, blue: 172/255).cgColor ?? UIColor.systemPink,
                NSAttributedString.Key.strokeColor: Color(red: 145/15, green: 15/255, blue: 37/255).cgColor ?? UIColor.red,
                NSAttributedString.Key.strokeWidth: -6
            ])
        } else {
            if game!.isWin != true {
                game?.isLose = true
                timer?.invalidate()
            }
        }
    }
    
    override func didMove(to view: SKView) {
        physicsWorld.contactDelegate = self
        setupView()
        startTimer()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        let node = atPoint(location)
        
        if node.name == "puzzlePart" && node.name != "fixedPuzzlePart" {
            selectedPuzzlePart = node as? SKSpriteNode
            selectedPuzzlePart?.zPosition = 5
        }
        
        if node.name == "restart" || node.name == "restartBackground" {
            resetScene()
        }
        
        if node.name == "pause" || node.name == "pauseBackground" {
            game!.isPause = true
            scene?.isPaused = true
        }
        
        if node.name == "getBackground" {
            game!.isGetTapped = true
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        checkForRightPuzzlePosition(location: location)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        selectedPuzzlePart = nil
    }
}

struct PuzzleGameView: View {
    @StateObject var puzzleGameModel =  PuzzleGameViewModel()
    @StateObject var gameModel =  PuzzleGameData()
    @ObservedObject var router: Router
    var puzzleModel: PuzzleModel
    var body: some View {
        if gameModel.isLose {
            ZStack {
                SpriteView(scene: puzzleGameModel.createDartsGameScene(gameData: gameModel, data: puzzleModel))
                    .ignoresSafeArea()
                    .navigationBarBackButtonHidden(true)
                
                BitesLoseView(router: router, puzzleModel: puzzleModel)
            }
        } else {
            ZStack {
                SpriteView(scene: puzzleGameModel.createDartsGameScene(gameData: gameModel, data: puzzleModel))
                    .ignoresSafeArea()
                    .navigationBarBackButtonHidden(true)
                    .navigationDestination(isPresented: $gameModel.isGetTapped) {
                        BitesRecipeView(router: router, puzzleModel: puzzleModel, bool: true)
                    }
                
                if gameModel.isPause {
                    BitesPauseView(router: router, game: gameModel, puzzleModel: puzzleModel)
                }
            }
        }
           
    }
}

#Preview {
    @ObservedObject var router = Router()
    let puzzleModel = PuzzleModel(image: "",
                                  name: "",
                                  ingredients: "",
                                  cookingTime: "",
                                  recipe: "",
                                  xPosition: [0.0],
                                  yPosition: [0.0],
                                  puzzleImages: [""])
    return PuzzleGameView(router: router, puzzleModel: puzzleModel)
}
