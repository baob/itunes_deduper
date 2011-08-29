Feature: file deletion

  In order to clean up extraneous files in my iTunes folders
  I want to delete files that are identical apart from an appended number
  So that I save disk space

  Background: 
    Given a directory named "itunes_features"
    And I cd to "itunes_features"

  @puts-dir
  @puts-cmd
  @puts-env
  Scenario: deleteing in root directory
    Given a file named "itunes_features/track_1_by_x.mp3" with:
       """
       plinky-plonk
       """
    And a file named "itunes_features/track_1_by_x 2.mp3" with:
       """
       plinky-plonk
       """
    When I run "dedupe"
    Then the stderr should be empty
    Then a file named "itunes_features/track_1_by_x.mp3" should exist
    And a file named "itunes_features/track_1_by_x 2.mp3" should not exist


