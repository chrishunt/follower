require 'json'

module Followers
  module Comparison
    extend self

    def lost(previous, current)
      previous - current
    end

    def gained(previous, current)
      current - previous
    end
  end
end
