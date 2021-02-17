class PasswordChecker
  def initialize(data)
    @data = JSON.parse(data)
    @passwords = { good: {}, bad: {}, bad_data: {} }
  end

  def count_valid
    @data.each do |key, value|
      conditions = change_string(key)
      if conditions[-1].class == Integer 
        @passwords[:bad_data][key] = value
      elsif
       letter_count = get_count(conditions[-1], value) 
       @passwords[:good][key] = value if letter_count >= conditions[0] && letter_count <= conditions[1]
      else
        @passwords[:bad][key] = value
      end
    end
    return @passwords[:good].count
  end

  def change_string(string)
    split_array = string.split(/[-, ' ']/)
    split_array[0] = split_array[0].to_i
    split_array[1] = split_array[1].to_i
    split_array
  end

  def get_count(letter, password)
    password.count(letter)
  end
end

