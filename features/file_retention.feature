Feature: File retention

  In order to retain a copy of all the music files I own
  I want to be sure that I don't delete files that are not exact copies

  Background: 
    Given a directory named "itunes/music"

  Scenario: deleting files that are identical
    Given a music file
    And a copy of that named with a numeric suffix
    When I run "dedupe"
    Then the music file should exist
    And the other file should not exist

  Scenario: retaining files that are identical except in different directories
    Given a music file
    And a copy of that named with a numeric suffix in a subdirectory
    When I run "dedupe"
    Then the music file should exist
    And the other file should exist

  Scenario: retaining files that are related by file name and size, but have different content
    Given a music file
    And a copy of that named with a numeric suffix but with different content
    When I run "dedupe"
    Then the music file should exist
    And the other file should exist

  Scenario: retaining files that are related by file name, but have different  size
    Given a music file
    And a copy of that named with a numeric suffix but with different size
    When I run "dedupe"
    Then the music file should exist
    And the other file should exist

  Scenario: retain files when they differ by something other than a numeric suffix
    Given a music file
    And a copy of that named with a non-numeric suffix
    When I run "dedupe"
    Then the music file should exist
    And the other file should exist

