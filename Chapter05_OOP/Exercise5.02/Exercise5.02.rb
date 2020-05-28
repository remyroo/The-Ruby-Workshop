# frozen_string_literal: true

# rubocop:disable ClassVars

class SocialShare
  # Use Named Placement (%{var}) to acheive multiple string substitution into a string template
  # where the string template is the social media url string

  @@platforms = {
    facebook: 'https://www.facebook.com/sharer/sharer.php?u=%{url}',
    twitter: 'https://twitter.com/intent/tweet?text=%{url} %{title}',
    linkedin: 'http://www.linkedin.com/shareArticle?mini=true&url=%{url}&title=%{title}&summary=%{summary}&source=Recognize'
  }

  def initialize(platform, title, url, summary = '')
    @platform = platform.to_sym
    @title = title
    @share_url = url
    @summary = summary
  end

  def url
    # a reader method to help store each result of generate_url as an instance method.
    @url ||= generate_url
  end

  def generate_url
    # syntax for named placement substitution: template on the left, vars in hash on the right.
    format(@@platforms[@platform], title: @title, url: @share_url, summary: @summary)
  end

  # Optional approach using class methods
  # class method makes it easier + cleaner to get a share_url
  # it will do all the work during instantiation
  def self.url(platform, title, url, summary = '')
    new(platform, title, url, summary).url
  end

  # convenience class method to return links for all platforms
  def self.get_links_for_all(title, url, summary = '')
    @@platforms.keys.map do |platform|
      url(platform, title, url, summary)
    end
  end
end

# Then, in an IRB console, let's set up some variables that we will reuse when testing:
title = 'Check out this great coding website!'
url = 'packt.com'
%i[twitter facebook linkedin].each do |platform|
  puts SocialShare.new(platform, title, url).url
end
puts '******'
pp SocialShare.url('twitter', title, url)
puts '******'
pp SocialShare.get_links_for_all(title, url)
