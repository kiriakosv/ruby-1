require 'generator/exercise_case'

class WordyCase < Generator::ExerciseCase

  def workload
    [
      "question = '#{input}'",
      indent(4, assertion),
    ].join("\n")
  end

  private

  def indent(size, lines)
    lines.lines.each_with_object('') { |line, obj| obj << ' ' * size + line }
  end

  def assertion
    return error_assertion if expected == false
    return message_assertion if message

    "assert_equal(#{expected}, WordProblem.new(question).answer)"
  end

  def error_assertion
    [
      'assert_raises ArgumentError do',
      indent(2, 'WordProblem.new(question).answer'),
      'end',
    ].join("\n")
  end

  def message_assertion
    [
      'answer = WordProblem.new(question).answer',
      "message = \"#{message % '#{answer}'}\"",
      "assert_equal(#{expected}, answer, message)",
    ].join("\n")
  end

  def message
    return unless input == 'What is -3 plus 7 multiplied by -2?'

    'You should ignore order of precedence. -3 + 7 * -2 = -8, not %s'
  end
end
