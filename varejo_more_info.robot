*** Variables ***
# O ideal é pedir para adicionar testID no código, mas se não tiver, mapeamos pelo texto/classe no Appium
${MODAL_VAREJO_MORE_INFO}    xpath=//android.widget.TextView[@text="Conheça mais benefícios da Conta Itaú grátis"]
${BOTAO_ENTENDI}             xpath=//android.widget.Button[@text="Entendi"]
${LINK_MAIS_DETALHES_CONTA}  xpath=//android.widget.TextView[@text="Mais detalhes sobre a conta"]
${ACCORDION_BENEFICIOS}      accessibility_id=accordion-beneficios-varejo # Exemplo com testID ideal

*** Keywords ***
Validar Que Componente Varejo More Info Renderizou
    [Documentation]    Valida se a tela de "Saiba Mais" do Varejo carregou corretamente.
    Wait Until Element Is Visible    ${MODAL_VAREJO_MORE_INFO}    timeout=10s
    Page Should Contain Text         Ajudamos você a criar metas
    Page Should Contain Text         Fatura e vencimento do cartão

Clicar Em Entendi No Varejo More Info
    Wait Until Element Is Visible    ${BOTAO_ENTENDI}
    Click Element                    ${BOTAO_ENTENDI}

Abrir Detalhes Da Conta No Varejo More Info
    Wait Until Element Is Visible    ${LINK_MAIS_DETALHES_CONTA}
    Click Element                    ${LINK_MAIS_DETALHES_CONTA}
