*** Settings ***
Library  SeleniumLibrary
Library  RequestsLibrary
Library  JSONLibrary
Library  Collections
Library  String
Library  os

*** Variables ***
${base_url}  https://reqres.in/

*** Test Cases ***
Get_apicallPass
        create session  myssion  ${base_url}  disable_warnings=1
        ${response}=  get request  myssion  /api/users?page=2
        log to console  ${response.status_code}

        #check status code
        ${status}=  convert to string  ${response.status_code}
        should be equal  ${status}  404

Post_apicallPass
        create session  myssion  ${base_url}  disable_warnings=1
        ${body}=  create dictionary   id=697
        ${headers}=  create dictionary  content_type=Application/json
        ${response}=  post request  myssion  /api/users?page=2  data=${body}  headers=${headers}
        log to console  ${response.status_code}

Get value from json
        create session  myssion  ${base_url}  disable_warnings=1
        ${response}=  get request  myssion  /api/users?page=2
        ${json}=  get value from json  ${response}  $.data[0].first_name  #$.page
        log to console  ${json}
        should not be equal  ${json}  Michael



*** Keywords ***

