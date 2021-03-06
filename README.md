# RapidCast

Rapidcast is an iOS app that generates a playlist of podcasts specific to your tastes. After little intial setup, Rapidcast will run a smart algorithm to generate a playlist for you filled with popular and recent iTunes content to stream.

- Current features
  - Allows user to select desired categories
  - Auto-generates a playlist with the tap of a button
  - Allows user to stream straight from the phone

- 1.0 Release
  - Improve/refine algorithm:
    - Optimizations: (speed and consistent results) 
      - <del>consider new xml parser</del>  [ONO]
      - <del>work from xml parsing algorithm
      - <del>caching images
      - Figure out best possible way to make the http requests
    - Conceptual Improvements:
      - Give something better than just the most recent podcast
  - Podcast playing:
    - Background audio
    - 15/30 seconds 
    - Scrubber 
    - <del>Automatic scrolling for long titles
  - Storage Decisions:
    - <del>store categories in nsuserdefaults 
    - <del>remove realm 
    - Realm for persistent podcast storage
      - store most recent generated playlist 
      - trimming image for storage
  - New Features
  	- utilize more specific genres 
  		- requires testing of new genres in search api
  		- come up with new UI (expandable table view?)
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

Logs
1. [4/8/16] HUGE Bug (still in testing): when generating random integers (used to be 1 - 25) to pick from list of "top 25" from each category, sometimes we wouldn't even receive 25 podcast channels; the random integer would be larger than the actual list, thus giving us an empty lookupID.
2. [4/10/16] Heavily refined xml parsing algorithm with ONO parser! XML Parsing speeds improved the entire playlist generation process from an average of ~15 seconds to ~5 seconds!
