# RapidCast

Rapidcast is an iOS app that generates a playlist of podcasts specific to your tastes. After a little intial setup, Rapidcast will run a smart algorithm to deliver popular and recent iTunes content.

- Current features
  - Allows user to select desired categories
  - Auto-generates a playlist with the tap of a button
  - Allows user to stream straight from the phone
  
- Moving forward 
  - Improve/refine algorithm (speed and consistent results): (crucial)
    - consider new xml parser
    - consider AFNetworking for network management
    - consider holding references to podcasts already seen by user (algorithm side)
  - Storage Decisions:
    - <del> store categories in nsuserdefaults (crucial)
    - <del> remove realm (crucial)
    - consider core data for persistent podcast storage
      - allows for playing of podcasts previous generated (crucial)
    - consider holding references to podcasts already seen by user (storage side)
  - Podcast playing:
    - consider new streaming library
    - Allow for playing in background (crucial)
    - persistent audio controls throughout app
    - scrubber (alternative: add and remove 15/30 seconds) (crucial)
    - possible speed changing? (1.5x, 2x)
  - Other features:
    - Notifications
    - Scrollable text (for long titles)
