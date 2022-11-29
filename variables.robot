*** Settings ***
Resource    credentials.robot

*** Variables ***

#Task1
@{task1pass1}   1  2  3  4  5
@{task1pass2}   -1  0  3.25  200  4568382
@{task1fail}    1  2  3  4  -5

@{task2pass}       slovo  zebra  listy  lvice  strom  slovo
@{task2fail}        malina  seno  list  mist

#Task2
${login_field}       //*[@id="login_field"]
${password_field}     //*[@id="password"]
${rep_name}    RobotFrameworkTestName2
${rep_list}     //*[@id='user-repositories-list']/ul/li/div[1]/div[1]/h3/a
${github_acc}     jholaj
${num_of_reps}  //*[@id="user-repositories-list"]/div[1]/div[1]/strong[1]

#fields
${new_repo}        //loading-context[@class='loading-context position-relative height-full']//a[contains(.,'New')]
${new_repo_button}  //*[@id="new_repository"]/div[5]/button
${navbar_dropdown}  //details[@class='details-overlay details-reset js-feature-preview-indicator-container']/summary[@class='Header-link']
${sign_out_button}    //*[contains(text(),'Sign out')]
${sign_in_button}    //*[contains(text(),'Sign in')]
${login_button}               //input[@name='commit']
${first_searched_repo}    //*[@id="user-repositories-list"]/ul/li/div[1]/div[1]/h3/a
${delete_repo_button}       //*[@id="options_bucket"]/div[9]/ul/li[4]/details/summary
${verify_deletion_form}    //*[@id="options_bucket"]/div[9]/ul/li[4]/details/details-dialog/div[3]/form/p/input
${verify_deletion_button}  //*[@id="options_bucket"]/div[9]/ul/li[4]/details/details-dialog/div[3]/form/button/span[1]
${change_visibility_button}    //*[@id="options_bucket"]/div[9]/ul/li[1]/div[1]/details/summary
${to_public_button}        //*[@class="dropdown-item js-repo-change-visibility-button btn-link"]
${verify_publication}       //*[@id="repo-visibility-proceed-button-public"]
${second_verify_publication}    //*[@id="repo-visibility-proceed-button-public"]/span/span

#Task4
${test}=                 0
${CSV_LOCATION}=        deniro.csv
${EXPECTED_LINES}=       89

#Task5
${json}=      EXAMPLE2.json



