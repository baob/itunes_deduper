Feature: file deletion

  In order to clean up extraneous files in my iTunes folders
  I want to delete files that are identical apart from an appended number

  Background: 
    Given a directory named "itunes_features"
    And I cd to "itunes_features"

  Scenario: deleting in root directory
    Given a music file in the root directory
    And a copy of that named with a numeric suffix
    When I run "dedupe"
    Then the stderr should be empty
    And the music file should exist
    And the other file should not exist

  Scenario: deleting in sub directory
    Given a music file
    And a copy of that named with a numeric suffix
    When I run "dedupe"
    Then the stderr should be empty
    And the music file should exist
    And the other file should not exist

  Scenario: deleting in deep sub directory
    Given a music file in a deep sub directory
    And a copy of that named with a numeric suffix
    When I run "dedupe"
    Then the stderr should be empty
    And the music file should exist
    And the other file should not exist


