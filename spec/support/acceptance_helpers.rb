module AcceptanceHelpers
  DEFAULT_FLIP_TIME = 1.second
  def handle_js_confirm(accept=true)
    page.driver.browser.switch_to.alert.accept
  end

  def refresh_page
    page.evaluate_script("window.location.reload()")
  end

  def with_flip_timeout(timeout_in_seconds, &block)
    page.execute_script('try { (function() { return window.UNFLIP_TIMEOUT_MS; })() } catch(e) { }')
    page.execute_script("try { window.UNFLIP_TIMEOUT_MS = #{timeout_in_seconds * 1000};} catch(e) { }")
    block.call
  end
end
