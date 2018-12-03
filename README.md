# App Kyver
Tapline: Kyver is an app that enables you search and contact a senator or representative of the United States.

IOS repo link: https://github.com/lcj420106/hackChallengeUSGov 

Screenshots: Please check out the Screenshots file in the repo.

Description: ViewController has state filters and let the users to chooise between the legislative lower body and the legislative upper body. Features include filter through districts and party. By clicking on the table view cell, the users could get the details of the governor, such as his or her personal url, phone number, profile photos, address, and social media number. The users are able to contact the governor by clicking on the personal url to send emails, and click the phone number to call. There is a filter button to get the governors with specific district and party chosen. We integrate the Google Civic Information API to get all of the information of the senators and representatives of the United States.

IOS Requirement:
1. UI is workable. Integrated the Google Civic Information API.
2. Used UITableView for listing the governors, and UICollectionView for the filter. 
3. Used both navigation ViewControllers for representativeViewController and senatorViewController. Used modal Viewcontroller for the filters.

There is a phantom file with some errors in it. It does not affect the build. We did not delete it for it includes our initial thoughts and some references.
