//
//  OnboardingViewController.swift
//  SelFit
//
//  Created by Reathan Luo on 19/1/22.
//

import Foundation
import UIKit

class OnboardingViewController:UIViewController{
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var pageControl: UIPageControl!
    
    var slides:[OnboardingSlide] = []
    var currentPage = 0{
        didSet{
            pageControl.currentPage = currentPage
            if currentPage == slides.count - 1{
                nextBtn.setTitle("Get Started", for: .normal)
            }else{
                nextBtn.setTitle("Next", for: .normal)
            }
        }
    }
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        slides = [
            OnboardingSlide(title: "Take down your notes", description: "At school? At Home? No matter where, take down your notes and ideas", image: UIImage(named: "track")!),
            OnboardingSlide(title: "Need a calendar?", description: "Feel free to add your activities and events into calendars", image: UIImage(named: "track2")!),
            OnboardingSlide(title: "Big news!", description: "Check out what is happeing in the world!", image: UIImage(named: "track3")!)
        ]
        pageControl.numberOfPages = slides.count

    }
    @IBAction func nextBtnClicked(_ sender: UIButton) {
        if currentPage == slides.count - 1{
//            let controller = storyboard?.instantiateViewController(withIdentifier: "HomeNC") as! UITabBarController
//            controller.modalPresentationStyle = .fullScreen
//            controller.modalTransitionStyle = .coverVertical
//            UserDefaults.standard.hasOnboarded = true
//            present(controller, animated: true, completion: nil)
            
//            let controller = storyboard?.instantiateViewController(withIdentifier: "signInUp") as! UINavigationController
//            controller.modalPresentationStyle = .fullScreen
//            controller.modalTransitionStyle = .coverVertical
//            UserDefaults.standard.hasOnboarded = true
//            present(controller, animated: true, completion: nil)
            
            
            let storyboard = UIStoryboard(name: "SignInSignUp", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "signInUp") as! UINavigationController
            UserDefaults.standard.hasOnboarded = true
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true, completion: nil)
            
        }else{
            currentPage += 1
            let indexPath = IndexPath(item: currentPage, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }

    }
}

extension OnboardingViewController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return slides.count
        
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnboardingCollectionViewCell.identifier, for: indexPath) as! OnboardingCollectionViewCell
        cell.setup(slides[indexPath.row])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        currentPage = Int(scrollView.contentOffset.x / width)
    }
}
