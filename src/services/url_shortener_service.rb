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

  def consume(short_code)
    raise "Short code is not available" unless @@shorters[short_code].present?

    @@shorters[short_code][:redirect_count] += 1
    @@shorters[short_code][:last_seen_date] = Time.now

    @@shorters[short_code][:url]
  end

  def stats(short_code)
    @@shorters[short_code] ||= {}
  end
end
