*** Settings ***

Documentation
...    A test suite for validating UE Location Lookup (UELOCLOOK) operations.

Resource    ../../GenericKeywords.robot

Default Tags    TP_MEC_SRV_UELOCLOOK


*** Variables ***


*** Test Cases ***

TP_MEC_SRV_UELOCLOOK_001_OK
    [Documentation]
    ...    Check that the IUT responds with a list for the location of User Equipments
    ...    when queried by a MEC Application
    ...
    ...    Reference    ETSI GS MEC 013 V2.1.1, clause 7.3.2
    ...    OpenAPI    https://forge.etsi.org/gitlab/mec/gs013-location-api/blob/master/LocationAPI.yaml#/definitions/UserInfo

    [Tags]    PIC_MEC_PLAT    PIC_SERVICES

    vGET    /${PX_UE_LOC_USERS_URI}?zoneId=${UE_LOC_ZONE_ID}
    Check HTTP Response Status Code Is    200
    Check HTTP Response Body Json Schema Is    userInfo
    Check Result Contains    ${response['body']['userInfo']}    zoneId    ${UE_LOC_ZONE_ID}


TP_MEC_SRV_UELOCLOOK_001_BR
    [Documentation]
    ...    Check that the IUT responds with an error when
    ...    a request with incorrect parameters is sent by a MEC Application
    ...
    ...    Reference    ETSI GS MEC 013 V2.1.1, clause 7.3.2

    [Tags]    PIC_MEC_PLAT    PIC_SERVICES

    vGET    /${PX_UE_LOC_USERS_URI}?zone=${UE_LOC_ZONE_ID}
    Check HTTP Response Status Code Is    400


TP_MEC_SRV_UELOCLOOK_001_NF
    [Documentation]
    ...    Check that the IUT responds with an error when
    ...    a request for an unknown URI is sent by a MEC Application
    ...
    ...    Reference    ETSI GS MEC 013 V2.1.1, clause 7.3.2

    [Tags]    PIC_MEC_PLAT    PIC_SERVICES

    vGET    /${PX_UE_LOC_USERS_URI}?zoneId=${NON_EXISTENT_ZONE_ID}
    Check HTTP Response Status Code Is    404
