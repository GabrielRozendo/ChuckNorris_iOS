# WIP: Chuck Norris facts - iOS Swift

[![Build Status](https://app.bitrise.io/app/393cf6c71a71d8ae/status.svg?token=1IqoCnYbN7EHmByZJg0Rgw&branch=main)](https://app.bitrise.io/app/393cf6c71a71d8ae)

![Top Language](https://img.shields.io/github/languages/top/GabrielRozendo/ChuckNorris_challenge_iOS)
![Repository size](https://img.shields.io/github/repo-size/GabrielRozendo/ChuckNorris_challenge_iOS)
![Issues](https://img.shields.io/github/issues/GabrielRozendo/ChuckNorris_challenge_iOS)
![PR](https://img.shields.io/github/issues-pr/GabrielRozendo/ChuckNorris_challenge_iOS)
![Code Review welcome](https://img.shields.io/badge/code_review-welcome-blue)
![Last commit](https://img.shields.io/github/last-commit/GabrielRozendo/ChuckNorris_challenge_iOS)
[![Maintained](https://img.shields.io/maintenance/yes/2020)](https://GitHub.com/GabrielRozendo/ChuckNorris_challenge_iOS/graphs/commit-activity)


## Mobile Engineer - Code challenge

It is a tech challenge interview for Mobile Engineer as iOS or Android native.

The problem to solve is in [challenge.md](challenge/challenge.md)

I'm also doing it in [Flutter](https://github.com/GabrielRozendo/ChuckNorris_Flutter) and I'll do it in Android (basic version) to learn Kotlin!


### Summary

Use the [Chuck Norris API](https://api.chucknorris.io/) to search or get a random fact, save some stuff in local storage. _Tests, tests everywhere!_

- Home: Main screen and the result list
- Search: Search the facts, with category and list all past searches. Update the results on Home View with RxSwift

---

## Information

I've decided to use this challenge as a portfolio and create some variations from it to show some resources/architectures, so maybe it sounds like overengineering if we think it as an app with only two screens with a single developer.

The goal here is to show some approaches! Keep it in mind!

The project is setup for iOS 13 and running in any device with that iOS, without any UI issue known so far in smallest or biggest devices.

There is no warning in this moment. If any issue happens, it will be on project/issues

## Tasks

One item from the challenge is to separate the tasks and track the execution.
So check it out in [projects](https://github.com/GabrielRozendo/ChuckNorris_challenge_iOS/projects)

Each issue (task in Kanban board) is a feature/epic.
I've transformed in issue to use the advanced resources of GitHub projects (other else it would be only a task with one phrase)

## My approach

The goal here is to build a solution in parts and in small steps, so I'll improve it with more resources (check out the project to see some of them) in future.

Each feature is a branch and after finalizing it, will merge through a PR in GitHub.

In some cases and some approaches it'll be better to separate in different branches without PR/MR to not change the original context.

I've chose use the main original colors from [site's css style](https://api.chucknorris.io/css/styles.css) and [from](https://coolors.co/image-picker) the [main image](https://api.chucknorris.io/img/chucknorris_logo_coloured_small@2x.png)

Here is the [result in coolors](https://coolors.co/222222-228dbb-f15a24-8c6239)

The same approach was used to get the font **04b_30** in css and the [icon](https://api.chucknorris.io/img/favicon.ico)

![Icon image](https://api.chucknorris.io/img/favicon.ico "Icon image")

### Frameworks

Using minimal external frameworks.

- [SwiftLint](https://github.com/realm/SwiftLint) - A tool to enforce Swift style and conventions
- [RxSwift](https://github.com/ReactiveX/RxSwift) - This is a Swift version of Rx. -- As there is a requirement in the challenge to use Reactive programming, it is the best way to use it.

Tests

- [Quick](https://github.com/Quick/Quick) - Quick is a [Behavior-Driven Development (BDD)](https://en.wikipedia.org/wiki/Behavior-driven_development) framework -- It transform the tests in a more human-readable language beyond document the software. It is not a "must have" but nice one to have!
- [Nimble](https://github.com/Quick/Nimble) - Nimble is a matcher framework -- It complements the Quick
- [iOSSnapshot](https://github.com/uber/ios-snapshot-test-case) - iOSSnapshotTestCase was developed to make snapshot tests easy. -- So let's have an easier snapshot test.

### Package Manager

I've seen some challenges asking to use CocoaPods as a package manager.
Simple approach for only few dependencies.
There are tasks to create a branch with Swift Package Manager and Carthage. Mint is not in my mind for now!

### Dependency Injection

As it has only two view controllers and few files of codes, I've decided to implement a DI manually through initializers.

There is a task to use the Swinject in another branch.

### UI

Simple but with Human Interface Guidelines

View Code (thinking it as a portfolio). As it is a mono user repository with only two screens, it could be a storyboard or a xib with no problem!

There is a task to do the same view with SwiftUI

It can't be the default yet. We'll ignore the iPhone 5S + iPhone 6 users at some point...But still not now yet!
And there are a lot of existent apps not using SwiftUI.

#### Images

I've gotten some images by [Icons8]("https://icons8.com")

As it is free, not all could be the PDF versions. I've used whenever it was possible, in other cases it was PNG format.

### TODO

Check out the tasks in [Backlog](https://github.com/GabrielRozendo/ChuckNorris_challenge_iOS/projects)

## How to run

**TL;DR**: run the command in root of repository

```make lets_go```

There is a [makefile](https://en.wikipedia.org/wiki/Makefile) to help in preparation to open the project in the first time.

**You must have Xcode installed** I've been using 11.6

```make brew_install``` installs [brew](https://github.com/Homebrew/brew)

```make cocoapods_install``` installs cocoapods

```make swiftlint_install``` installs swiftlint

```make setup``` installs everything above and install the dependencies (pod install)

```make lets_go``` calls make setup and open the project after that. 


So you can execute any command by hand for now:
- BUILD (CMD+B)
- RUN (CMD+R)
- TEST (CMD+U)
