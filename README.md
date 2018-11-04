# TemplateProject

This repo is created using a [template](https://github.com/SlavkoKrucaj/TemplateProject)

## Template usage

 - clone this `repo`
 - run `./init.sh [PROJECT_NAME]` i.e `./init.sh Test`
 - add remote origin if wanted `git remote add origin [URL]`

## Installation

 - Make sure you have [carthage](https://github.com/Carthage/Carthage) installed
 - once you do run `carthage update --platform iOS`
 - you should be ready to go

## Architecture

  - `Viper` - Sketch out

## Deployment

  - `Fastlane` - TODO

## 3rd Party Libraries

  - `IGListKit`, I used it to drive the collectionViews, this library simplifies a lot of things when it comes to dealing with collectionViews, without a lot of magic. I like using collectionViews as they can be made to drive all of the states easily (initial load, pagination, errors, offline state, empty state). If not for this library my standard thing to do is to write a simple custom layout, which would utilize supplementary views to display states in the collectionView.

  - `RxSwift`, I used it on the boundary from Api -> Presnter. I used it because I derived state from the api itself, and it seems more natural for this pipeline to be a stream of event. If not for this, I would just fallback to using completion handlers.

  - `Carthage`, I used `carthage` for dependency management, just as it's a bit more lightweight than `cocoapods`. In a production environment I would probably opt for `cocoapods` as some of the more used libraries still don't have support for `carthage` and using it involves a bit of trickery.

  - `Swiftlint`, I used it to keep an eye on the style

  - `Quick`, `Nimble`, for testing
