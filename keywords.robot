*** Settings ***
Library     Collections
Library     String
Library     SeleniumLibrary
Library     BuiltIn
Resource    variables.robot
Resource    credentials.robot


*** Keywords ***

Check if list is in ascending order
    [Tags]    Task1
            ${length}   Get Length      ${task1pass1}
            ${length}  Evaluate     ${length}-1
    FOR     ${index}   IN RANGE    0     ${length}
            Log    ${task1pass1}[${index}]
            ${indexHigh}    Evaluate    ${index}+1
            Should Be True  ${task1pass1}[${index}]<${task1pass1}[${indexHigh}]
    END

Check if list is in ascending order 2
    ${task1pass1sorted}     Copy list       ${task1pass1}
    Sort List       ${task1pass1sorted}
    Lists should be equal    ${task1pass1}   ${task1pass1sorted}

Check if strings in list are the same length
    ${FirstWord}   Get From List    ${task2pass}   0
    ${expectedLength}   Get Length  ${FirstWord}
    ${ListLength}      Get Length      ${task2pass}
        FOR  ${index}    IN RANGE     0    ${ListLength}
             ${ListElement}   Get From List    ${task2pass}   ${index}
             ${ElementLength}    Get Length  ${ListElement}
             Should Be True   ${ElementLength}==${expectedLength}
        END

Open GitHub page
    Set Screenshot directory   Screenshots
    Open Browser  https://github.com/login   browser=chrome
Login to GitHub account
#   wait until element is visible   //div[@class='d-lg-flex flex-items-center px-3 px-lg-0 mb-3 mb-lg-0 text-center text-lg-left']/a[contains(.,'Sign up')]
#   click element   //div[@class='d-lg-flex flex-items-center px-3 px-lg-0 mb-3 mb-lg-0 text-center text-lg-left']/a[contains(.,'Sign up')]
#   wait until element is visible  //a[contains(.,'Sign in →')]
#   click element  //a[contains(.,'Sign in →')]
    wait until element is visible  ${login_field}
    click element   ${login_field}
    input text    ${login_field}    ${Email}
    click element  id:password
    input password  id:password  ${password}
    click element  //input[@name='commit']
Create new private repository
    wait until element is visible  //loading-context[@class='loading-context position-relative height-full']//a[contains(.,'New')]
    click element  //loading-context[@class='loading-context position-relative height-full']//a[contains(.,'New')]
    wait until element is visible  id:repository_name
    click element  id:repository_name
    input text  id:repository_name      ${rep_name}[0]
    click element   id:repository_visibility_private
    scroll element into view  //button[@class='btn-primary btn']
    # Sleep   0.5
    click element  //*[@id="new_repository"]/div[5]/button
Verify that created repository is in list of repositories
    wait until element is visible  //a[.='${github_acc}[0]']
    click element  //details[@class='details-overlay details-reset js-feature-preview-indicator-container']/summary[@class='Header-link']
    wait until element is visible  //a[.='Your repositories']
    # Sleep   0.5
    click element  //a[.='Your repositories']
    Wait until element is visible   //*[@id="your-repos-filter"]
    input text  //*[@id="your-repos-filter"]      ${rep_name}[0]
    ${rep_list}     Get Text    ${rep_list}
    Should Be Equal    ${rep_list}  ${rep_name}[0]  
Verify that created repository is not visible when not logged in
    click element  //details[@class='details-overlay details-reset js-feature-preview-indicator-container']/summary[@class='Header-link']
    wait until element is visible  //*[contains(text(),'Sign out')]
    # Sleep   0.5
    click element  //*[contains(text(),'Sign out')]
    Go To       https://github.com/${github_acc}[0]?tab=repositories
    input text  //*[@id="your-repos-filter"]      ${rep_name}[0]
    Wait until element is visible    ${num_of_reps}   
    ${num_of_reps}    Get Text        ${num_of_reps}    
    Should Be True    ${num_of_reps} == 0
