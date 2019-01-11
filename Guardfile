# frozen_string_literal: true
require 'active_support/inflector'
notification :off

#group :red_green_refactor, halt_on_fail: true do
group :red_green_refactor, notification: false do
  guard :minitest, all_on_start: false, notification: false do
    # with Minitest
    watch(%r{^test/(.*)\/?test_(.*)\.rb$})
    watch(%r{^lib/(.*/)?([^/]+)\.rb$})     { |m| "test/#{m[1]}test_#{m[2]}.rb" }
    watch(%r{^test/test_helper\.rb$})      { 'test' }
    watch(%r{^test/fixtures/(.+(?:s|ies|es)).yml$}) do |m|
      "test/models/#{ActiveSupport::Inflector.singularize(m[1])}_test.rb"
    end

    # with Minitest::Spec
    # watch(%r{^spec/(.*)_spec\.rb$})
    # watch(%r{^lib/(.+)\.rb$})         { |m| "spec/#{m[1]}_spec.rb" }
    # watch(%r{^spec/spec_helper\.rb$}) { 'spec' }

    # Rails 4
    watch(%r{^app/(.+)\.rb$})                               { |m| "test/#{m[1]}_test.rb" }
    watch(%r{^app/controllers/application_controller\.rb$}) { 'test/controllers' }
    watch(%r{^app/controllers/(.+)_controller\.rb$})        { |m| "test/integration/#{m[1]}_test.rb" }
    watch(%r{^app/views/(.+)_mailer/.+})                    { |m| "test/mailers/#{m[1]}_mailer_test.rb" }
    watch(%r{^lib/(.+)\.rb$})                               { |m| "test/lib/#{m[1]}_test.rb" }
    watch(%r{^test/.+_test\.rb$})
    watch(%r{^test/test_helper\.rb$}) { 'test' }
    watch(/^app\/controllers\/(.+)_controller.rb/) do |m|
      ["test/integration/#{m[1].singularize}_spec.rb",
       "test/routing/#{m[1]}_routing_spec.rb"]
    end
  end
end
