# frozen_string_literal: true

module Menu
  INCORRECT_INPUT = 'Incorrect input value! Use numeric only from list above!'
  YOUR_CHOICE = 'Enter your choice: '
  TABLE = '
******************
*** Black Jack ***
******************

%<result>s

Game: %<game>s                     Round: %<round>s
------------------------------------
		Dealer:
Bank: %<dealer_bank>s		%<bet>s
Hand: %<dealer_hand>s
%<dealer_message>s
------------------------------------
		%<user_name>s:
Bank: %<user_bank>s		%<bet>s
Hand: %<user_hand>s
Your sum: %<user_sum>s
------------------------------------
'

  protected

  def show_menu(menu)
    menu.each_with_index { |action, index| puts "#{index}. #{action[:value]}." }
  end

  def play_menu
    [
      { value: 'Exit', action: :exit },
      { value: 'One more card', action: :one_more_card_user },
      { value: 'Pass', action: :pass },
      { value: 'Show cards', action: :end_game }
    ]
  end

  def end_game_menu
    [
      { value: 'Exit', action: :exit },
      { value: 'Play again', action: :next_game }
    ]
  end

  def user_choice(menu)
    print YOUR_CHOICE
    input_value = gets.chomp.to_i
    menu[input_value.to_i][:action]
  rescue NoMethodError => e
    puts "ERROR: #{e.message}"
    puts INCORRECT_INPUT
    retry
  end
end
