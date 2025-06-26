//
//  Trivia View Controller.swift
//  Trivia
//
//  Created by Kareemah on 6/25/25.
//
import UIKit
struct Question {
    let text: String
    let answers: [String]
    let correctAnswerIndex: Int
}

class TriviaViewController: UIViewController {
    @IBOutlet weak var questionNumberLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var restartButton: UIButton!
    
    @IBOutlet var answerButtons: [UIButton]!
    
    private var questions: [Question] = [
        Question(text: "What's the capital of France?", answers: ["Paris", "Rome","Berlin", "Madrid"],correctAnswerIndex: 0),
        Question(text: "What's is 2 + 2?", answers: ["3", "4","5", "2"],correctAnswerIndex: 1),
        Question(text: "What color do you get when you mix red and blue?", answers: ["Green", "Purple","Orange", "Pink"],correctAnswerIndex: 1)
    ]
    
    private var currentQuestionIndex = 0
    private var score = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        restartButton.isHidden = true
        scoreLabel.isHidden = true
        loadQuestion()
    }
    
    private func loadQuestion() {
        guard currentQuestionIndex < questions.count else {
            showFinalScore()
            return
        }
        
        let question = questions[currentQuestionIndex]
        questionLabel.alpha = 0
        questionLabel.text = question.text
        questionNumberLabel.text = "Question \(currentQuestionIndex + 1) of \(questions.count)"
        UIView.animate(withDuration: 0.3) {
            self.questionLabel.alpha = 1
        }
        
        for (index, button) in answerButtons.enumerated() {
            button.setTitle(question.answers[index], for: .normal)
            button.backgroundColor = UIColor.systemBlue
            button.setTitleColor(.white, for: .normal)
            button.isEnabled = true
            button.layer.cornerRadius = 10
            
        }
    }
    
    private func showFinalScore() {
        questionLabel.text = "You got \(score) out of \(questions.count) correct!"
        questionNumberLabel.text = ""
        
        for button in answerButtons {
            button.isHidden = true
            button.isEnabled = false
            button.backgroundColor = UIColor.systemGray
        }
        
        UIView.animate(withDuration: 0.4) {
            self.scoreLabel.text = "Final Score: \(self.score)"
            self.scoreLabel.isHidden = false
            self.restartButton.isHidden = false
        }
    }
    
    @IBAction func answerTapped(_ sender: UIButton) {
        guard let index = answerButtons.firstIndex(of: sender) else { return }
        if index == questions[currentQuestionIndex].correctAnswerIndex {
            score += 1
        }
        currentQuestionIndex += 1
        loadQuestion()
    }
    @IBAction func restartTapped(_ sender: UIButton) {
        currentQuestionIndex = 0
        score = 0
        scoreLabel.isHidden = true
        restartButton.isHidden = true
        for button in answerButtons {
            button.isHidden = false
        }
        loadQuestion()
    }
    
    
}
