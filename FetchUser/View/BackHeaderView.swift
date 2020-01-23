//
//  BackHeaderView.swift
//  BaseProject
//
//  Created by Bekir's Mac on 5.02.2019.
//  Copyright © 2019 OtiHolding. All rights reserved.
//
import UIKit

@IBDesignable
public class BackHeaderView: UIView {
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var titleLbl: UILabel!
    
    @IBOutlet weak var iconImageView: UIImageView!
    override public func awakeFromNib() {
        super.awakeFromNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupThisView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupThisView()
    }
    
    private func setupThisView(){
        guard let view = loadViewFromNib() else { return }
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(view)
        contentView = view
        
        
    }
    @IBAction func btnBackPressed(_ sender: Any) {

        UIApplication.getTopViewController()?.navigationController?.popViewController(animated: true)
    }
    
    public func setTitle(title:String){
        self.titleLbl.text = title
    }
    
    func loadViewFromNib() -> UIView? {
        let nibName = String(describing: BackHeaderView.self)
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self,options: nil).first as? UIView
    }
    
}
