# Pin npm packages by running ./bin/importmap

pin "application"
pin "@hotwired/turbo-rails", to: "turbo.min.js"
pin "@hotwired/stimulus", to: "stimulus.min.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin_all_from "app/javascript/controllers", under: "controllers"
pin "@fullcalendar/core", to: "https://cdn.jsdelivr.net/npm/@fullcalendar/core@6.1.5/main.min.js"
pin "@fullcalendar/daygrid", to: "https://cdn.jsdelivr.net/npm/@fullcalendar/daygrid@6.1.5/main.min.js"
pin "@fullcalendar/interaction", to: "https://cdn.jsdelivr.net/npm/@fullcalendar/interaction@6.1.5/main.min.js"
pin "@fullcalendar/core/main.css", to: "https://cdn.jsdelivr.net/npm/@fullcalendar/core@6.1.5/main.min.css"
pin "@fullcalendar/daygrid/main.css", to: "https://cdn.jsdelivr.net/npm/@fullcalendar/daygrid@6.1.5/main.min.css"
