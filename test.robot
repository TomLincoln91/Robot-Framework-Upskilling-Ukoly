*** Settings ***
Resource    keywords.robot

*** Test Cases ***
Check if list is in ascending order
    [Tags]  Task1
        Check if list is in ascending order     ${task1pass1}

Check if list is in ascending order 2
    [Tags]  Task1Alternative
        Check if list is in ascending order 2   ${task1pass1}

Check if strings in list are the same length
    [Tags]  Task2
        Check if strings in list are the same length    ${task2pass}

GitHub
    [Tags]  Task3
    Open GitHub page
    Login to GitHub account
    Create new private repository
    Verify that created repository is in list of repositories
    Verify that created repository is not visible when not logged in
    Change repository from previous test to public
    Verify that the repository is visible when not logged in
    Delete the repository
    Verify that the repository is deleted

Using custom RF library to validate contents of a file
    [Tags]  Task4
    Task4

Test script template, that uses data file as its configuration
    [Tags]  Task5
    Task5
