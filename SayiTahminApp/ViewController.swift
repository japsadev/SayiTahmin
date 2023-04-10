//
//  ViewController.swift
//  SayiTahminApp
//
//  Created by Salih Yusuf Göktaş on 10.04.2023.
//

import UIKit

class ViewController: UIViewController {

	@IBOutlet weak var txtTahminEdilecekSayi: UITextField!
	@IBOutlet weak var imgKaydet: UIImageView!
	@IBOutlet weak var btnKaydet: UIButton!
	@IBOutlet weak var txtTahminSayisi: UITextField!
	@IBOutlet weak var imgTahminDurum: UIImageView!
	@IBOutlet weak var btnDene: UIButton!
	@IBOutlet weak var lblSonuc: UILabel!
	
	@IBOutlet weak var imgYildiz1: UIImageView!
	@IBOutlet weak var imgYildiz2: UIImageView!
	@IBOutlet weak var imgYildiz3: UIImageView!
	@IBOutlet weak var imgYildiz4: UIImageView!
	@IBOutlet weak var imgYildiz5: UIImageView!
	
	var yildizlar : [UIImageView] = [UIImageView]() //ekrandaki 5 yıldızı dizi halinde tutar
	let maxDenemeSayisi : Int = 5 //kullanıcının yapabileceği max deneme sayısı
	var denemeSayisi : Int =  0 //kullanıcı kaç tane deneme yaptı
	var hedefSayi : Int = -1 //tahmin edilmesi gereken sayı
	var oyunBasarili : Bool = false //oyun başarılı bir şekilde sona ererse burası true olacak
	
	
	
	override func viewDidLoad() {
		super.viewDidLoad()

		//Numerik klavye kodu
		txtTahminEdilecekSayi.keyboardType = UIKeyboardType.numberPad
		txtTahminSayisi.keyboardType = UIKeyboardType.numberPad
		
		
		//Klavye kapatma kodu
		let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector (closeTheKeyboard))
		view.addGestureRecognizer(gestureRecognizer)
		}

	@objc func closeTheKeyboard() {
		
		view.endEditing(true)
	
		
		
		yildizlar = [imgYildiz1,imgYildiz2,imgYildiz3,imgYildiz4,imgYildiz5]
		
		imgKaydet.isHidden = true
		imgTahminDurum.isHidden = true
		btnDene.isEnabled = false
		txtTahminEdilecekSayi.isSecureTextEntry = true
		lblSonuc.text = ""


	}

	@IBAction func btnKaydetClicked(_ sender: UIButton) {
		imgKaydet.isHidden = false
		if let t = Int(txtTahminEdilecekSayi.text!) {
			hedefSayi = t
			btnDene.isEnabled = true
			txtTahminEdilecekSayi.isEnabled = false
			btnKaydet.isEnabled = false
			imgKaydet.image = UIImage(named: "onay")
		} else {
			imgKaydet.image = UIImage(named: "hata")
		}
		
	}
	
	
	
	@IBAction func btnDeneClicked(_ sender: UIButton) {
		//kullanıcı oyunu bitirmişse herhangi bir şey yapma geri dön
		if oyunBasarili == true || denemeSayisi > maxDenemeSayisi {
			return
		}
		imgTahminDurum.isHidden = false
		if let girilenSayi = Int(txtTahminSayisi.text!) {
			
			//eğer kullanıcı düzgün bir değer girdiyse
			denemeSayisi += 1
			yildizlar[denemeSayisi-1].image = UIImage(named: "beyazYildiz")
			
			if girilenSayi > hedefSayi {
				imgTahminDurum.image = UIImage(named: "asagi")
				txtTahminSayisi.backgroundColor = UIColor.red
			} else if girilenSayi < hedefSayi {
				imgTahminDurum.image = UIImage(named: "yukari")
				txtTahminSayisi.backgroundColor = UIColor.red
			}
			else {
				//iki sayı birbirine eşittir
				//oyuncu doğru tahmin etti
				imgTahminDurum.image = UIImage(named: "tamam")
				btnKaydet.isEnabled = true
				lblSonuc.text = "DOĞRU TAHMİN !"
				txtTahminSayisi.backgroundColor = UIColor.green
				txtTahminEdilecekSayi.isSecureTextEntry = false
				oyunBasarili = true
				
				let alertController = UIAlertController(title: "TEBRİKLER !", message: "SAYIYI DOĞRU TAHMİN ETTİNİZ", preferredStyle: UIAlertController.Style.alert)
				
				let okAction = UIAlertAction(title: "TAMAM", style: UIAlertAction.Style.default, handler: nil)
				alertController.addAction(okAction)
			
				present(alertController, animated: true, completion: nil)
				
				
				
				return
			}
			
		} else {
			// eğer kullanıcının girdiği değer düzgün değilse
			imgTahminDurum.image = UIImage(named: "hata")
		}
		if denemeSayisi == maxDenemeSayisi {
			// buraya gelindiyse oyun başarısız bir şekilde sona ermiştir
			btnDene.isEnabled = false
			imgTahminDurum.image = UIImage(named: "hata")
			lblSonuc.text = "OYUN BAŞARISIZ \n Arkadaşın \(hedefSayi) Sayısını Girmişti"
			txtTahminEdilecekSayi.isSecureTextEntry = false
			
			let alertController = UIAlertController(title: "ÜZGÜNÜM :(", message: "SAYIYI DOĞRU TAHMİN EDEMEDİN TAHMİN ETMEN GEREKEN SAYI : \(hedefSayi)", preferredStyle: UIAlertController.Style.alert)
			
			let okAction = UIAlertAction(title: "TAMAM", style: UIAlertAction.Style.default, handler: nil)
			alertController.addAction(okAction)
			
			present(alertController, animated: true, completion: nil)
			
			return
		}
	}
	
}

