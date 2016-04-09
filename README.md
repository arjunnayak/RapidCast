# RapidCast

Rapidcast is an iOS app that generates a playlist of podcasts specific to your tastes. After little intial setup, Rapidcast will run a smart algorithm to generate a playlist for you filled with popular and recent iTunes content to stream.

- Current features
  - Allows user to select desired categories
  - Auto-generates a playlist with the tap of a button
  - Allows user to stream straight from the phone

- 1.0 Release
  - Improve/refine algorithm (speed and consistent results): 
    - consider new xml parser or stick with existing one
    - work from xml parsing outwards
    - work on architecture after the smaller pieces are optimized
    - consider AFNetworking for network request management
  - Podcast playing:
    - switch to StreamingKit (https://github.com/tumtumtum/StreamingKit)
      - Allow for playing in background 
      - persistent audio controls throughout app 
        - scrubber 
        - add and remove 15/30 seconds 
  - Storage Decisions:
    - <del> store categories in nsuserdefaults 
    - <del> remove realm 
    - consider core data/Realm for persistent podcast storage
      - store most recent generated playlist 
    - look at options for trimming and caching images
  - New Features
    - allow users to "star" podcasts channels to select and listen
    - give both the ability to pull from favorited channels or random channels

- 1.5 Update
  - Storage & Algorithm: 
    - consider holding references to podcasts already seen by user (storage AND algorithm side)
  - Podcast playing:
    - possible speed changing? (1.5x, 2x)
  - full searching functionality (heavily using query API)
  - Podcast library-like feel for ultimate browsing
- Other features:
  - Notifications
  - Scrollable text (for long podcast titles titles)


Some Notes


1. [4/8/16] HUGE Bug (still in testing): when generating random integers (used to be 1 - 25) to pick from list of "top 25" from each category, sometimes we wouldn't even receive 25 podcast channels; the random integer would be larger than the actual list, thus giving us an empty lookupID.
