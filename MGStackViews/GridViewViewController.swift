import UIKit

final class GridViewViewController: UIViewController {
    
    private let colors: [UIColor] = [.systemOrange, .systemCyan, .systemGray,
                                     .systemRed, .systemBlue, .systemPink,
                                     .systemPurple, .systemYellow, .systemGreen]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemMint
        
        var views: [UIView] = []
        for color in colors {
            let view = UIView()
            view.backgroundColor = color
            views.append(view)
        }
        
        let gridView = GridView(views: views, itemsPerRow: 3)
        view.addSubview(gridView)
        gridView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        gridView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        gridView.heightAnchor.constraint(equalToConstant: 400).isActive = true
        gridView.widthAnchor.constraint(equalTo: gridView.heightAnchor).isActive = true
    }
}

final class GridView: UIView {
    private lazy var verticalStackView = makeStackView(axis: .vertical)
    
    let views: [UIView]
    let itemsPerRow: Int
    
    init(views: [UIView], itemsPerRow: Int) {
        self.views = views
        self.itemsPerRow = itemsPerRow
        super.init(frame: .zero)
        
        translatesAutoresizingMaskIntoConstraints = false
        layout()
    }

    private func layout() {
        addSubview(verticalStackView)
        verticalStackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        verticalStackView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        verticalStackView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        verticalStackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        let viewsPerRow = views.chunked(into: itemsPerRow)
        
        for row in viewsPerRow {
            let rowStackView = makeStackView()
            row.forEach(rowStackView.addArrangedSubview)
            verticalStackView.addArrangedSubview(rowStackView)
        }
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    private func makeStackView(axis: NSLayoutConstraint.Axis = .horizontal) -> UIStackView {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = axis
        stackView.distribution = .fillEqually
        return stackView
    }
}

extension Array {
    func chunked(into size: Int) -> [[Element]] {
        stride(from: 0, through: count - 1, by: size).map {
            Array(self[$0 ..< Swift.min($0 + size, count)])
        }
    }
}
