# Cibus

Cibus is an iOS app that was designed to promote conservation in the house, one recipe at a time! This application allows you to retrieve a list of recipes that you can make with the ingredients that you have in your house in order of expiration date. That way, you can make recipes with food that is about to expire and save both food and money in the process. Ingredients are inputted by taking a picture of your grocery store receipt or by taking a photo of the ingredients themselves.

On the techinical side, we used the Flickr API to retrieve ingredient images, the Google Cloud Vision API to perform OCR on the receipts and perform reverse image searches on inputted ingredients, and the Microsoft Azure Cognition API to convert abbreviations on receipts to words we can use. Cocoapods on the iOS side include AlamoFire and SwiftyJSON for convenience of image processing. On the backend, we used Flask to carry out all backend data processing and operations. 

Here is a video demo of our application: https://www.youtube.com/watch?v=FSr2y3cw9bc. We hope you enjoy it! We aim to put it on the app store ASAP. 
