# frozen_string_literal: true

module Menu
  INCORRECT_INPUT = 'Incorect input value! Use numeric only from list above!'
  YOUR_CHOICE = 'Enter your choice: '

  protected

  def show_menu
    main_menu.each_with_index { |action, index| puts "#{index}. #{action[:value]}." }
  end

  def main_menu
    [
      { value: 'Exit', action: :exit },
      { value: 'One more card', action: :one_more_card },
      { value: 'Pass', action: :pass }
    ]
  end

  def user_action
    print YOUR_CHOICE
    input_value = gets.chomp.to_i
    main_menu[input_value.to_i][:action]
  end
end
