# frozen_string_literal: true

# Modules can also be used to namespace constants that are used in
# multiple places to avoid naming collisions.
# Module::Constant -> the :: is Ruby's scoping operator.
class User
  def self.output
    'Global User'
  end
end

module Report
  def self.test_namespace
    User.output
  end

  class User
    def self.output
      'Report::User'
    end
  end
end

Report.test_namespace # returns "Report::User"

class User
  def self.output
    'Global User'
  end
end

module Report
  def self.test_namespace
    User.output
  end

  def self.test_global
    ::User.output
  end
  # by leaving the left of the scoping operator :: blank
  # this becomes the global scoping operator, so test_global
  # now references the global User rather than the locally
  # scoped Report::User one.

  class User
    def self.output
      'Report::User'
    end
  end
end

Report.test_namespace # returns "Report::User"
Report.test_global # returns "Global User"
