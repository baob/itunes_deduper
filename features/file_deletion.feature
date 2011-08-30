Feature: file deletion

  In order to clean up extraneous files in my iTunes folders
  I want to delete files that are identical apart from an appended number

  Background: 
    Given a directory named "itunes_features"
    And I cd to "itunes_features"

  Scenario: deleting in root directory
    Given a file named "track_1_by_x.mp3" with:
       """
       plinky-plonk
       """
    And a file named "track_1_by_x 2.mp3" which is a copy of "track_1_by_x.mp3"
    When I run "dedupe"
    Then the stderr should be empty
    And a file named "track_1_by_x.mp3" should exist
    And a file named "track_1_by_x 2.mp3" should not exist

  Scenario: deleting in sub directory
    Given a file named "sub/track_1_by_x.mp3" with:
       """
       plinky-plonk
       """
    And a file named "sub/track_1_by_x 2.mp3" which is a copy of "sub/track_1_by_x.mp3"
    When I run "dedupe"
    Then the stderr should be empty
    And a file named "sub/track_1_by_x.mp3" should exist
    And a file named "sub/track_1_by_x 2.mp3" should not exist

  Scenario: deleting in deep sub directory
    Given a file named "sub1/sub2/sub3/sub4/track_1_by_x.mp3" with:
       """
       plinky-plonk
       """
    And a file named "sub1/sub2/sub3/sub4/track_1_by_x 2.mp3" which is a copy of "sub1/sub2/sub3/sub4/track_1_by_x.mp3"
    When I run "dedupe"
    Then the stderr should be empty
    And a file named "sub1/sub2/sub3/sub4/track_1_by_x.mp3" should exist
    And a file named "sub1/sub2/sub3/sub4/track_1_by_x 2.mp3" should not exist


