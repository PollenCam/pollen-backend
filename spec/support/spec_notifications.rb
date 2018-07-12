RSpec.configure do |config|
  next unless (RUBY_PLATFORM =~ /darwin/ && ENV['SPEC_NOTIFICATIONS'] =~ /\Atrue\Z/i)

  config.after(:suite) do
    any_failures = RSpec.world.filtered_examples.values.flatten.any?(&:exception)

    if any_failures
      TerminalNotifier.notify('❗️')
      system("say 'tests failing'")
    else
      TerminalNotifier.notify('✅')
      system("say 'tests passing'")
    end
  end
end
