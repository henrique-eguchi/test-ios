# iOS-Test

## Objective
We would like to have you complete the following code test so we can evaluate your iOS skills. 
Please fork this repository and when you finish, create a Pull Request.  

Your assignment is to create a simple Reddit client that shows the top 50 entries from [Reddit](https://www.reddit.com/top)


## What to do
Create a specific iOS App containing two screens:

1. First screen: use [Reddit API](https://www.reddit.com/dev/api) to list the top 50 entries
- Show: Title, author, thumbnail, number of comments, entry date (following a format like “x hours ago”) 

2. Second screen: details of selected entry from the list
- Feel free to show anything you want about the entry


## Guidelines
To do this please follow these guidelines:

    - Assume the latest platform and use Swift
    - Use MVVM pattern
    - Use Coordinator pattern
    - Use UITableView / UICollectionView to arrange the data
    - Use cocoapods as dependency manager 
    - Support all iPhone screen sizes
    - Use Storyboards/Xibs
    - Create unit tests
    - Add Pull to Refresh on the list
    - Add Pagination support on the list
    - Create your own UI


## Resources

    - [Reddit API](http://www.reddit.com/dev/api)


## Time Spent
We will evaluate the code and time spent

    - You need to fully complete the test
    - Do not spend more than 8 hours
    - Make commits as often as possible
    - Do not make only one commit


## Submission Process

1. Fork this repository (do not clone!)
2. Work on YOUR fork
3. Send a Pull Request using Github interface

Good luck! :)




## Worklog

### 5/4
- 21:15~21:30 - Assignment reading, git fork, clone
- 23:00~0:45 - Understanding the reddit api (What a mess...)) / Base project initialization / Added Moya to abstract the network layer / Created the base models for listing

### 5/5
- 21:45~22:30 - Added Resolver for dependency injection / Adds coordinator for app, reddit list and detail

### 5/6
- 00:00~00:20 - Created loading and reddit children table view cell

### 5/7
- 01:30~02:15 - Fixed model / Created the RedditNetworkManager and added operations for top entries listing as well as its unit tests
- 05:00~06:50 - Installs Kingfisher / Creates ListViewModel / Naming adjusts / Changes coordinator / Creates VM unit tests and adjusts some on Manager / Changes mock json (10 entries)
