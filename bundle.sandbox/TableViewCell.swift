//
//  TableViewCell.swift
//  bundle.sandbox
//
//  Created by ALEKSANDR POZDNIKIN on 14.08.2022.
//

import UIKit

class TableViewCell: UITableViewCell {

//    override func awakeFromNib() {
//        super.awakeFromNib()
//        // Initialization code
//    }
//
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }
//
//}
//    class PhotosTableViewCell: UITableViewCell {
        var width:CGFloat = {
            if var widthH = UIApplication.shared.keyWindow?.safeAreaLayoutGuide.layoutFrame.width {
                widthH = (widthH - 48)/4
                return widthH
            }
            return 0
        }()
        let photoLabel: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.textColor = .black
            label.font = .systemFont(ofSize: 24, weight: .bold)
            return label
        }()
        let arrow: UILabel = {
            let label = UILabel()
            label.text = "→"
            label.translatesAutoresizingMaskIntoConstraints = false
            label.textColor = .black
            label.font = .systemFont(ofSize: 24, weight: .bold)
            return label
        }()
        let photoImageView: UIImageView = addPhotoImageView()
        let photoImageView1: UIImageView = addPhotoImageView()
        let photoImageView2: UIImageView = addPhotoImageView()
        let photoImageView3: UIImageView = addPhotoImageView()
        let stackView: UIStackView = {
            let stackView = UIStackView()
            stackView.translatesAutoresizingMaskIntoConstraints = false
            stackView.axis = .horizontal
            stackView.spacing = 8
            return stackView
        }()
        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            addSubview()
            constraints()
        }
        func constraints(){
            NSLayoutConstraint.activate([
                self.photoLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 12),
                self.photoLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 12),
                self.photoLabel.heightAnchor.constraint(equalToConstant: 24),
                
                self.arrow.centerYAnchor.constraint(equalTo: self.photoLabel.centerYAnchor),
                self.arrow.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 12),
                self.arrow.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -12),
                self.arrow.heightAnchor.constraint(equalToConstant: 24),
                
                self.stackView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 12),
                self.stackView.topAnchor.constraint(equalTo: self.photoLabel.bottomAnchor, constant: 12),
                self.stackView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -12),
                self.stackView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -12),
                self.stackView.heightAnchor.constraint(equalToConstant: width),
                
                self.photoImageView.widthAnchor.constraint(equalToConstant: width),
                self.photoImageView1.widthAnchor.constraint(equalToConstant: width),
                self.photoImageView2.widthAnchor.constraint(equalToConstant: width),
                self.photoImageView3.widthAnchor.constraint(equalToConstant: width)
            ])
        }
        func addSubview(){
            self.contentView.addSubview(photoLabel)
            self.contentView.addSubview(arrow)
            self.stackView.addArrangedSubview(photoImageView)
            self.stackView.addArrangedSubview(photoImageView1)
            self.stackView.addArrangedSubview(photoImageView2)
            self.stackView.addArrangedSubview(photoImageView3)
            self.contentView.addSubview(stackView)
        }
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        override func setSelected(_ selected: Bool, animated: Bool) {
            super.setSelected(selected, animated: animated)
        }
    }
    func addPhotoImageView()-> UIImageView{
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .black
        imageView.layer.cornerRadius = 6
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }
/*internal func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {

   // let delete = UITableViewRowAction(style: .destructive, title: "Delete") { (action, indexPath) in
    let contextItem = UIContextualAction(style: .destructive, title: "") {  (contextualAction, view, boolValue) in
    // delete item at indexPath
       //if self.isfilterenabled == true {
         //   return
        //}


        if self.isfilterenabled == true {
            //entryFilter.filteredEntries[indexPath.row]
            self.entryFilter.filteredEntries.remove(at: indexPath.row)
        } else {
            self.data.remove(at: indexPath.row)
        }

        self.table.deleteRows(at: [indexPath], with: .fade)
        self.save()
    }



    //let share = UITableViewRowAction(style: .normal, title: "SavePDF") { (action, indexPath) in
        // share item at indexPath
    let contextItemSave = UIContextualAction(style: .normal, title: "") {  (contextualAction, view, boolValue) in





        let alert  = UIAlertController(title: "Done! ", message: "PDF has been saved " ,preferredStyle: .alert)

        let okAction = UIAlertAction(title: "OK ", style: .default, handler: nil)
        alert.addAction(okAction)

        alert.popoverPresentationController?.sourceView = self.view // so that iPads won't crash

        // exclude some activity types from the list (optional)
        //activityViewController.excludedActivityTypes = [ UIActivityTypeAirDrop, UIActivityTypePostToFacebook ]

        // present the view controller
        self.present(alert, animated: true, completion: nil)
        // present(alert, animated : true, completion : nil )

    }

   // share.backgroundColor = UIColor.blue

    contextItemSave.image = UIImage(named:"PDF.jpg")
    contextItem.image = UIImage(named:"delete.jpg")
    let swipeActions = UISwipeActionsConfiguration(actions: [contextItem,contextItemSave])

    return swipeActions
    //return [delete, share]
}`*/
