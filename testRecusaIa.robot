*** Settings ***
Documentation    Testes E2E da Jornada de Consignado - Experiência: Consignado Recusa IA (Oferta de Conta Grátis)
Library          AppiumLibrary

# Aplica as tags de negócio a TODOS os testes deste arquivo
Force Tags       jornada:consignado    experiencia:consignado-recusa-ia    down_sell

*** Variables ***
# ==========================================
# LOCATORS (Webview)
# ==========================================

# --- Tela: Recusa de Crédito e Oferta de Conta ---
${TXT_TITULO_RECUSA}            accessibility_id=titulo_recusa_consignado
${LINK_SABER_MAIS}              accessibility_id=link_saber_mais_beneficios
${LINK_EDITAR_ENDERECO}         accessibility_id=link_editar_endereco_entrega
${BTN_QUERO_CONTA}              accessibility_id=botao_quero_conta_gratis
${BTN_NAO_QUERO_CONTA}          accessibility_id=botao_nao_quero_conta_gratis

# --- Modal: Detalhes e Vantagens ---
${MODAL_DETALHES_CONTA}         accessibility_id=modal_detalhes_conta_vantagens
${TAB_CONTA}                    accessibility_id=tab_conta
${TAB_MINHAS_VANTAGENS}         accessibility_id=tab_minhas_vantagens
${BTN_ENTENDI_MODAL}            accessibility_id=botao_entendi_detalhes
${BTN_FECHAR_X_MODAL}           accessibility_id=botao_fechar_x_detalhes


*** Keywords ***
# ==========================================
# KEYWORDS DE AÇÃO E VALIDAÇÃO (BDD)
# ==========================================

Dado que o usuário visualiza a tela de recusa do consignado com oferta de conta
    Wait Until Element Is Visible    ${TXT_TITULO_RECUSA}            timeout=10s
    Element Should Contain Text      ${TXT_TITULO_RECUSA}            Por enquanto, o Consignado não está disponível para você

Quando clica em "Saber mais" sobre os benefícios
    Wait Until Element Is Visible    ${LINK_SABER_MAIS}              timeout=5s
    Click Element                    ${LINK_SABER_MAIS}

Então o modal de detalhes da conta deve ser exibido com as abas de navegação
    Wait Until Element Is Visible    ${MODAL_DETALHES_CONTA}         timeout=5s
    Wait Until Element Is Visible    ${TAB_CONTA}                    timeout=5s
    Wait Until Element Is Visible    ${TAB_MINHAS_VANTAGENS}         timeout=5s

Quando navega entre as abas do modal
    Click Element                    ${TAB_MINHAS_VANTAGENS}
    # Aqui você pode adicionar um validador de que o conteúdo da aba mudou
    Click Element                    ${TAB_CONTA}

E clica no botão "Entendi"
    Click Element                    ${BTN_ENTENDI_MODAL}

Então o modal deve ser fechado retornando para a tela de oferta
    Wait Until Element Is Not Visible    ${MODAL_DETALHES_CONTA}     timeout=5s
    Wait Until Element Is Visible        ${BTN_QUERO_CONTA}          timeout=5s

Quando aceita a oferta clicando em "Quero a Conta Itaú grátis"
    Click Element                    ${BTN_QUERO_CONTA}

Quando recusa a oferta clicando em "Não quero Conta Itaú grátis"
    Click Element                    ${BTN_NAO_QUERO_CONTA}


*** Test Cases ***
# ==========================================
# CASOS DE TESTE
# ==========================================

CT01 - Validar Modal de Beneficios e Navegacao de Abas
    [Documentation]    Garante que o link 'Saber mais' abre o modal correto, permite navegar entre as abas e fechar via botão Entendi.
    [Tags]             e2e    modal_beneficios    tabs
    Dado que o usuário visualiza a tela de recusa do consignado com oferta de conta
    Quando clica em "Saber mais" sobre os benefícios
    Então o modal de detalhes da conta deve ser exibido com as abas de navegação
    Quando navega entre as abas do modal
    E clica no botão "Entendi"
    Então o modal deve ser fechado retornando para a tela de oferta

CT02 - Aceitar Oferta de Conta Gratis (Down-sell)
    [Documentation]    Valida o fluxo positivo onde o cliente aceita abrir a conta mesmo com o crédito negado.
    [Tags]             e2e    aceite_oferta    happy_path
    Dado que o usuário visualiza a tela de recusa do consignado com oferta de conta
    Quando aceita a oferta clicando em "Quero a Conta Itaú grátis"
    # Adicione a validação da próxima tela do funil aqui:
    # Então o usuário deve ser direcionado para a conclusão da abertura de conta

CT03 - Recusar Oferta de Conta Gratis
    [Documentation]    Valida o fluxo negativo onde o cliente dispensa totalmente a relação após a recusa do crédito.
    [Tags]             e2e    recusa_oferta
    Dado que o usuário visualiza a tela de recusa do consignado com oferta de conta
    Quando recusa a oferta clicando em "Não quero Conta Itaú grátis"
    # Adicione a validação de encerramento aqui:
    # Então o fluxo deve ser encerrado e retornar para a home