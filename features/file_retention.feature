Feature: File retention

  In order to retain a copy of all the music files I own
  I want to be sure that I don't delete files that are not exact copies

  Background: 
    Given a directory named "itunes/music"

  Scenario: deleting files that are identical
    Given a file named "itunes/track_1_by_x.mp3" with:
       """
       plinky-plonk
       """
    And a file named "itunes/track_1_by_x 2.mp3" which is a copy of "itunes/track_1_by_x.mp3"
    When I run "dedupe"
    And a file named "itunes/track_1_by_x.mp3" should exist
    And a file named "itunes/track_1_by_x 2.mp3" should not exist


  Scenario: retaining files that are identical except in different directories
    Given a file named "itunes/music/track_1_by_x.mp3" with:
       """
       plinky-plonk
       """
    And a file named "itunes/track_1_by_x 2.mp3" which is a copy of "itunes/music/track_1_by_x.mp3"
    When I run "dedupe"
    And a file named "itunes/music/track_1_by_x.mp3" should exist
    And a file named "itunes/track_1_by_x 2.mp3" should exist

  Scenario: retaining files that are related by file name and size, but have different content
    Given a file named "itunes/track_1_by_x.mp3" with:
       """
       plinky-plonk
       """
       And a file named "itunes/track_1_by_x 2.mp3" with:
       """
       trinky-tronk
       """
    When I run "dedupe"
    And a file named "itunes/track_1_by_x.mp3" should exist
    And a file named "itunes/track_1_by_x 2.mp3" should exist

  Scenario: retaining files that are related by file name, but have different  size
    Given a file named "itunes/track_1_by_x.mp3" with:
       """
       plinky-plonk
       """
       And a file named "itunes/track_1_by_x 2.mp3" with:
       """
       plinky-plonk-bang
       """
    When I run "dedupe"
    And a file named "itunes/track_1_by_x.mp3" should exist
    And a file named "itunes/track_1_by_x 2.mp3" should exist

  Scenario: retain files when they differ by something other than a numeric suffix
    Given a file named "itunes/track_1_by_x.mp3" with:
       """
       plinky-plonk
       """
    And a file named "itunes/track_1_by_x Z.mp3" which is a copy of "itunes/track_1_by_x.mp3"
    When I run "dedupe"
    And a file named "itunes/track_1_by_x.mp3" should exist
    And a file named "itunes/track_1_by_x Z.mp3" should exist

