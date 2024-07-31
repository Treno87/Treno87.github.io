puts "Debugging gemspec file"
require "json"
begin
  puts "Current directory: #{Dir.pwd}"
  package_json_path = File.expand_path('../package.json', __FILE__)
  puts "package.json path: #{package_json_path}"
  puts "package.json exists: #{File.exist?(package_json_path)}"
  package_json_content = File.read(package_json_path)
  puts "package.json content: #{package_json_content}"
  package_json = JSON.parse(package_json_content)
  puts "Successfully parsed package.json"
  puts "Version: #{package_json["version"]}"
rescue => e
  puts "Error reading or parsing package.json: #{e.message}"
  puts "Error backtrace: #{e.backtrace.join("\n")}"
  # Fallback to hardcoded version if package.json can't be read
  package_json = {"version" => "4.26.2"}
end

Gem::Specification.new do |spec|
  spec.name                    = "minimal-mistakes-jekyll"
  spec.version                 = package_json["version"]
  spec.authors                 = ["Michael Rose", "iBug"]

  spec.summary                 = %q{A flexible two-column Jekyll theme.}
  spec.homepage                = "https://github.com/mmistakes/minimal-mistakes"
  spec.license                 = "MIT"

  spec.metadata["plugin_type"] = "theme"

  spec.files                   = `git ls-files -z`.split("\x0").select do |f|
    f.match(%r{^(assets|_(data|includes|layouts|sass)/|(LICENSE|README|CHANGELOG)((\.(txt|md|markdown)|$)))}i)
  end

  spec.add_runtime_dependency "jekyll", ">= 3.7", "< 5.0"
  spec.add_runtime_dependency "jekyll-paginate", "~> 1.1"
  spec.add_runtime_dependency "jekyll-sitemap", "~> 1.3"
  spec.add_runtime_dependency "jekyll-gist", "~> 1.5"
  spec.add_runtime_dependency "jekyll-feed", "~> 0.1"
  spec.add_runtime_dependency "jekyll-include-cache", "~> 0.1"

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake", ">= 12.3.3"
end