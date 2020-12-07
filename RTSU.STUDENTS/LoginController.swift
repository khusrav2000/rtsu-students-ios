//
//  LoginController.swift
//  TNU.STUDENTS
//
//  Created by mac on 1/26/20.
//  Copyright © 2020 Istiqlol Soft. All rights reserved.
//

import UIKit
import Firebase


extension UIViewController {
    
    func hideKeyboard() {
        let Tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self,
                                                                action: #selector(dismissKeyboard))
        
        view.addGestureRecognizer(Tap)
    }
    
    @objc func dismissKeyboard(){
        view.endEditing(true)
    }
    
}

class LoginController: UIViewController {

    @IBOutlet var loginView: UIView!
    @IBOutlet weak var universityName: UILabel!

    @IBOutlet weak var loginText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var tryAgain: UIButton!
    @IBOutlet weak var progressIndic: UIActivityIndicatorView!
    @IBOutlet weak var progressIndicInsideLog: UIActivityIndicatorView!
    
    var loginTextRes: String?
    
    @IBOutlet weak var loginButton: UIButton!
    
    private let networkClient = NetworkingClient()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let _ = UserDefaults.standard.string(forKey: "AppLanguage") {} else {
            UserDefaults.standard.set("ru", forKey: "AppLanguage")
        }
        
        UserDefaults.standard.set([UserDefaults.standard.string(forKey: "AppLanguage")], forKey: "AppleLanguages")
        UserDefaults.standard.synchronize()
        
        tryAgain.isHidden = true
        progressIndic.isHidden = true
        progressIndic.color = .white
        progressIndicInsideLog.isHidden = true
        progressIndic.startAnimating()
        progressIndicInsideLog.startAnimating()
        
        loginTextRes = loginButton.titleLabel?.text!
        
        loginView.setGradientBakcground(colorStart: Colors.gradStart, colorCenter: Colors.gradCenter, colorEnd: Colors.gradEnd)
                
        let loginImage = UIImage(named: "login")
        addLeftImageTo(txtField: loginText, andImage: loginImage! )
        
        let passwordImage = UIImage(named: "password")
        addLeftImageTo(txtField: passwordText, andImage: passwordImage! )
        
        self.hideKeyboard()
        
        loginText.becomeFirstResponder()
        
        addBottomBorder(txtField: loginText)
        addBottomBorder(txtField: passwordText)
        
        setPlaceholderColor(txtField: loginText, color: Colors.lineColor)
        setPlaceholderColor(txtField: passwordText, color: Colors.lineColor)
        
        loginButton.layer.cornerRadius = 30
        
       
        setLetterAndLineSpacing(text: universityName, valueLetter: 5.0, valueLine: 8.0)
        
