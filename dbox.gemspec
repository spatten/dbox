# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "dbox"
  s.version = "0.6.5"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Ken Pratt"]
  s.date = "2012-02-03"
  s.description = "An easy-to-use Dropbox client with fine-grained control over syncs."
  s.email = "ken@kenpratt.net"
  s.executables = ["dbox"]
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.md"
  ]
  s.files = [
    ".document",
    "History.txt",
    "LICENSE.txt",
    "README.md",
    "Rakefile",
    "TODO.txt",
    "VERSION",
    "bin/dbox",
    "dbox.gemspec",
    "lib/dbox.rb",
    "lib/dbox/api.rb",
    "lib/dbox/cacert.pem",
    "lib/dbox/database.rb",
    "lib/dbox/db.rb",
    "lib/dbox/loggable.rb",
    "lib/dbox/parallel_tasks.rb",
    "lib/dbox/syncer.rb",
    "lib/dbox/utils.rb",
    "sample_polling_script.rb",
    "spec/dbox_spec.rb",
    "spec/spec_helper.rb",
    "vendor/dropbox-ruby-sdk/CHANGELOG",
    "vendor/dropbox-ruby-sdk/LICENSE",
    "vendor/dropbox-ruby-sdk/README",
    "vendor/dropbox-ruby-sdk/cli_example.rb",
    "vendor/dropbox-ruby-sdk/dropbox_controller.rb",
    "vendor/dropbox-ruby-sdk/gemspec.rb",
    "vendor/dropbox-ruby-sdk/lib/dropbox_sdk.rb",
    "vendor/dropbox-ruby-sdk/web_file_browser.rb"
  ]
  s.homepage = "http://github.com/kenpratt/dbox"
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.11"
  s.summary = "Dropbox made easy."

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<multipart-post>, [">= 1.1.2"])
      s.add_runtime_dependency(%q<oauth>, [">= 0.4.5"])
      s.add_runtime_dependency(%q<json>, [">= 1.5.3"])
      s.add_runtime_dependency(%q<sqlite3>, [">= 1.3.3"])
      s.add_runtime_dependency(%q<activesupport>, [">= 3.0.1"])
    else
      s.add_dependency(%q<multipart-post>, [">= 1.1.2"])
      s.add_dependency(%q<oauth>, [">= 0.4.5"])
      s.add_dependency(%q<json>, [">= 1.5.3"])
      s.add_dependency(%q<sqlite3>, [">= 1.3.3"])
      s.add_dependency(%q<activesupport>, [">= 3.0.1"])
    end
  else
    s.add_dependency(%q<multipart-post>, [">= 1.1.2"])
    s.add_dependency(%q<oauth>, [">= 0.4.5"])
    s.add_dependency(%q<json>, [">= 1.5.3"])
    s.add_dependency(%q<sqlite3>, [">= 1.3.3"])
    s.add_dependency(%q<activesupport>, [">= 3.0.1"])
  end
end

