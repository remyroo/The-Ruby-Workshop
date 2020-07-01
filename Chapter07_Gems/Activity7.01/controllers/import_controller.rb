# frozen_string_literal: true

class ImportController < Controller
  attr_accessor :filepath

  def run
    log 'Import votes from an external CSV'
    get_input :filepath, 'Enter the filepath of the CSV file? '

    voting_machine.import_votes(filepath)

    log 'Votes imported!'
  end
end
