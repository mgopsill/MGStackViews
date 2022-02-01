import UIKit

final class StackViewPlaygroundViewController: UIViewController {
    
    private lazy var sv1 = makeStackView(with: .fillEqually)
    private lazy var sv2 = makeStackView(with: .fillEqually)
    private lazy var sv3 = makeStackView(with: .fillEqually)
    private lazy var allStackViews = [sv1, sv2, sv3]
    private lazy var fill = makeTitleLabel(with: "fill")
    private lazy var top = makeTitleLabel(with: "top")
    private lazy var bottom = makeTitleLabel(with: "bottom")
        
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        let padding: CGFloat = 5
        let morePadding: CGFloat = 20
        let height: CGFloat = 200

        view.addSubview(sv1)
        sv1.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: morePadding).isActive = true
        sv1.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        sv2.heightAnchor.constraint(equalToConstant: height).isActive = true
        sv1.alignment = .fill
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tap)))
        view.addSubview(fill)
        fill.bottomAnchor.constraint(equalTo: sv1.topAnchor, constant: -padding).isActive = true
        fill.centerXAnchor.constraint(equalTo: sv1.centerXAnchor).isActive = true
        
        view.addSubview(sv2)
        sv2.leadingAnchor.constraint(equalTo: sv1.trailingAnchor, constant: morePadding).isActive = true
        sv2.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        sv2.heightAnchor.constraint(equalToConstant: height).isActive = true
        sv2.alignment = .top
        sv2.spacing = 1
        view.addSubview(top)
        top.bottomAnchor.constraint(equalTo: sv2.topAnchor, constant: -padding).isActive = true
        top.centerXAnchor.constraint(equalTo: sv2.centerXAnchor).isActive = true
        
        view.addSubview(sv3)
        sv3.leadingAnchor.constraint(equalTo: sv2.trailingAnchor, constant: morePadding).isActive = true
        sv3.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        sv3.heightAnchor.constraint(equalToConstant: height).isActive = true
        sv3.alignment = .bottom
        view.addSubview(bottom)
        bottom.bottomAnchor.constraint(equalTo: sv3.topAnchor, constant: -padding).isActive = true
        bottom.centerXAnchor.constraint(equalTo: sv3.centerXAnchor).isActive = true
        
        let colors: [UIColor] = [.systemMint, .systemIndigo, .systemCyan]
        for stackView in allStackViews {
            for i in (0...2) {
                let label = makeLabel(with: " Label \(i + 1)  ")
                label.setContentHuggingPriority(.init(rawValue: 0), for: .horizontal)
                label.backgroundColor = colors[i]
                stackView.addArrangedSubview(label)
            }
        }
    }
    
    @objc private func tap() {
        UIView.animate(withDuration: 0.3) { [self] in
            sv1.axis = sv1.axis == .vertical ? .horizontal : .vertical
        }
    }
    
    private func makeTitleLabel(with text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    private func makeLabel(with text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = .systemFont(ofSize: 14, weight: .thin)
        label.layer.cornerRadius = 5
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    private func makeStackView(with distribution: UIStackView.Distribution) -> UIStackView {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = distribution
        stackView.spacing = 2
        return stackView
    }
}
