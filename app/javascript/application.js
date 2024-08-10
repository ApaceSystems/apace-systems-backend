// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
// import "products";

// Function to retrieve CSRF token from meta tags
function getCsrfToken() {
    const metaTag = document.querySelector('meta[name="csrf-token"]');
    return metaTag && metaTag.content;
}

// Example usage: Set the CSRF token in a global variable or header for AJAX requests
const csrfToken = getCsrfToken();
if (csrfToken) {
    // Set the CSRF token in a global variable
    window.csrfToken = csrfToken;

    // Or set it in headers for AJAX requests
    document.addEventListener('ajax:beforeSend', (event) => {
        const { detail: { xhr } } = event;
        xhr.setRequestHeader('X-CSRF-Token', csrfToken);
    });
}
