*** Settings ***
Documentation    Mapeamento agnóstico do componente compartilhado Varejo More Info (Benefícios da Conta/Cartão)
Library          AppiumLibrary

*** Variables ***
# ==========================================
# LOCATORS DO COMPONENTE (O Modal)
# ==========================================
${MODAL_VAREJO_MORE_INFO}    accessibility_id=modal_beneficios
${BOTAO_ENTENDI}             accessibility_id=btn_entendi_beneficios

# Links de detalhes
${LINK_DETALHES_CONTA}       accessibility_id=link_detalhes_conta
${LINK_DETALHES_CARTAO}      accessibility_id=link_detalhes_cartao

# Modais de segundo nível
${MODAL_DETALHES_CONTA}      accessibility_id=modal_mais_detalhes_conta
${BTN_FECHAR_X_CONTA}        accessibility_id=botao_fechar_x
${MODAL_DETALHES_CARTAO}     accessibility_id=modal_mais_detalhes_cartao
${BTN_ENTENDI_CARTAO}        accessibility_id=botao_entendi_cartao

*** Keywords ***
# ==========================================
# AÇÕES DO COMPONENTE
# ==========================================
Validar Que O Modal More Info Abriu
    [Documentation]    Apenas valida se o componente foi renderizado na tela.
    Wait Until Element Is Visible    ${MODAL_VAREJO_MORE_INFO}    timeout=10s

Clicar Em Entendi No Varejo More Info
    Wait Until Element Is Visible    ${BOTAO_ENTENDI}     timeout=5s
    Click Element                    ${BOTAO_ENTENDI}
    Wait Until Element Is Not Visible    ${MODAL_VAREJO_MORE_INFO}    timeout=5s

Abrir Detalhes Da Conta No Varejo More Info
    Wait Until Element Is Visible    ${LINK_DETALHES_CONTA}       timeout=5s
    Click Element                    ${LINK_DETALHES_CONTA}
    Wait Until Element Is Visible    ${MODAL_DETALHES_CONTA}      timeout=5s

Fechar Detalhes Da Conta
    Wait Until Element Is Visible    ${BTN_FECHAR_X_CONTA}        timeout=5s
    Click Element                    ${BTN_FECHAR_X_CONTA}
    Wait Until Element Is Visible    ${MODAL_VAREJO_MORE_INFO}    timeout=5s

Abrir Detalhes Do Cartao No Varejo More Info
    Wait Until Element Is Visible    ${LINK_DETALHES_CARTAO}      timeout=5s
    Click Element                    ${LINK_DETALHES_CARTAO}
    Wait Until Element Is Visible    ${MODAL_DETALHES_CARTAO}     timeout=5s

Fechar Detalhes Do Cartao
    Wait Until Element Is Visible    ${BTN_ENTENDI_CARTAO}        timeout=5s
    Click Element                    ${BTN_ENTENDI_CARTAO}
    Wait Until Element Is Visible    ${MODAL_VAREJO_MORE_INFO}    timeout=5s
