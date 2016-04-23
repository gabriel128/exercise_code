require 'minitest/autorun'

class NameChanged
  attr_reader :data

  def initialize
    @data = {}
  end

  def publish_with(name:)
    @data[:name] = name
    self
  end

  def apply_to(obj)
     obj.new_with_name(@data[:name])
  end
end

class AgeChanged
  attr_reader :data

  def initialize
    @data = {}
  end

  def publish_with(age:)
    @data[:age] = age
    self
  end

  def apply_to(obj)
     obj.new_with_age(@data[:age])
  end
end

class Person
  attr_reader :name, :age

  def initialize(name: '', age: 0)
    @name = name
    @age = age
  end

  def new_with_age(age)
    Person.new(name: @name, age: age)
  end

  def new_with_name(name)
    Person.new(name: name, age: @age)
  end

  def handle(events)
    events.reduce(self) do |instance, event|
      event.apply_to(instance)
    end
  end

  def self.current_state_from(events)
    new_me = Person.new(name: '', age: 0)
    new_me.handle(events)
  end

  # def immutabe_handle2(events)
  #   events.reduce(self) do |instance, event|
  #     if event.kind_of? NameChanged
  #       new_instance = Person.new(name: event.data[:name], age: instance.age)
  #     elsif event.kind_of? AgeChanged
  #       new_instance = Person.new(name: instance.name, age: event.data[:age])
  #     end
  #     new_instance
  #   end
  # end

  #Common approach, don't like it
  # def handle2(events)
  #   events.each do |event|
  #     if event.kind_of? NameChanged
  #       @name = event.data[:name]
  #     elsif event.kind_of? AgeChanged
  #       @age = event.data[:age]
  #     end
  #   end
  #   self
  # end
end

class EventSourcingTest < Minitest::Test

  def test_name_changed_event
    events = [NameChanged.new.publish_with(name: 'a_name')]
    person = Person.new(name: 'other_name').handle events
    assert_equal person.name, 'a_name'
  end

  def test_last_name_change_is_the_actual_State
    events = []
    events << NameChanged.new.publish_with(name: 'a_name')
    events << NameChanged.new.publish_with(name: 'b_name')
    person = Person.current_state_from(events)
    assert_equal person.name, 'b_name'
  end

  def test_change_age_immutable_ish
    events = []
    events << NameChanged.new.publish_with(name: 'a_name')
    events << NameChanged.new.publish_with(name: 'b_name')
    events << AgeChanged.new.publish_with(age: 6)
    person = Person.new(name: 'other_name', age: 4)
    person2 = person.handle events
    assert_equal person2.name, 'b_name'
    assert_equal person2.age, 6
  end
end
