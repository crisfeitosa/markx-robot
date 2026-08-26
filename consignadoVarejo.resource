*** Settings ***
Documentation    Mapeamento e BDD da Tela Principal de Oferta Consignado Varejo
Library          AppiumLibrary
# Importamos o componente compartilhado para usar na validação do modal
Resource         ../../../shared/components/varejo_more_info.resource

*** Variables ***
# ==========================================
# LOCATORS DA TELA PRINCIPAL
# ==========================================
${TXT_TITULO_OFERTA}           xpath=//android.widget.TextView[contains(@text, "Simule o Consignado")]
${BTN_INFO_I}                  accessibility_id=icone_informacao_i
${LINK_EDITAR_ENDERECO}        accessibility_id=link_editar_endereco_cartao
${BTN_ABRIR_CONTA_CONSIG}      accessibility_id=btn_abrir_conta_simular_consignado
${BTN_RECUSAR_OFERTA}          accessibility_id=btn_recusar_conta_consignado

*** Keywords ***
# ==========================================
# KEYWORDS DE BDD (DADO / QUANDO / ENTÃO)
# ==========================================

# --- DADO ---
Dado que estou na tela principal da oferta de Consignado Varejo
    Wait Until Element Is Visible    ${TXT_TITULO_OFERTA}    timeout=15s

# --- QUANDO ---
Quando clico no icone de informacoes da conta
    Wait Until Element Is Visible    ${BTN_INFO_I}        timeout=10s
    Click Element                    ${BTN_INFO_I}

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
Então o modal de informacoes gerais deve ser exibido
    # Esta keyword vem do arquivo varejo_more_info.resource importado ali em cima
    Validar Que O Modal More Info Abriu

Então a tela de edição de endereço deve ser exibida
    # TODO: Inserir mapeamento real da próxima tela quando ela for construída
    Log    Aguardar elemento da tela de endereço aparecer

Então a jornada deve seguir para a simulação de crédito
    # TODO: Inserir mapeamento real da próxima tela quando ela for construída
    Log    Aguardar primeiro passo do fluxo de simulação

Então o fluxo de recusa deve ser acionado
    # TODO: Inserir mapeamento real da tela de feedback
    Log    Aguardar tela de confirmação de recusa
