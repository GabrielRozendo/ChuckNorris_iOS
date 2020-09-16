# Tech Challenge - Mobile Engineer

## We expect from your code

- Follow **Solid** principles and **Clean Code**
- Use **Dependency Injection** (using framework or not)
- Code in many ways and flows with **Automation Testing**:
  - Unit
  - Integration
  - Acceptance
- Performance testing as first-class citizen (using framework or not)
- Use **functional reactive programming** (RxSwift / RxJava)
- Create an **architectural responsibilities** well defined (MVC, MVVM, VIPER, etc)
- Implement a setup of **Continuous Integration** and it would be ready for Continuous Delivery
- Make an **optimized user interface** using the best patterns from native UI Toolkit

## We expect from you

- Give us path that we could identify your tasks division, as tracking of execution of them (suggestion: Github projects)
- Follow the correct way of use Git, with good messages on commit and good size, branches as well
- Documentate some of your main decisions and approach in project
- Contact us in any weird thing or something that does not make sense
- We expect to find a minimal documentation that describe the basic to:
  - install the project to have up-and-running
  - running some builds and generate the artefacts from CLI

## Description

In this challenge you would create a small application to fetch an API Rest from [Chuck Norris facts](https://api.chucknorris.io/)
The app should allow the user search for facts through API and share them with friends

The API documentation can be found on <https://api.chucknorris.io/>

[![Chuck Norris](https://api.chucknorris.io/img/chucknorris_logo_coloured_small@2x.png)](https://api.chucknorris.io/)

---

### Part 1 - Facts 1

- The main screen shows the facts list from Chuck Norris. **On app's first access this screen is empty**
- This screen has a link to navigate to search page where user can type (see more details below)
- On success search one fact, the results are shown on main screen, such on image below

![Part 1 - Facts 1](Wireframe1_Facts1.png)

- Think that image as wireframe
- Use the appropriate UI following the platform patterns to **show the result list** and **navigate to search page**

### Part 1 - Facts 2

- Each item in the list should have an action to share the URL of that fact. Use the simpler system tool to do that
- The items in the list would have many sizes. To handle that you should **use 2 different font sizes** as stated by fact's characters length. Use the 80 characters as a magic number. This logic should be testable
- **Not all facts have a category**. In this case use **UNCATEGORIZED** in fact. This logic should be testable.
- This list is not paginate and neither updatable by pull-to-refresh or something else

![Part 1 - Facts 2](Wireframe2_Facts2.png)

### Part 1 - Facts 3

- Your logic should be robust enough to show the user not only the results form success search but also the error states
- In particular you must offer states and implementations of UI and distincts actions to show connection errors and REST errors
- All possible screen outputs must be tested automated at the integration level, and preferably at the functional acceptance via UI tests

---

### Part 2 - Search 1

- The application's second screen allow user to type a term to search (should be send in API request)
- This screen allow a **tag cloud words** of suggestions of terms to search as well last searches terms performed by user
- Use the best UI approach as platform guidelines, in **text input** and **terms list**

![Part 2 - Search 1](Wireframe3_Search1.png)

- Think that image as wireframe

### Part 2 - Search 2

![Part 2 - Search 2](Wireframe4_Search2.png)

- The tag cloud words must be populated from categories in REST API. **They must be loaded the first time the app is started and persisted offline, asynchronously.** This front-end logic should be testable.
- Among the preloaded categories available, 8 of them are chosen at random to form search suggestions. This front-end logic must be testable.
- Each item in search suggestion has an action and should search the term in those categories as parameters

### Part 2 - Search 3

- The terms from past searches are available below the suggestions and they persist offline. These terms have action and request a new search on API using that term.
- The list of terms already used does not contain repeated entries. This front-end logic must be testable.
- The list of terms already used is ordered in such a way that the most recently used term appears first in the list. This front-end logic must be testable.

![Part 2 - Search 3](Wireframe5_Search3.png)

### Part 2 - Search 4

- When user choose type a new term in search field, you should offer the input text keyboard with search action (enter)

![Part 2 - Search 4](Wireframe6_Search4.png)

---

## **Bonus**

We suggest you choose one of extras below to follow and increment your challenge solution

The additional features shows a high level difficult rather those before and add you some points in your evaluation

You gain so much more points if do both extras

### **Extra 1 - Auto Retry**

- Add the feature to automatic retry by Reactive Programming to REST requests
- To do that, you should implement a logic while user see the loading state the application try a new API REST request if gets some network error or 5xx

#### To validate the extra 1

- Decide how to identify connection errors and which them would be handle
- Use the auto-retry logic in every place that use the requests
- Use the approach to do at maximum 2 try, with time interval of 4 and 8 seconds between them

These behaviors and definitions should be tested in unit and integration levels

### **Extra 2 - Offline Facts**

- **offline-first**
- To do that, you should persist data using some tool the success searches and relate them to terms already searched. The local storage must be the real origin source

#### To validate the extra 2

- The user can see all the offline cache of everything searched
- The user can see new facts related to a term already searched when online, if exist, independent they come from database
- Have up to 10 random facts in home screen when offline or online, as it is saved on device

These behaviors and definitions should be tested in unit and integration levels

---

### GOOD LUCK
