module AcceptanceHelpers
  def handle_js_confirm(accept=true)
    page.driver.browser.switch_to.alert.accept
  end
end