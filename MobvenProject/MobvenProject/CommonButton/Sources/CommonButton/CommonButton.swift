
import UIKit

public class CommonButton: UIButton {


    public override init(frame: CGRect) {
        super.init(frame:  frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    func setupUI() {
        layer.cornerRadius = frame.height / 2
        setImage(UIImage(named: "SaveButtonIcon"), for: .normal)
    }
}
