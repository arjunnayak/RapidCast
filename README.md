# RapidCast

Rapidcast is an iOS app that generates a playlist of podcasts specific to your tastes. After a little intial setup, Rapidcast will run a smart algorithm to deliver popular and recent iTunes content.

- Current features
  - Allows user to select desired categories
  - Auto-generates a playlist with the tap of a button
  - Allows user to stream straight from the phone

- Moving forward 
  - 1.0 Release
    - Improve/refine algorithm (speed and consistent results): (crucial)
      - consider new xml parser
      - consider AFNetworking for network management
    - Storage Decisions:
      - <del> store categories in nsuserdefaults (crucial)
      - <del> remove realm (crucial)
      - consider core data/Realm for persistent podcast storage
        - store most recent generated playlist (crucial)
  - Podcast playing:
    - switch to StreamingKit (https://github.com/tumtumtum/StreamingKit)
      - Allow for playing in background (crucial)
      - persistent audio controls throughout app (crucial)
        - scrubber 
        - add and remove 15/30 seconds (crucial)

  - 1.5 Update
    - Storage & Algorithm: 
      - consider holding references to podcasts already seen by user (storage AND algorithm side)
    - Podcast playing:
      - possible speed changing? (1.5x, 2x)
  - Other features:
    - Notifications
    - Scrollable text (for long titles)
