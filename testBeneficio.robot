*** Settings ***
Documentation    Testes E2E da Jornada de Consignado - Experiência: Consignado Varejo (Modais de Benefícios)
Library          AppiumLibrary

# Aplica estas tags automaticamente a TODOS os testes deste arquivo
Force Tags       jornada:consignado    experiencia:consignado-varejo   

*** Variables ***
# ==========================================
# LOCATORS (Webview)
# ==========================================

# --- Tela Inicial de Oferta ---
${BTN_INFO_I}                   accessibility_id=icone_informacao_i

# --- Modal: Benefícios da Conta (Primeiro Nível) ---
${MODAL_BENEFICIOS}             accessibility_id=modal_beneficios
${LINK_DETALHES_CONTA}          accessibility_id=link_detalhes_conta
${LINK_DETALHES_CARTAO}         accessibility_id=link_detalhes_cartao
${BTN_ENTENDI_BENEFICIOS}       accessibility_id=btn_entendi_beneficios

# --- Modal: Detalhes da Conta (Segundo Nível) ---
${MODAL_DETALHES_CONTA}         accessibility_id=modal_mais_detalhes_conta
${BTN_FECHAR_X}                 accessibility_id=botao_fechar_x

# --- Modal: Detalhes do Cartão (Segundo Nível) ---
${MODAL_DETALHES_CARTAO}        accessibility_id=modal_mais_detalhes_cartao
${BTN_ENTENDI_CARTAO}           accessibility_id=botao_entendi_cartao


*** Keywords ***
# ==========================================
# KEYWORDS DE AÇÃO E VALIDAÇÃO (BDD)
# ==========================================

Dado que o modal de "Benefícios da Conta" está aberto
    Wait Until Element Is Visible    ${MODAL_BENEFICIOS}         timeout=10s

Quando clico no link "Mais detalhes sobre a conta"
    Click Element                    ${LINK_DETALHES_CONTA}

Então o modal de "Detalhes da Conta" deve ser exibido
    Wait Until Element Is Visible    ${MODAL_DETALHES_CONTA}     timeout=5s

Quando clico no link "Mais detalhes sobre o cartão"
    Click Element                    ${LINK_DETALHES_CARTAO}

Então o modal de "Detalhes do Cartão" deve ser exibido
    Wait Until Element Is Visible    ${MODAL_DETALHES_CARTAO}    timeout=5s

Quando clico no botão "Entendi"
    Click Element                    ${BTN_ENTENDI_BENEFICIOS}

Então o modal deve ser fechado
    Wait Until Element Is Not Visible    ${MODAL_BENEFICIOS}     timeout=5s


*** Test Cases ***
# ==========================================
# CASOS DE TESTE
# ==========================================

CT_Jornada_Modais: Validar Navegacao e Fechamento de Beneficios
    [Documentation]    Garante que o usuario consegue abrir o detalhamento da conta, voltar, abrir o detalhamento do cartao e fechar os modais corretamente.
    [Tags]             e2e    modais    webview    jornada_completa
    
    # 1. Clica no ícone "i" e aguarda o primeiro modal abrir
    Wait Until Element Is Visible        ${BTN_INFO_I}               timeout=10s
    Click Element                        ${BTN_INFO_I}
    Wait Until Element Is Visible        ${MODAL_BENEFICIOS}         timeout=5s
    
    # 2. Navega para "Mais detalhes sobre a conta", valida e fecha no "X"
    Click Element                        ${LINK_DETALHES_CONTA}
    Wait Until Element Is Visible        ${MODAL_DETALHES_CONTA}     timeout=5s
    Click Element                        ${BTN_FECHAR_X}
    
    # 3. Valida o retorno seguro para o modal principal de Benefícios
    Wait Until Element Is Visible        ${MODAL_BENEFICIOS}         timeout=5s
    
    # 4. Navega para "Mais detalhes sobre o cartão"
    Click Element                        ${LINK_DETALHES_CARTAO}
    Wait Until Element Is Visible        ${MODAL_DETALHES_CARTAO}    timeout=5s
    
    # 5. Fecha o modal de detalhes do cartão clicando em "Entendi"
    Click Element                        ${BTN_ENTENDI_CARTAO}
    
    # 6. Validação Final: Garante que o modal do cartão não está mais visível
    Wait Until Element Is Not Visible    ${MODAL_DETALHES_CARTAO}    timeout=5s

CT07 - Navegacao para Detalhes da Conta
    [Documentation]    Valida a abertura do modal correspondente aos detalhes da conta.
    [Tags]             beneficios    conta
    Dado que o modal de "Benefícios da Conta" está aberto
    Quando clico no link "Mais detalhes sobre a conta"
    Então o modal de "Detalhes da Conta" deve ser exibido

CT08 - Navegacao para Detalhes do Cartao
    [Documentation]    Valida a abertura do modal correspondente aos detalhes do cartao.
    [Tags]             beneficios    cartao
    Dado que o modal de "Benefícios da Conta" está aberto
    Quando clico no link "Mais detalhes sobre o cartão"
    Então o modal de "Detalhes do Cartão" deve ser exibido

CT09 - Fechar Modal de Beneficios
    [Documentation]    Garante que o botao Entendi fecha o modal e preserva o estado.
    [Tags]             beneficios    fechamento
    Dado que o modal de "Benefícios da Conta" está aberto
    Quando clico no botão "Entendi"
    Então o modal deve ser fechado