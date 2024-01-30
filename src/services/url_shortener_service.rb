class UrlShortenerService
  @@shorters = {};

  def shorten(url:, short_code:)
    raise "Short code is not available" if @@shorters[short_code].present?

    @@shorters[short_code] = {
      url:,
      start_date: Time.now,
      last_seen_date: nil,
      redirect_count: 0
    }
  end

end
