*** Settings ***
Documentation    Suite de testes E2E para a Tela Principal de Oferta - Jornada Consignado Varejo
Library          AppiumLibrary

# Importando o componente agnóstico que criamos anteriormente
Resource         ../../resources/shared/components/varejo_more_info.robot

# Aplica estas tags automaticamente a TODOS os testes deste arquivo
Force Tags       jornada:consignado_varejo    experiencia:consignado-iu    e2e

*** Variables ***
# ==========================================
# LOCATORS DA TELA PRINCIPAL (Oferta Consignado)
# ==========================================
# Elemento âncora para validar que a tela carregou
${TXT_TITULO_OFERTA}           xpath=//android.widget.TextView[contains(@text, "Simule o Consignado em minutos")]

# Ações da Tela
${LINK_EDITAR_ENDERECO}        accessibility_id=link_editar_endereco_cartao
${BTN_ABRIR_CONTA_CONSIG}      accessibility_id=btn_abrir_conta_simular_consignado
${BTN_RECUSAR_OFERTA}          accessibility_id=btn_recusar_conta_consignado


*** Keywords ***
# ==========================================
# KEYWORDS DE AÇÃO E VALIDAÇÃO (BDD)
# ==========================================

# --- DADO ---
Dado que estou na tela principal da oferta de Consignado Varejo
    [Documentation]    Garante que o app está na tela correta antes de iniciar a ação.
    Wait Until Element Is Visible    ${TXT_TITULO_OFERTA}    timeout=15s

# --- QUANDO ---
Quando clico no link para editar o endereço
    Wait Until Element Is Visible    ${LINK_EDITAR_ENDERECO}    timeout=5s
    Click Element                    ${LINK_EDITAR_ENDERECO}

Quando clico no botão para simular o consignado
    Wait Until Element Is Visible    ${BTN_ABRIR_CONTA_CONSIG}    timeout=5s
    Click Element                    ${BTN_ABRIR_CONTA_CONSIG}

Quando clico em "Não quero conta e Consignado"
    Wait Until Element Is Visible    ${BTN_RECUSAR_OFERTA}        timeout=5s
    Click Element                    ${BTN_RECUSAR_OFERTA}

# --- ENTÃO ---
Então a tela de edição de endereço deve ser exibida
    # Substitua pelo Locator correto da próxima tela de endereço
    Log    Aguardar elemento da tela de endereço aparecer
    # Wait Until Element Is Visible    accessibility_id=tela_edicao_endereco    timeout=10s

Então a jornada deve seguir para a simulação de crédito
    # Substitua pelo Locator correto da próxima tela do funil
    Log    Aguardar primeiro passo do fluxo de simulação
    # Wait Until Element Is Visible    accessibility_id=tela_simulacao_passo1    timeout=10s

Então o fluxo de recusa deve ser acionado
    # Substitua pelo Locator correto da tela de feedback de recusa
    Log    Aguardar tela de confirmação de recusa
    # Wait Until Element Is Visible    accessibility_id=tela_feedback_recusa     timeout=10s


*** Test Cases ***
# ==========================================
# CASOS DE TESTE
# ==========================================

CT01 - Validar Abertura e Fechamento do Modal de Beneficios
    [Documentation]    Garante que o modal de informações gerais (More Info) funciona na tela de consignado.
    [Tags]             modal    more_info
    Dado que estou na tela principal da oferta de Consignado Varejo
    
    # Reaproveitando as keywords do varejo_more_info.robot
    Abrir Varejo More Info Pelo Icone
    Clicar Em Entendi No Varejo More Info

CT02 - Validar Redirecionamento para Edicao de Endereco
    [Documentation]    Garante que o usuario consegue alterar o endereco de entrega do cartao.
    [Tags]             endereco
    Dado que estou na tela principal da oferta de Consignado Varejo
    Quando clico no link para editar o endereço
    Então a tela de edição de endereço deve ser exibida

CT03 - Validar Aceite da Oferta (Caminho Feliz)
    [Documentation]    Garante o prosseguimento da jornada ao aceitar abrir a conta e simular o consignado.
    [Tags]             aceite    caminho_feliz
    Dado que estou na tela principal da oferta de Consignado Varejo
    Quando clico no botão para simular o consignado
    Então a jornada deve seguir para a simulação de crédito

CT04 - Validar Recusa da Oferta
    [Documentation]    Garante o acionamento correto do fluxo de saída/recusa da oferta.
    [Tags]             recusa
    Dado que estou na tela principal da oferta de Consignado Varejo
    Quando clico em "Não quero conta e Consignado"
    Então o fluxo de recusa deve ser acionado
