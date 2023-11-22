import "@hotwired/turbo-rails"
import "controllers"

document.addEventListener('DOMContentLoaded', () => {
  const myEl = document.getElementById('whatever');
  const menu = document.getElementById('menu')
  myEl.addEventListener('click', function() {
    menu.classList.toggle("hidden");
  });
})
