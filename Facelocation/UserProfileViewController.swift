//
//  UserProfileViewController.swift
//  Facelocation
//
//  Created by Nastro Mo on 20.03.2018.
//  Copyright © 2018 Facelocation. All rights reserved.
//

import UIKit
import Alamofire

class UserProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var userAvatar: UIButton!
    @IBOutlet weak var btn: UIButton!
    
    var avatarURL: String?
    var requestURL = URLlist.baseURL + URLlist.getUserProfileGET
    var localPath: URL?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getUserData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Назад", style: .plain, target: nil, action: nil)
    }

    @IBAction func choseAvatar(_ sender: Any) {
        let image = UIImagePickerController()
        image.delegate = self
        image.sourceType = UIImagePickerControllerSourceType.photoLibrary
        image.allowsEditing = false
        self.present(image, animated: true, completion: nil)
    }
    
    @IBAction func saveChanges(_ sender: Any) {
        uploadImage()
    }
    
    //Get User Data
    func getUserData(){
            Alamofire.request(requestURL,
                              method: .get,
                              encoding: URLEncoding.default,
                              headers: URLlist.headers).responseJSON {response in
                                
                                switch response.result {
                                case .success:
                                    if response.response?.statusCode == 200{
                                        let response =  response.result.value as! Dictionary<String, Any>
                                        self.avatarURL = response["avatar_mob"] as? String
                                        print(self.avatarURL ?? "ЮРЛ НЕ ПРИШЕЛ")
                                        self.setUserAvatar()
                                    }
                                case .failure(let error):
                                    print("ОШИБКА ПОЛУЧЕНИЯ ДАННЫХ ПОЛЬЗОВАТЕЛЯ")
                                    print(error)
                                }
            }
    }
    
    //Downloading and Set User Avatar from URL
    func setUserAvatar(){
        let imageURL = URL(string: avatarURL!)
        let data = try? Data(contentsOf: imageURL!)
        let userAvatarImage = UIImage(data: data!)
        userAvatar.setImage(userAvatarImage, for: .normal)
        userAvatar.layer.cornerRadius = 38;
        userAvatar.layer.masksToBounds = true;
    }
    
    
    //Set User Avatar
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        userAvatar.layer.cornerRadius = 38;
        userAvatar.layer.masksToBounds = true;
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        userAvatar.setImage(image, for: .normal)
        
        
        let imageUrl          = info[UIImagePickerControllerReferenceURL] as? NSURL
        let imageName         = imageUrl?.lastPathComponent
        let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let photoURL = NSURL(fileURLWithPath: documentDirectory)
        localPath = photoURL.appendingPathComponent(imageName!)!
        
        do {
            try UIImageJPEGRepresentation(image, 1.0)?.write(to: localPath!)
            print("File user avatar saved")
            print(localPath)
        }catch {
            print("Error saving file")
        }

        self.dismiss(animated: true, completion: nil)
    }
    
    
    //Upload chosen user avatar on server
    func uploadImage(){
        Alamofire.upload(
            multipartFormData: { multipartFormData in
                multipartFormData.append(self.localPath!, withName: "file")
        },
            usingThreshold:UInt64.init(),
            to: "https://face-location.com/api/profile/avatar",
            method:.post,
            headers: URLlist.headers,
            encodingCompletion: { encodingResult in
                switch encodingResult {
                case .success(let upload, _, _):
                    upload.responseJSON { response in
                        debugPrint(response)
                    }
                case .failure(let encodingError):
                    print(encodingError)
                }
        }
        )
    }
}
