# frozen_string_literal: true

require 'minitest/autorun'
require 'minitest/stub_any_instance'
require_relative '../controller'
Dir['./controllers/*.rb'].sort.each { |file| require file }
Dir['./models/*.rb'].sort.each { |file| require file }

class InvalidChoiceException < RuntimeError; end

class TestController < Minitest::Test
  def setup
    # We're going to use a global constant here to set and manage
    # variables that need to be accessible from stubbed methods
    # In bigger applications, you will likely want to avoid this
    $TEST_VARS = {}
  end

  def test_lookup_controller
    assert_equal ExitController, Controller.lookup_controller(:exit)
    assert_equal VoteController, Controller.lookup_controller(:vote)
    assert_equal LeaderboardController, Controller.lookup_controller(:leaderboard)
    assert_nil Controller.lookup_controller(nil)
    assert_nil Controller.lookup_controller(:foo)
  end

  def test_valid_controller_name
    %i[exit vote leaderboard].each do |name|
      assert_equal true, Controller.valid_controller_name?(name)
      assert_equal true, Controller.valid_controller_name?(name.to_s)
    end

    assert_equal false, Controller.valid_controller_name?('foo')
  end

  def test_run_controller_with_bad_choices
    assert_raises InvalidChoiceException do
      Controller.run_controller('', nil)
    end

    assert_raises InvalidChoiceException do
      Controller.run_controller(nil, nil)
    end
  end

  def test_run_exit_controller
    # this makes sure no exceptions are raised
    Controller.run_controller(:exit, nil)
  end

  def test_menu_controller
    stubbed_input_method = proc do |_variable_symbol, _question|
      instance_variable_set('@choice', $TEST_VARS[:choice])
    end

    stub_controller with: stubbed_input_method do
      menu_controller = MenuController.new(nil)

      $TEST_VARS = { choice: 1, display: '' }
      assert_equal :vote, menu_controller.run
      assert_match /Please enter your choice/, $TEST_VARS[:display]

      $TEST_VARS = { choice: 2, display: '' }
      assert_equal :leaderboard, menu_controller.run
      assert_match /Please enter your choice/, $TEST_VARS[:display]

      $TEST_VARS = { choice: 3, display: '' }
      assert_equal :exit, menu_controller.run
      assert_match /Please enter your choice/, $TEST_VARS[:display]
    end
  end

  def test_run_vote_controller
    $TEST_VARS = { voter: 'bob', votee: 'mary' }
    stubbed_input_method = proc do |_variable_symbol, _question|
      instance_variable_set('@voter', $TEST_VARS[:voter])
      instance_variable_set('@votee', $TEST_VARS[:votee])
    end

    # We have to stub the get_input method since this method grabs
    # input from the terminal
    stub_controller with: stubbed_input_method do
      t = Time.now
      Controller.run_controller(:vote, VotingMachine.new(t.month, t.year))
    end
  end

  # def test_run_leaderboard_controller
  #   Controller.run_controller(:leaderboard, nil)
  # end

  private

  # Create a reusable method that will stub the input and present
  # methods. Allows for clean testing of the controllers while
  # giving each test the ability to customize the inputs that get
  # applied to the controller, thus simulating user input
  def stub_controller(with:)
    Controller.stub_any_instance(:get_input, with) do
      Controller.stub_any_instance(:present, stubbed_present_method) do
        yield
      end
    end
  end

  def stubbed_present_method
    proc do |msg|
      $TEST_VARS[:display] ||= ''
      $TEST_VARS[:display] << msg
    end
  end
end
