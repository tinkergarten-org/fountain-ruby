# RSpec matcher to spec delegations.
#
# Sourced from https://gist.github.com/txus/807456
#
# Usage:
#
#     describe Post do
#       it { is_expected.to delegate_method(:name).to(:author).with_prefix } # post.author_name
#       it { is_expected.to delegate_method(:month).to(:created_at) }
#       it { is_expected.to delegate_method(:year).to(:created_at) }
#     end
RSpec::Matchers.define :delegate_method do |method|
  match do |delegator|
    @method = @prefix ? :"#{@to}_#{method}" : method
    @delegator = delegator
    begin
      @delegator.send(@to)
    rescue NoMethodError
      raise "#{@delegator} does not respond to #{@to}!"
    end
    allow(@delegator).to receive(@to).and_return double('receiver')
    allow(@delegator.send(@to)).to receive(method).and_return :called
    @delegator.send(@method) == :called
  end

  description do
    "delegate :#{@method} to its #{@to}#{@prefix ? ' with prefix' : ''}"
  end

  failure_message do
    "expected #{@delegator} to delegate :#{@method} to its #{@to}#{@prefix ? ' with prefix' : ''}"
  end

  failure_message_when_negated do
    "expected #{@delegator} not to delegate :#{@method} to its #{@to}#{@prefix ? ' with prefix' : ''}"
  end

  chain(:to) { |receiver| @to = receiver }
  chain(:with_prefix) { @prefix = true }
end
