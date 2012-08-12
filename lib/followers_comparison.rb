require 'json'

module FollowersComparison
  extend self

  def lost(previous, current)
    previous - current
  end

  def gained(previous, current)
    current - previous
  end
end
