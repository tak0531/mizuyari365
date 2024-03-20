// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import '@hotwired/turbo-rails';
import './custom/preview.js';
import './custom/fade.js';

import { Application } from '@hotwired/stimulus'
import { Autocomplete } from 'stimulus-autocomplete'

const application = Application.start()
application.register('autocomplete', Autocomplete)
// コンポーネントにあるAutocompleteコントローラを使えるようにするための記述

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

export { application }

