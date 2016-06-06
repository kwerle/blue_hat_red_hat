require_relative ('clown_list.rb')

class Clown
  attr_reader :pos, :color, :correct

  def initialize(opts)
    @pos = opts[:position]
    @correct = true
    @clowns_line = opts[:clowns_line]
    @color = opts[:color]
  end

  def say_answer
    count_hats_ahead
    answer = figure_what_answer_to_say
    @correct = @color == answer
    {color_spoken: answer, correct: @correct, position: @pos}
  end

  def hear_answer_result(heard_answer)
    #This is also where algorithm code would go!

    @pos_last_heard_answer = heard_answer[:position]
    @last_speaker_correct = heard_answer[:correct]
    @color_last_speaker_said = heard_answer[:color_spoken]
  end

  private

  def figure_what_answer_to_say
    #This is where you put your algorithm!!
    #Make an algorithm that will save the maximum amount of people for sure

    # blue = 0.  red = 1.  Let's go for parity of 0.
    last_guess_was_red = @color == :red

    reds = @known_reds + (last_guess_was_red ? 1 : 0)

    if reds % 2 == 1
      return :red
    else
      return :blue
    end
  end

  def count_hats_ahead
    @known_reds = 0
    @known_blues = 0
    i = pos + 1
    while i < @clowns_line.length
      seen_color = @clowns_line[i].color
      if seen_color == :red
        @known_reds += 1
      else
        @known_blues += 1
      end
      i += 1
    end
  end

end
