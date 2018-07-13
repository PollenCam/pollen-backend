class Rails::Application::RoutesReloader
  private def load_paths
    # Kills off activestorage routes MWAHAHAHAHA. Previously:
    # paths.each { |path| load(path) }
    paths.each { |path| load(path) unless path.include?('activestorage') }
  end
end
