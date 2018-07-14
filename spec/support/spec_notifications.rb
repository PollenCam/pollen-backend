RSpec.configure do |config|
  next unless (RUBY_PLATFORM =~ /darwin/ && ENV['SPEC_NOTIFICATIONS'] =~ /\Atrue\Z/i)

  config.after(:suite) do
    all_passing = RSpec.world.filtered_examples.values.flatten.map(&:execution_result).all? { |result| result.status == :passed }

    if all_passing
      TerminalNotifier.notify('✅')
      system("say 'tests passing'")
    else
      TerminalNotifier.notify('❗️')
      system("say 'tests failing'")
    end
  end
end
