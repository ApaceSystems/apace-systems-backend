# frozen_string_literal: true

# Pin npm packages by running ./bin/importmap

# config/importmap.rb
pin 'application', to: 'application.js'
pin '@hotwired/turbo-rails', to: 'turbo.min.js'
pin '@hotwired/stimulus', to: 'stimulus.min.js'
pin '@hotwired/stimulus-loading', to: 'stimulus-loading.js'
# pin 'products', to: 'products.js'

pin_all_from 'app/javascript/controllers', under: 'controllers'
