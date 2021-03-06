# Plugin registration
Redmine::Plugin.register :redmine_limited_visibility do
  name 'Redmine Limited Visibility plugin'
  author 'Jean-Baptiste BARTH'
  description 'This is a plugin for Redmine'
  version '0.0.1'
  url 'https://github.com/jbbarth/redmine_limited_visibility'
  author_url 'jeanbaptiste.barth@gmail.com'
end

# Little hack for using the 'deface' gem in redmine:
# - redmine plugins are not railties nor engines, so deface overrides in app/overrides/ are not detected automatically
# - deface doesn't support direct loading anymore ; it unloads everything at boot so that reload in dev works
# - hack consists in adding "app/overrides" path of the plugin in Redmine's main #paths
# TODO: see if it's complicated to turn a plugin into a Railtie or find something a bit cleaner
Rails.application.paths["app/overrides"] ||= []
Rails.application.paths["app/overrides"] << File.expand_path("../app/overrides", __FILE__)

# Add app/services directory to AS autoload paths
ActiveSupport::Dependencies.autoload_paths << File.expand_path("../app/services", __FILE__)

# Custom patches
Rails.application.config.to_prepare do
  require_dependency 'redmine_limited_visibility/issue_patch'
end
