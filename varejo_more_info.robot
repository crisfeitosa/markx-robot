*** Settings ***
Documentation    Mapeamento agnóstico do componente compartilhado Varejo More Info (Benefícios da Conta/Cartão)
Library          AppiumLibrary

*** Variables ***
# ==========================================
# LOCATORS DO COMPONENTE (Agnósticos de texto)
# ==========================================
# Ícone de entrada
${BTN_INFO_I}                accessibility_id=icone_informacao_i

# Modal Principal
${MODAL_VAREJO_MORE_INFO}    accessibility_id=modal_beneficios
${BOTAO_ENTENDI}             accessibility_id=btn_entendi_beneficios
${LINK_DETALHES_CONTA}       accessibility_id=link_detalhes_conta
${LINK_DETALHES_CARTAO}      accessibility_id=link_detalhes_cartao

# Modais de Segundo Nível (Detalhes)
${MODAL_DETALHES_CONTA}      accessibility_id=modal_mais_detalhes_conta
${BTN_FECHAR_X_CONTA}        accessibility_id=botao_fechar_x
${MODAL_DETALHES_CARTAO}     accessibility_id=modal_mais_detalhes_cartao
${BTN_ENTENDI_CARTAO}        accessibility_id=botao_entendi_cartao

*** Keywords ***
# ==========================================
# AÇÕES E VALIDAÇÕES DO COMPONENTE
# ==========================================
Abrir Varejo More Info Pelo Icone
    [Documentation]    Clica no ícone de 'i' para abrir o modal.
    Wait Until Element Is Visible    ${BTN_INFO_I}        timeout=10s
    Click Element                    ${BTN_INFO_I}
    Validar Que Componente Varejo More Info Renderizou

Validar Que Componente Varejo More Info Renderizou
    [Documentation]    Valida se o modal principal carregou pelo ID, ignorando os textos variáveis.
    Wait Until Element Is Visible    ${MODAL_VAREJO_MORE_INFO}    timeout=10s

Clicar Em Entendi No Varejo More Info
    [Documentation]    Clica no botão Entendi e garante que o modal fechou.
    Wait Until Element Is Visible    ${BOTAO_ENTENDI}
    Click Element                    ${BOTAO_ENTENDI}
    Wait Until Element Is Not Visible    ${MODAL_VAREJO_MORE_INFO}    timeout=5s

Abrir Detalhes Da Conta No Varejo More Info
    Wait Until Element Is Visible    ${LINK_DETALHES_CONTA}
    Click Element                    ${LINK_DETALHES_CONTA}
    Wait Until Element Is Visible    ${MODAL_DETALHES_CONTA}      timeout=5s

Fechar Detalhes Da Conta
    Wait Until Element Is Visible    ${BTN_FECHAR_X_CONTA}
    Click Element                    ${BTN_FECHAR_X_CONTA}
    Wait Until Element Is Visible    ${MODAL_VAREJO_MORE_INFO}    timeout=5s

Abrir Detalhes Do Cartao No Varejo More Info
    Wait Until Element Is Visible    ${LINK_DETALHES_CARTAO}
    Click Element                    ${LINK_DETALHES_CARTAO}
    Wait Until Element Is Visible    ${MODAL_DETALHES_CARTAO}     timeout=5s

Fechar Detalhes Do Cartao
    Wait Until Element Is Visible    ${BTN_ENTENDI_CARTAO}
    Click Element                    ${BTN_ENTENDI_CARTAO}
    Wait Until Element Is Visible    ${MODAL_VAREJO_MORE_INFO}    timeout=5s
