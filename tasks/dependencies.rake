require "open3"
require "json"

namespace :dependencies do
  desc "Download all package.json dependencies into vendor/javascript"
  task :vendor do
    # Use npm to get a list of all dependencies with actual versions
    npm_ls, error, status = Open3.capture3("npm ls --json --omit dev")

    dependencies = JSON.parse(npm_ls).fetch("dependencies")

    # packager = Importmap::Packager.new(vendor_path: "vendor/javascript")

    # imports = packager.import("trix", from: "unpkg")

    packages = dependencies.map { |name, info| "#{name}@#{info["version"]}" }

    require "importmap-rails"
    require "importmap/packager"
    imports = Importmap::Packager.new.import("flowbite")

    puts imports

    # system "./bin/importmap", "pin", *packages, exception: true

    # Importmap::Commands.start(['pin', packages].flatten)

    # npm ls --json --omit dev
    # system "npm", "version", npmified_version, "--no-git-tag-version", exception: true
    # system "yarn install"
  end
end
