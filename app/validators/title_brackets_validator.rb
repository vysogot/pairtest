class TitleBracketsValidator < ActiveModel::Validator
  def validate(record)
    unless brackets_ok?(record.title)
      record.errors['title'] << "not a valid title"
    end
  end

  private

  def brackets_ok?(title)
    brackets = {"(" => ")", "{" => "}", "[" => "]"}
    openings = []
    body = false

    title.each_char do |char|

      if brackets.keys.include?(char)
        openings.push(char)
        body = false
      elsif brackets.values.include?(char)
        return false if (openings.last != brackets.key(char)) || !body

        openings.pop
      elsif openings.present?
        body = true
      end

    end

    return openings.empty?
  end
end
