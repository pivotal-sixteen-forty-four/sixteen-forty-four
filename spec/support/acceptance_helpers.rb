module AcceptanceHelpers
  DEFAULT_FLIP_TIME = 1.second
  def handle_js_confirm(accept=true)
    page.driver.browser.switch_to.alert.accept
  end

  def refresh_page
    page.evaluate_script("window.location.reload()")
  end

  def with_flip_timeout(timeout_in_seconds, &block)
    page.evaluate_script('(function() { return window.UNFLIP_TIMEOUT_MS; })()')
    page.execute_script("UNFLIP_TIMEOUT_MS = #{timeout_in_seconds * 1000};")
    block.call
  ensure
    page.execute_script("UNFLIP_TIMEOUT_MS = #{DEFAULT_FLIP_TIME};")
  end
end