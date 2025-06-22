*** Settings ***
Library    SeleniumLibrary
#Resource    youtubeResource.resource
Suite Setup    Open YouTube
Suite Teardown    Close Browser

*** Variables ***
${URL}           https://www.youtube.com
${BROWSER}       chrome
${SearchFor}     Happy birthday sing by Pranjal

*** Test Cases ***
Youtube
    [Tags]    PlayVideo
    Open YouTube                                                    #User defined Keywords
    Wait Until Element Is Visible    name=search_query      10      #Explicit/Dynamic Wait
    Search for Video                                                #Searching for the content
    #Storing video title into element variable
    ${elements}=    Get WebElements    id=video-title
    #Storing the element into list elements
    FOR    ${element}    IN    @{elements}
        ${title}=    Get Text    ${element}
        Wait Until Element Is Visible    ${element}
        Click Element    ${element}
        Sleep       5                                               #Static Wait
        Exit For Loop
    END
    Sleep    5
    Close Browser


*** Keywords ***
Open YouTube
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window

Search for Video
    Input Text      name=search_query      ${SearchFor}
    Press Keys    name=search_query      RETURN
    Wait Until Page Contains Element    id=video-title