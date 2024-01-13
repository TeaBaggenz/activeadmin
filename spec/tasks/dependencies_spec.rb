# frozen_string_literal: true
require 'rails_helper'

RSpec.describe "Dependencies sanity" do
  it "is up to date" do
    map_packages = ActiveAdmin.importmap.packages.keys - %w(active_admin)

    package_json = JSON.parse(File.read(ActiveAdmin::Engine.root.join('package.json')))
    npm_dependencies = package_json.fetch('dependencies').keys

    begin
      expect(npm_dependencies).to match_array(map_packages)
    rescue RSpec::Expectations::ExpectationNotMetError => e
      e.message << "\n" <<  <<~MESSAGE
        Remove extra elements (unused dependencies) from package.json and
        add missing elements (required dependencies) to package.json
      MESSAGE

      raise e
    end
  end
end
