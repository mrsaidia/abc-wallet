//
//  ToolButtonsBarView.swift
//  AlphaWallet
//
//  Created by Vladyslav Shepitko on 07.09.2021.
//

import UIKit
import Combine

enum ToolbarConfiguration {
    case buttons(type: ButtonsBarButtonType, count: Int)
}

class ToolButtonsBarView: UIView, ButtonsBarViewType {
    var height: CGFloat { HorizontalButtonsBar.buttonsHeight }

    private let moreButtonIndex: Int = 2
    private var moreButtons: [UIButton] = []
    private let buttonsBar = HorizontalButtonsBar(configuration: .empty)
    private var observation: NSKeyValueObservation?

    weak var viewController: UIViewController?
    @objc dynamic private (set) var buttons: [BarButton] = []
    var cancellable = Set<AnyCancellable>()
    
    init() {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = Configuration.Color.Semantic.defaultViewBackground
        addSubview(buttonsBar)

        NSLayoutConstraint.activate([buttonsBar.anchorsConstraint(to: self)])
    }

    func observeButtonUpdates(closure: @escaping (_ sender: ButtonsBarViewType) -> Void) {
        guard observation == nil else { return }

        observation = observe(\.buttons) { [weak self] _, _ in
            guard let strongSelf = self else { return }

            closure(strongSelf)
        }
    }

    deinit {
        observation.flatMap { $0.invalidate() }
    }

    required init?(coder: NSCoder) {
        return nil
    }

    func configure(configuration: ToolbarConfiguration) {
        moreButtons = []
        buttons = []

        switch configuration {
        case .buttons(let type, let count):
            if count == .zero {
                buttonsBar.configure(.empty)
            } else {
                var moreElements: [ButtonsBarButtonType] = []
                var toolbarElements: [ButtonsBarButtonType] = []

                if count > moreButtonIndex {
                    for index in (0 ..< count) {
                        if index < moreButtonIndex {
                            toolbarElements += [type]
                        } else if index == moreButtonIndex {
                            toolbarElements += [type]
                            moreElements += [type]
                        } else {
                            moreElements += [type]
                        }
                    }
                } else {
                    toolbarElements = (0 ..< count).map { _ in type }
                }

                buttonsBar.configure(.custom(types: toolbarElements))

                for index in toolbarElements.indices {
                    let button = buttonsBar.buttons[index]

                    if index == moreButtonIndex {
                        button.setTitle(R.string.localizable.more(), for: .normal)
                        button.addTarget(self, action: #selector(optionsButtonTapped), for: .touchUpInside)
                    } else {
                        buttons += [button]
                    }
                }

                for _ in moreElements {
                    let button = BarButton()

                    buttons += [button]
                    moreButtons += [button]
                }
            }
        }
    }

    @objc private func optionsButtonTapped(sender: BarButton) {
        guard moreButtons.isEmpty == false else { return }

        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alertController.popoverPresentationController?.sourceView = sender
        alertController.popoverPresentationController?.sourceRect = sender.centerRect

        for button in moreButtons {
            guard let title = button.title(for: .normal) else { continue }

            let action = UIAlertAction(title: title, style: .default) { _ in
                button.sendActions(for: .touchUpInside)
            }
            action.isEnabled = button.isEnabled

            alertController.addAction(action)
        }

        let cancelAction = UIAlertAction(title: R.string.localizable.cancel(), style: .cancel) { _ in }
        alertController.addAction(cancelAction)

        viewController?.present(alertController, animated: true)
    }

    func anchorsConstraint(to view: UIView) -> [NSLayoutConstraint] {
        return [
            leadingAnchor.constraint(equalTo: view.leadingAnchor),
            trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
    }
}
