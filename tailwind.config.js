/** @type {import('tailwindcss').Config} */
export default {
  content: ['./src/**/*.{astro,html,js,jsx,md,mdx,svelte,ts,tsx,vue}'],
  theme: {
    extend: {
      colors: {
        primary: '#F0F0F0',
        secondary: '#171718',
        accent1: 'rgb(0 255 210)',
        accent2: '#d90e46',
      }
    },
  },
  plugins: [],
};
