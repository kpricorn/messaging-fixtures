require_relative '../../automated_init'

context "Message Fixture" do
  context "Assert Attributes Copied" do
    source_message = Controls::Message.example

    message_class = Controls::Event::Output

    attribute_names = [
      :example_id,
      { :quantity => :amount },
      :time,
    ]

    message = message_class.copy(source_message, copy: attribute_names)

    fixture = Message.build(message, source_message)

    fixture.assert_attributes_copied(attribute_names)

    context_text = 'Attributes Copied: Input => Output'

    context "Context: \"#{context_text}\"" do
      printed = fixture.test_session.context?(context_text)

      test "Printed" do
        assert(printed)
      end
    end

    attribute_context = fixture.test_session[context_text]

    context "example_id" do
      passed = attribute_context.test_passed?('example_id')

      test "Passed" do
        assert(passed)
      end
    end

    context "quantity => amount" do
      passed = attribute_context.test_passed?('quantity => amount')

      test "Passed" do
        assert(passed)
      end
    end

    context "time" do
      passed = attribute_context.test_passed?('time')

      test "Passed" do
        assert(passed)
      end
    end
  end
end
