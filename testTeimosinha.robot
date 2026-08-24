*** Settings ***
Documentation    Testes E2E da Jornada de Consignado - Experiência: Consignado Varejo (Modal de Retenção / Teimosinha)
Library          AppiumLibrary

# Aplica as tags de negócio a TODOS os testes deste arquivo
Force Tags       jornada:consignado    experiencia:consignado-varejo    retencao

*** Variables ***
# ==========================================
# LOCATORS (Webview)
# ==========================================

# --- Tela Inicial de Oferta ---
${BTN_ABRIR_CONTA_PRINCIPAL}    accessibility_id=botao_abrir_conta_principal
${BTN_RECUSAR_PRINCIPAL}        accessibility_id=botao_recusar_oferta_principal

# --- Modal de Retenção (Teimosinha) ---
${MODAL_TEIMOSINHA}             accessibility_id=modal_retencao_teimosinha
${TXT_TITULO_TEIMOSINHA}        accessibility_id=titulo_modal_teimosinha   # "Tem certeza que não quer..."
${BTN_ACEITAR_TEIMOSINHA}       accessibility_id=botao_aceitar_teimosinha
${BTN_CONFIRMAR_RECUSA}         accessibility_id=botao_confirmar_recusa_teimosinha


*** Keywords ***
# ==========================================
# KEYWORDS DE AÇÃO E VALIDAÇÃO (BDD)
# ==========================================

Dado que o usuário visualiza a oferta principal do consignado
    Wait Until Element Is Visible    ${BTN_RECUSAR_PRINCIPAL}      timeout=10s

Quando clica em "Não quero conta e Consignado" na tela principal
    Click Element                    ${BTN_RECUSAR_PRINCIPAL}

Então o modal de retenção "Tem certeza" deve ser exibido
    Wait Until Element Is Visible    ${MODAL_TEIMOSINHA}           timeout=5s
    Wait Until Element Is Visible    ${TXT_TITULO_TEIMOSINHA}      timeout=5s

Quando clica no botão primário para recuperar a conversão
    # Clica no botão azul "Abrir conta e simular Consignado" dentro do modal
    Click Element                    ${BTN_ACEITAR_TEIMOSINHA}

Então o usuário deve avançar para o funil de contratação
    # Valida se o modal fechou e se a próxima tela do fluxo carregou (ajuste o locator conforme sua próxima tela)
    Wait Until Element Is Not Visible    ${MODAL_TEIMOSINHA}       timeout=5s
    # Exemplo de validação da próxima tela:
    # Wait Until Element Is Visible        accessibility_id=tela_passo_seguinte    timeout=10s

Quando clica no botão secundário para confirmar a recusa
    # Clica no botão "Não quero conta e Consignado" dentro do modal
    Click Element                    ${BTN_CONFIRMAR_RECUSA}

Então a oferta deve ser encerrada
    # Valida o comportamento final de recusa (ex: redireciona para a home do app ou fecha a webview)
    Wait Until Element Is Not Visible    ${MODAL_TEIMOSINHA}       timeout=5s
    # Exemplo: Wait Until Element Is Visible    accessibility_id=home_app_nativa


*** Test Cases ***
# ==========================================
# CASOS DE TESTE
# ==========================================

CT01 - Acionar Teimosinha e Recuperar Conversao
    [Documentation]    Valida o fluxo onde o usuário tenta recusar a oferta, mas é convencido pelo modal de retenção e avança.
    [Tags]             e2e    teimosinha    retencao_sucesso
    Dado que o usuário visualiza a oferta principal do consignado
    Quando clica em "Não quero conta e Consignado" na tela principal
    Então o modal de retenção "Tem certeza" deve ser exibido
    Quando clica no botão primário para recuperar a conversão
    Então o usuário deve avançar para o funil de contratação

CT02 - Acionar Teimosinha e Confirmar Recusa
    [Documentation]    Valida o fluxo onde o usuário visualiza o modal de retenção e confirma a recusa da oferta.
    [Tags]             e2e    teimosinha    recusa_definitiva
    Dado que o usuário visualiza a oferta principal do consignado
    Quando clica em "Não quero conta e Consignado" na tela principal
    Então o modal de retenção "Tem certeza" deve ser exibido
    Quando clica no botão secundário para confirmar a recusa
    Então a oferta deve ser encerrada