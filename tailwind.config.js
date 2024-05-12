/** @type {import('tailwindcss').Config} */

module.exports = {
  content: [
    "./app/views/**/*.html.erb",
    "./app/helpers/**/*.rb",
    "./app/assets/stylesheets/**/*.css",
    "./app/javascript/**/*.js",
  ],
  theme: {
    extend: {
      screens: {
        "2xl": "1360px",
      },
    },
    container: {
      padding: {
        DEFAULT: "1rem",
        md: "1.5rem",
        lg: "2rem",
      },
    },
  },
  plugins: [
    require('@tailwindcss/typography'),
  ],
};
