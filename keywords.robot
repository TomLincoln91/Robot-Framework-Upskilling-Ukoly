*** Settings ***
Library     Collections
Library     String
Library     SeleniumLibrary
Library     BuiltIn
Library     OperatingSystem
Library     RF
Resource    variables.robot
Resource    credentials.robot


*** Keywords ***

#This test checks if values in given list are in ascending order. Test fails if not.
Check if list is in ascending order
    [Arguments]     ${listvalues}
    [Tags]  Task1
            ${length}   Get Length      ${listvalues}
            ${length}  Evaluate     ${length}-1
    FOR     ${index}   IN RANGE    0     ${length}
            Log    ${listvalues}[${index}]
            ${indexHigh}    Evaluate    ${index}+1
            Should Be True  ${listvalues}[${index}]<${listvalues}[${indexHigh}]
    END

Check if list is in ascending order 2
    [Arguments]     ${listvalues}
    ${task1pass1sorted}     Copy list       ${listvalues}
    Sort List       ${task1pass1sorted}
    Lists should be equal    ${listvalues}  ${task1pass1sorted}

Check if strings in list are the same length
    [Arguments]     ${listvalues}
    ${FirstWord}   Get From List    ${listvalues}   0
    ${expectedLength}   Get Length  ${FirstWord}
    ${ListLength}      Get Length      ${listvalues}
        FOR  ${index}    IN RANGE     0    ${ListLength}
             ${ListElement}   Get From List    ${listvalues}   ${index}
             ${ElementLength}    Get Length  ${ListElement}
             Should Be True   ${ElementLength}==${expectedLength}
        END

Open GitHub page
    Set Screenshot directory   Screenshots
    Open Browser  https://github.com/login   browser=chrome
Login to GitHub account
    wait until element is visible  ${login_field}
    click element   ${login_field}
    input text    ${login_field}    ${Email}
    input password  ${password_field}  ${password}
    click element  ${login_button}
Create new private repository
    wait until element is visible  ${new_repo}
    click element  ${new_repo}
    wait until element is visible  id:repository_name
    input text  id:repository_name      ${rep_name}
    click element   id:repository_visibility_private
    scroll element into view  //button[@class='btn-primary btn']
    Wait Until Element Is Enabled    ${new_repo_button}
    click element  ${new_repo_button}
Verify that created repository is in list of repositories
    wait until element is visible  //a[.='${github_acc}']
    click element  ${navbar_dropdown}
    wait until element is visible  //a[.='Your repositories']
    click element  //a[.='Your repositories']
    Wait until element is visible   //*[@id="your-repos-filter"]
    input text  //*[@id="your-repos-filter"]      ${rep_name}
    ${rep_list}     Get Text    ${rep_list}
    Should Be Equal    ${rep_list}  ${rep_name}
Verify that created repository is not visible when not logged in
    click element  ${navbar_dropdown}
    wait until element is visible  ${sign_out_button}
    click element  ${sign_out_button}
    Go To       https://github.com/${github_acc}?tab=repositories
    input text  //*[@id="your-repos-filter"]      ${rep_name}
    Wait until element is visible    ${num_of_reps}
    ${num_of_reps}    Get Text        ${num_of_reps}
    Should Be True    ${num_of_reps} == 0
Change repository from private to public
    click element     ${sign_in_button}
    wait until element is visible  ${login_field}
    input text    ${login_field}    ${Email}
    input password  ${password_field}  ${password}
    click element  ${login_button}
    Wait until element is visible   //*[@id="your-repos-filter"]
    input text  //*[@id="your-repos-filter"]      ${rep_name}
    click element     ${first_searched_repo}
    wait until element is visible     //*[@id="settings-tab"]
    click element     //*[@id="settings-tab"]
    Wait until element is visible     ${change_visibility_button}
    click element     ${change_visibility_button}
    Click element     ${to_public_button}
    Wait until element is visible     ${verify_publication}
    click element    ${verify_publication}
    wait until element is visible     ${second_verify_publication}
    click element    ${second_verify_publication}
Verify that the repository is visible when not logged in
    click element  ${navbar_dropdown}
    wait until element is visible  ${sign_out_button}
    click element  ${sign_out_button}
    Go To       https://github.com/${github_acc}?tab=repositories
    input text  //*[@id="your-repos-filter"]      ${rep_name}
    FOR     ${i}    IN RANGE     6
        Press Keys    //*[@id="your-repos-filter"]    ENTER
    END
    Wait until element is visible    ${num_of_reps}
    ${num_of_reps}    Get Text        ${num_of_reps}
    Should Be True    ${num_of_reps} == 1
Delete the repository
    click element  ${sign_in_button}
    wait until element is visible  ${login_field}
    input text    ${login_field}    ${Email}
    input password  ${password_field}   ${password}
    click element  ${login_button}
    Wait until element is visible   //*[@id="your-repos-filter"]
    input text  //*[@id="your-repos-filter"]      ${rep_name}
    click element     ${first_searched_repo}
    wait until element is visible     //*[@id="settings-tab"]
    click element     //*[@id="settings-tab"]
    Wait until element is visible     ${delete_repo_button}
    Click element     ${delete_repo_button}
    wait until element is visible     ${verify_deletion_form}
    Input Text    ${verify_deletion_form}    ${github_acc}/${rep_name}
    Wait until element is visible     ${verify_deletion_button}
    Click Element     ${verify_deletion_button}
Verify that the repository is deleted
    Wait until element is visible   //*[@id="your-repos-filter"]
    input text  //*[@id="your-repos-filter"]      ${rep_name}
    Wait until element is visible    ${num_of_reps}
    ${num_of_reps}    Get Text        ${num_of_reps}
    Should Be True    ${num_of_reps} == 0


Task4
    ${test}=    get csv rows    ${CSV_LOCATION}
    ${EXPECTED_LINES_INTEGER}   Convert to integer  ${EXPECTED_LINES}
    Should Be Equal    ${test}    ${EXPECTED_LINES_INTEGER}

Task5
    ${load_json}=    Get File    ${json}
        ${json}=  Evaluate  json.loads('''${load_json}''')  json
        Log     ${json["test_type"]}
        ${input_type}=  Set Variable     ${json["test_type"]}
        Log     ${json["input"]}
        ${input_list}=  Set Variable     ${json["input"]}

    IF     "${input_type}" == "asc"
        ${input_list_sorted}     Copy list       ${input_list}
        Sort List       ${input_list_sorted}
        Lists should be equal    ${input_list}   ${input_list_sorted}
    ELSE IF    "${input_type}" == "desc"
        ${input_list_sorted}     Copy list       ${input_list}
        Sort List       ${input_list_sorted}
        Reverse List    ${input_list_sorted}
        Log             ${input_list_sorted}
        Lists should be equal    ${input_list}   ${input_list_sorted}
    ELSE
        Log    Bad JSON file
    END