        let token = UserDefaults.standard.string(forKey: "token") ?? ""
        if(token != ""){
            loginText.resignFirstResponder()
            hiddenFields()
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(refreshController), name: NSNotification.Name("RefreshController"), object: nil)
        
    }
    
    @objc func refreshController(){
        clearFields()
        showFields()
        print("Refresh")
    }
    
    func hiddenFields(){
        
        loginButton.isHidden = true
        passwordText.isHidden = true
        loginText.isHidden = true
    }
    
    func showFields(){
        loginButton.isHidden = false
        passwordText.isHidden = false
        loginText.isHidden = false
    }
    
    func clearFields(){
        loginText.text = ""
        passwordText.text = ""
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let token = UserDefaults.standard.string(forKey: "token") ?? ""
        if(token != ""){
            login()
        }
    }
    
   
    
    func setLetterAndLineSpacing(text: UILabel, valueLetter: Double, valueLine: Double){
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = CGFloat(valueLine)
        
        let attr = [NSAttributedString.Key.paragraphStyle: paragraphStyle, NSAttributedString.Key.kern: valueLetter] as [NSAttributedString.Key : Any]
        
        text.attributedText = NSAttributedString(string: text.text!, attributes: attr)
        
        text.textAlignment = NSTextAlignment.center
        
    }
    
    
    
    func setPlaceholderColor(txtField: UITextField, color: UIColor){
        let attribut = NSAttributedString(string: txtField.placeholder!,
                                          attributes: [NSAttributedString.Key.foregroundColor: color])
        txtField.attributedPlaceholder = attribut
    }
    
    
    
    func addLeftImageTo(txtField: UITextField, andImage img: UIImage) {
        let leftImageView = UIImageView(frame: CGRect(x: 0.0, y: 0.0, width: img.size.width,
                                                         height: img.size.height))
           
        leftImageView.image = img
        txtField.leftView = leftImageView
        txtField.leftViewMode = .always
           
    }
    
    func addBottomBorder(txtField: UITextField){
        
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: -5.0, y: txtField.frame.height - 1, width: txtField.frame.width + 10, height: 2)
        
        bottomLine.backgroundColor = Colors.lineColor.cgColor
        txtField.layer.addSublayer(bottomLine)
        
    }

    
    @IBAction func buttonAction(sender:UIButton!){
        let btnsendtag: UIButton = sender
        if btnsendtag.tag == 1 {
            UserDefaults.standard.set("", forKey: "token")
            login()
            print("qqq")
        
        }
    }
    
    func login(){
        
        if loginButton.isHidden {
            progressIndic.isHidden = false
        } else {
            progressIndicInsideLog.isHidden = false
            loginButton.setTitle("", for: .normal)
        }
        
        let token = UserDefaults.standard.string(forKey: "token") ?? ""
        print(token)
        networkClient.auth(token: token, login: loginText.text!, password: passwordText.text! ){ (json, error) in
            if let error = error {
                print(error.localizedDescription)
                self.showRightToast()
                
            } else if let json = json {
                
                let token = json["message"] as! String
                self.setToken(token: token)
                self.loadProfileInformation()
                
            }
        }
    }
    
    func setToken(token: String){
        
        let defaults = UserDefaults.standard
        defaults.set(token, forKey: "token")
        print(token)
        
    }
    
    func loadProfileInformation(){
        let token = UserDefaults.standard.string(forKey: "token")!
        print(token)
        
        networkClient.getProfile(token: token) { (result, error) in
            if let error = error{
                print("ERROR!!")
                print(error.localizedDescription)
                self.showRightToast()
            } else if let studentInfo = result {
                StudentData.studentInfo = studentInfo
                print(studentInfo)
                self.loadSemesters()
            }
        }
    }
    
    var sems = ""
    func loadSemesters(){
        
        let token = UserDefaults.standard.string(forKey: "token")!
        
        networkClient.getSemesters(token: token) { (result, error) in
            if let error = error {
                print(error.localizedDescription)
                self.showRightToast()
            } else if let semesters = result {
                StudentData.semesters = semesters
                self.loadCorsesBySemester(semesterId: semesters[0].ID!)
                StudentData.semesters?[0].isActive = true
            }
        }
    
    }
    
    func loadCorsesBySemester(semesterId: Int){
        
        
        let token = UserDefaults.standard.string(forKey: "token")!
        print(semesterId)
        networkClient.getCoursesBySemester(token: token, semesterId: semesterId) { (result, error) in
            if let error = error {
                print(error.localizedDescription)
                self.showRightToast()
            } else if let courses = result {
                StudentData.courses = courses
                self.startMain()
            }
        }
    
    }
    
    func startMain(){
        
        //dismiss(animated: true, completion: nil)
        //performSegue(withIdentifier: "goMain", sender: self)
        
        /*
        let mainStoryboard = UIStoryboard(name: "MainStoryboard", bundle: Bundle.main)
        
        guard let destinationViewController = mainStoryboard.instantiateViewController(identifier: "MainStoryboard") else {
            print("Dont find")
            return
        }
        */
        
        //let storyboard = UIStoryboard(name: "Login", bundle: nil)
        
        GAd.interstitial = createAndLoadInterstitial()
        
        progressIndic.isHidden = true
        progressIndicInsideLog.isHidden = true
        loginButton.setTitle(loginTextRes, for: .normal)
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "MainStoryboard") as! TabBarController
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    

    }
    
    func createAndLoadInterstitial() -> GADInterstitial {
        
        //let interstitial: GADInterstitial = GADInterstitial(adUnitID: "ca-app-pub-3940256099942544/1033173712") //TEST
        let interstitial = GADInterstitial(adUnitID: "ca-app-pub-5583392303902725/6812928315")
        print("qwe1")
        let request: GADRequest = GADRequest()
        interstitial.load(request)
        return interstitial
        
    }
    
    func showRightToast(){
        progressIndic.isHidden = true
        progressIndicInsideLog.isHidden = true
        loginButton.setTitle(loginTextRes, for: .normal)
        
        let lang = UserDefaults.standard.string(forKey: "AppLanguage")
        if IncLoadData.inCorrectLogOrPass == true {
            print("SHOWEN!!!!!")
            if lang == "ru" {
                self.showToast(controller: self, message: "Неправлиьный логин или пароль", seconds: 2)
            } else {
                self.showToast(controller: self, message: "Логин ё гузарвожа нодуруст аст", seconds: 2)
            }
            
            showFields()
        } else if IncLoadData.serverNotResponse == true {
            if Reachability.isConnectedToNetwork() {
                if lang == "ru"{
                    self.showToast(controller: self, message: "Сервер не отвечает", seconds: 2)
                } else {
                    self.showToast(controller: self, message: " Сервер ҷавоб намедиҳад", seconds: 2)
                }
            } else {
                if lang == "ru"{
                    self.showToast(controller: self, message: "Проверте поключение к интернету", seconds: 2)
                } else {
                    self.showToast(controller: self, message: "Пайвастшавии интернети худро бисанҷед", seconds: 2)
                }
            }
        } else {
            if lang == "ru"{
                self.showToast(controller: self, message: "Неизвестная ошибка", seconds: 2)
            } else {
                self.showToast(controller: self, message: "Хатогии номаълум", seconds: 2)
            }
        }
        
        if loginButton.isHidden {
            tryAgain.isHidden = false
        }
        
        IncLoadData.inCorrectLogOrPass = false
        IncLoadData.serverNotResponse = false
    }
    
    func showToast(controller: UIViewController, message: String, seconds: Double) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.view.backgroundColor = .black
        alert.view.alpha = 0.7
        alert.view.layer.cornerRadius = 20
        
        controller.present(alert, animated: true)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + seconds) {
            alert.dismiss(animated: true)
        }
    }
    
    @IBAction func tryAgian(_ sender: Any) {
        tryAgain.isHidden = true
        login()
    }
    
    
}