Change repository from previous test to public
    click element  //*[contains(text(),'Sign in')]
    wait until element is visible  ${login_field}
    click element   ${login_field}
    input text    ${login_field}    ${Email}
    click element  id:password
    input password  id:password  ${password}
    click element  //input[@name='commit']
    Wait until element is visible   //*[@id="your-repos-filter"]
    input text  //*[@id="your-repos-filter"]      ${rep_name}[0]
    click element     //*[@id="user-repositories-list"]/ul/li/div[1]/div[1]/h3/a
    wait until element is visible     //*[@id="settings-tab"]
    click element     //*[@id="settings-tab"]
    Wait until element is visible     //*[@id="options_bucket"]/div[9]/ul/li[1]/div[1]/details/summary
    click element     //*[@id="options_bucket"]/div[9]/ul/li[1]/div[1]/details/summary
    Click element     //*[@class="dropdown-item js-repo-change-visibility-button btn-link"]
    Wait until element is visible     //*[@id="repo-visibility-proceed-button-public"]
    click element     //*[@id="repo-visibility-proceed-button-public"]
    wait until element is visible     //*[@id="repo-visibility-proceed-button-public"]/span/span
    click element     //*[@id="repo-visibility-proceed-button-public"]/span/span
    wait until element is visible     //*[@id="repo-visibility-proceed-button-public"]/span/span
    click element     //*[@id="repo-visibility-proceed-button-public"]/span/span
Verify that the repository is visible when not logged in
    click element  //details[@class='details-overlay details-reset js-feature-preview-indicator-container']/summary[@class='Header-link']
    wait until element is visible  //*[contains(text(),'Sign out')]
    # Sleep   0.5
    click element  //*[contains(text(),'Sign out')]
    Go To       https://github.com/${github_acc}[0]?tab=repositories
    input text  //*[@id="your-repos-filter"]      ${rep_name}[0]
    # Sleep    0.5
    FOR     ${i}    IN RANGE     6
        Press Keys    //*[@id="your-repos-filter"]    ENTER
    END
    Wait until element is visible    ${num_of_reps} 
    ${num_of_reps}    Get Text        ${num_of_reps}    
    Should Be True    ${num_of_reps} == 1
Delete the repository
    click element  //*[contains(text(),'Sign in')]
    wait until element is visible  ${login_field}
    click element   ${login_field}
    input text    ${login_field}    ${Email}
    click element  id:password
    input password  id:password  ${password}
    click element  //input[@name='commit']
    Wait until element is visible   //*[@id="your-repos-filter"]
    input text  //*[@id="your-repos-filter"]      ${rep_name}[0]
    click element     //*[@id="user-repositories-list"]/ul/li/div[1]/div[1]/h3/a
    wait until element is visible     //*[@id="settings-tab"]
    click element     //*[@id="settings-tab"]
    Wait until element is visible     //*[@id="options_bucket"]/div[9]/ul/li[4]/details/summary
    Click element     //*[@id="options_bucket"]/div[9]/ul/li[4]/details/summary
    wait until element is visible     //*[@id="options_bucket"]/div[9]/ul/li[4]/details/details-dialog/div[3]/form/p/input
    Input Text     //*[@id="options_bucket"]/div[9]/ul/li[4]/details/details-dialog/div[3]/form/p/input    ${github_acc}[0]/${rep_name}[0]
    Wait until element is visible     //*[@id="options_bucket"]/div[9]/ul/li[4]/details/details-dialog/div[3]/form/button/span[1]
    Click Element     //*[@id="options_bucket"]/div[9]/ul/li[4]/details/details-dialog/div[3]/form/button/span[1]
Verify that the repository is deleted
    Wait until element is visible   //*[@id="your-repos-filter"]
    input text  //*[@id="your-repos-filter"]      ${rep_name}[0]
    Wait until element is visible    ${num_of_reps} 
    ${num_of_reps}    Get Text        ${num_of_reps}    
    Should Be True    ${num_of_reps} == 0