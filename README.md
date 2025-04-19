![](https://img.shields.io/badge/Platform-iOS-orange?style=flat-square)
![](https://img.shields.io/badge/Language-Swift-blue?style=flat-square)
![](https://img.shields.io/badge/Architecture-MVVM-darkgreen?style=flat-square)

# PhoneVault
This iOS application is a feature-rich, MVVM-based mobile app built using Swift, Combine, and Core Data, designed to demonstrate real-world iOS development skills. It integrates Google Sign-In via Firebase, handles offline data persistence, provides push notifications, and supports rich media interactions like image capture, gallery selection, and PDF viewing.

## Objective

### 🔐 User Authentication
Implement Google Sign-In using Firebase Authentication to authenticate users. Save the user's details securely in Core Data for offline access and data persistence.

### 📄 PDF Report Viewer
This code uses WKWebView to display a PDF from a given URL. It includes functionalities like loading progress indication, error handling, and sharing options.

### 📸 Image Handling
This class enables users to capture images using the camera or select them from the photo gallery. The selected image is then displayed in a UIImageView.

### 💾 Core Data + API Integration
Fetch data from the specified API and store it in Core Data. Implement update, delete, error handling, and validation functionalities for the stored data.

### 🔔 Push Notifications (via FCM or Local Notification)
Simulate push notifications using a local .apns file to trigger deletion alerts. Upon confirmation, the item is removed from both the UI array and Core Data database.

## Key Features

- MVVM Architecture pattern
- Combine
- Designed for scalability
- Modular code

## Screenshots

<p align="left"><strong>List Screen</strong></p>
<p align="left">
  <img src="Screenshots/List.png" alt="List" width="25%">
</p>

<p align="left"><strong>Google Sign IN</strong></p>
<p align="left">
  <img src="Screenshots/googleSignIN.gif" alt="Google Sign IN" width="25%">
</p>

<p align="left"><strong>PDF Viewer</strong></p>
<p align="left">
  <img src="Screenshots/pdfViewer.png" alt="PDF Viewer" width="25%">
</p>

<p align="left"><strong>Image Gallery & Camera</strong></p>
<p align="left">
  <img src="Screenshots/galleryAlert.png" alt="Gallery Alert" width="25%">
  <img src="Screenshots/gallery.png" alt="Gallery" width="25%">
  <img src="Screenshots/galleryView.png" alt="Gallery View" width="25%">
</p>

<p align="left"><strong>Phone List (CoreData)</strong></p>
<p align="left">
  <img src="Screenshots/phoneList.png" alt="Phone List" width="25%">
</p>
