import "@hotwired/turbo-rails"
import "controllers"

document.addEventListener('DOMContentLoaded', () => {
  const myEl = document.getElementById('whatever');
  const menu = document.getElementById('menu');

  if (myEl && menu) {
    myEl.addEventListener('click', () => {
      menu.classList.toggle("hidden");
    });
  } else {
    console.error('Les éléments "whatever" ou "menu" n\'ont pas été trouvés.');
  }
});
