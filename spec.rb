# Use TDD principles to build out name functionality for a Person.
# Here are the requirements:
# - Add a method to return the full name as a string. A full name includes
#   first, middle, and last name. If the middle name is missing, there shouldn't
#   have extra spaces.
# - Add a method to return a full name with a middle initial. If the middle name
#   is missing, there shouldn't be extra spaces or a period.
# - Add a method to return all initials. If the middle name is missing, the
#   initials should only have two characters.
#
# We've already sketched out the spec descriptions for the #full_name. Try
# building the specs for that method, watch them fail, then write the code to
# make them pass. Then move on to the other two methods, but this time you'll
# create the descriptions to match the requirements above.

class Person
  attr_reader :first_name, :last_name, :middle_name

  def initialize(first_name:, last_name:, middle_name: nil)
    @first_name = first_name
    @middle_name = middle_name
    @last_name = last_name
  end

  def full_name
    middle_name ? "#{@first_name} #{@middle_name} #{@last_name}" : "#{@first_name} #{@last_name}"
  end

  def full_name_with_middle_initial
    middle_name ? "#{@first_name} #{name_as_initial(@middle_name)} #{@last_name}" : "#{@first_name} #{@last_name}"
  end

  def initials
    middle_name ? "#{name_as_initial(@first_name)} #{name_as_initial(@middle_name)} #{name_as_initial(@last_name)}" : "#{name_as_initial(@first_name)} #{name_as_initial(@last_name)}"
  end

  private

  def name_as_initial(word)
    word.chars.first.upcase
  end

  # implement your behavior here
end

RSpec.describe Person do
  describe '#full_name' do
    it 'concatenates first name, middle name, and last name with spaces' do
      person = Person.new({ first_name: 'John', last_name: 'Smith', middle_name: 'Junior' })
      expect(person.full_name).to eq('John Junior Smith')
    end

    it 'does not add extra spaces if middle name is missing' do
      person_no_middle_name = Person.new({ first_name: 'John', last_name: 'Smith' })
      expect(person_no_middle_name.full_name).to eq('John Smith')
    end
  end

  describe '#full_name_with_middle_initial' do
    it 'concatenates first name, middle name as an initial in upcase, and last name with spaces' do
      person = Person.new({ first_name: 'John', last_name: 'Smith', middle_name: 'Junior' })
      expect(person.full_name_with_middle_initial).to eq('John J Smith')
    end

    it 'does not add extra spaces if middle name is missing' do
      person_no_middle_name = Person.new({ first_name: 'John', last_name: 'Smith' })
      expect(person_no_middle_name.full_name_with_middle_initial).to eq('John Smith')
    end
  end

  describe '#initials' do
    it 'concatenates first name, middle name, and last name with spaces as an initials in upcase' do
      person = Person.new({ first_name: 'John', last_name: 'Smith', middle_name: 'Junior' })
      expect(person.initials).to eq('J J S')
    end

    it 'does not add extra spaces if middle name is missing' do
      person_no_middle_name = Person.new({ first_name: 'John', last_name: 'Smith' })
      expect(person_no_middle_name.initials).to eq('J S')
    end
  end
end
