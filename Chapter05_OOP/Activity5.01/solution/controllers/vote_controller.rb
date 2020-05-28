# frozen_string_literal: true

class VoteController < Controller
  attr_accessor :voter, :votee

  def run
    get_input :voter, "What's your name? "
    get_input :votee, 'Who do you want to vote for? '

    voting_machine.record_vote(@voter, @votee)

    log 'Vote recorded!'
  end
end
