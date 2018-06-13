RSpec.configure do |config|
  config.after(:suite) do
    any_failures = RSpec.world.filtered_examples.values.flatten.any?(&:exception)

    if any_failures
      `terminal-notifier -message '❗️' && say 'tests failing'`
    else
      `terminal-notifier -message '✅' && say 'tests passing'`
    end
  end
end
