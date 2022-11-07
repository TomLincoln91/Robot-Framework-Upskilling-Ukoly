*** Settings ***
Resource  credentials.robot

*** Variables ***

@{task1pass1}   1  2  3  4  5
@{task1pass2}   -1  0  3.25  200  4568382
@{task1fail}    1  2  3  4  -5

@{task2pass}       slovo  zebra  listy  lvice  strom  slovo
@{task2fail}        malina  seno  list  mist

###########################################################
@{login_field}       //*[@id="login_field"]

@{rep_name}    RobotFrameworkTestName1
@{rep_list}     //*[@id='user-repositories-list']/ul/li/div[1]/div[1]/h3/a
@{github_acc}     TomLincoln91
@{num_of_reps}  //*[@id="user-repositories-list"]/div[1]/div[1]/strong[1]



#${value1}   1
#${value2}   2
#${value3}   3
#${value4}   4
#${value5}   5

