*** Settings ***
Library  SeleniumLibrary  timeout=40s  run_on_failure=Capture Page Screenshot
*** Variables ***
${URL}   https://caduh.cetip.com.br/
${BROWSER}      chrome
${HEADLESS}   add_argument("--headless")
${NO_SANDBOX}  add_argument("--no-sandbox")
${DISABLE_DEV}  add_argument("--disable-dev-shm-usage") 
${TITLE}   Yaman - Consultoria ágil em engenharia e qualidade de software
${BTN_FECHAR_POPUP}   xpath=//*[@id="announcement-popup"]/div[2]/button

*** Test Cases ***
Cenário 01: Validar o titulo da pagina Yaman
    Iniciar a Sessão
    Validar titulo
    Encerrar sessão

Cenário 2: Validar o titulo da pagina Yaman
    Iniciar a Sessão
    Validar titulo diferente
    Encerrar sessão

*** Keywords ***
Iniciar a Sessão
    Open Browser  ${URL}  ${BROWSER}  options=${HEADLESS}; ${NO_SANDBOX}; ${DISABLE_DEV}
    Maximize Browser Window

Validar titulo
    Title Should Be  ${TITLE}
    Wait Until Element Is Enabled  ${BTN_FECHAR_POPUP} 30s
    Click Element  ${BTN_FECHAR_POPUP}
    Wait Until Element Is Not Visible  ${BTN_FECHAR_POPUP} 2s

Validar titulo diferente
    Title Should be  ${TITLE}s1111

Encerrar sessão
    Close Browser
