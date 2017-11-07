//
//  ReportView.swift
//  Wabbit
//
//  Created by Luis Ezcurdia on 11/3/17.
//  Copyright © 2017 Luis Ezcurdia. All rights reserved.
//

import UIKit

class ReportView: UIView {
    let reuseIdentifier = "reportCell"
    let reuseActionIdentifier = "actionViewCell"
    let langView : LanguagesView = {
        let lv = LanguagesView()
        lv.translatesAutoresizingMaskIntoConstraints = false
        return lv
    }()
    
    let reportsCollection : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .black
        cv.refreshControl = UIRefreshControl()
        cv.refreshControl?.backgroundColor = .platinum
        cv.refreshControl?.addTarget(self, action: #selector(refreshBenchmarks), for: .valueChanged)
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    
    var reportGroups : [ReportGroup]? {
        didSet {
            DispatchQueue.main.async { self.reportsCollection.reloadData() }
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        reportsCollection.register(ReportViewCell.self, forCellWithReuseIdentifier: self.reuseIdentifier)
        reportsCollection.register(SwipeActionViewCell.self, forCellWithReuseIdentifier: self.reuseActionIdentifier)
        reportsCollection.delegate = self
        reportsCollection.dataSource = self
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        addSubview(langView)
        NSLayoutConstraint.activate([
            langView.topAnchor.constraint(equalTo: topAnchor),
            langView.leadingAnchor.constraint(equalTo: leadingAnchor),
            langView.trailingAnchor.constraint(equalTo: trailingAnchor),
            langView.heightAnchor.constraint(equalToConstant: 44)
            ])
        addSubview(reportsCollection)
        NSLayoutConstraint.activate([
            reportsCollection.topAnchor.constraint(equalTo: langView.bottomAnchor),
            reportsCollection.leadingAnchor.constraint(equalTo: leadingAnchor),
            reportsCollection.trailingAnchor.constraint(equalTo: trailingAnchor),
            reportsCollection.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
    }
    
    @objc func refreshBenchmarks() {
        reportsCollection.refreshControl?.beginRefreshing()
        runBenchmarks {
            self.reportsCollection.refreshControl?.endRefreshing()
        }
    }
    
    private func runBenchmarks(completion: @escaping (()->Void)) {
        DispatchQueue.global(qos: .background).async {
            self.reportGroups = []
            let primeGroup = ReportGroup.build("Prime", objcMethod: {
                _ = (OBNumeric.shared() as! OBNumeric).isPrimeLong(181)
            }, swiftMethod: {
                _ = SWNumeric.shared.isPrime(int: 181)
            })
            self.reportGroups?.append(primeGroup)

            let factGroup = ReportGroup.build("Factorial", objcMethod: {
                _ = (OBNumeric.shared() as! OBNumeric).factorialLong(13)
            }, swiftMethod: {
                _ = SWNumeric.shared.factorial(int: 13)
            })
            self.reportGroups?.append(factGroup)
            
            let textTest = self.lipsum() ?? "lorem ipsum"
            let sha1Group = ReportGroup.build("SHA1", objcMethod: {
                _ = (OBCrypto.shared() as! OBCrypto).sha1String(textTest)
            }, swiftMethod: {
                _ = SWCrypto.shared.sha1(string:textTest)
            })
            self.reportGroups?.append(sha1Group)

            let sha256Group = ReportGroup.build("SHA256", objcMethod: {
                _ = (OBCrypto.shared() as! OBCrypto).sha256String(textTest)
            }, swiftMethod: {
                _ = SWCrypto.shared.sha256(string:textTest)
            })
            self.reportGroups?.append(sha256Group)

            let base64Group = ReportGroup.build("Base64 Text", objcMethod: {
                _ = (OBCrypto.shared() as! OBCrypto).base64String(textTest)
            }, swiftMethod: {
                _ = SWCrypto.shared.base64(string:textTest)
            })
            self.reportGroups?.append(base64Group)
            
            let imageTest = self.logoImage() ?? UIImage()
            let base64ImageGroup = ReportGroup.build("Base64 Image", objcMethod: {
                _ = (OBCrypto.shared() as! OBCrypto).base64Image(imageTest)
            }, swiftMethod: {
                _ = SWCrypto.shared.base64(image:imageTest)
            })
            self.reportGroups?.append(base64ImageGroup)
            
            let jsonTest = self.jsonFile() ?? "[]"
            let jsonGroup = ReportGroup.build("Decode JSON", objcMethod: {
                _ = (OBJsonParse.shared() as! OBJsonParse).parseAllCountries(from: jsonTest.data(using: .utf8))
            }, swiftMethod: {
                _ = SWJsonParse.shared.parseAllCountries(string: jsonTest)
            })
            self.reportGroups?.append(jsonGroup)
            
            DispatchQueue.main.async {
                completion()
            }
        }
    }
    
    private func lipsum() -> String? {
        guard let filepath = Bundle.main.path(forResource: "lipsum", ofType: "txt") else { return nil }
        return try? String(contentsOfFile: filepath)
    }
    
    private func logoImage() -> UIImage? {
        guard let filepath = Bundle.main.path(forResource: "logo1128", ofType: "png") else { return nil }
        return UIImage(contentsOfFile: filepath)
    }
    
    private func jsonFile() -> String? {
        guard let filepath = Bundle.main.path(forResource: "countries", ofType: "json") else { return nil }
        return try? String(contentsOfFile: filepath)
    }
}

extension ReportView : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return reportGroups?.count ?? 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let unwrapedGroups = reportGroups {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ReportViewCell
            cell.reportGroup = unwrapedGroups[indexPath.row]
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseActionIdentifier, for: indexPath) as! SwipeActionViewCell
            cell.text = "Swipe down to run benchmarks!"
            return cell
        }
    }
}

extension ReportView : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var height : CGFloat = 125.0
        if reportGroups == nil { height = reportsCollection.frame.height }
        return CGSize(width: reportsCollection.frame.width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func invalidateCollectionViewLayout() {
        self.reportsCollection.collectionViewLayout.invalidateLayout()
    }

}
