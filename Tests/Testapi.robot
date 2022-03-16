*** Settings ***
Library  SeleniumLibrary
Library  RequestsLibrary
Library  JSONLibrary
Library  Collections

*** Variables ***
${base_url}  https://datausa.io/api/
${city}  Alabama

*** Test Cases ***
Get_apicallPass
        create session  myssion  ${base_url}  verify=true
        ${response}=  get request  myssion  data?drilldowns=State&measures=Population&year=latest
        log to console  ${response.status_code}

        #check status code
        ${status}=  convert to string  ${response.status_code}
        should be equal  ${status}  200

        ${status}=  convert to string  ${response.status_code}
        should not be equal  ${status}  400

        #check body contains value
        ${body}=  convert to string  ${response.content}
        should contain  ${body}  ${city}

        #check content-type
        ${content-typevalue}=  get from dictionary  ${response.headers}  Content-Type
        should be equal  ${content-typevalue}  application/json; charset=utf-8

        #Check Title as London from Response Body
        #${the data}=    Evaluate    json.loads(${response.content})    json
        #log to console  ${the data}


*** Keywords ***

