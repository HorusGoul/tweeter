module.exports = {
  plugins: [
    // TODO: is this necessary?
    require("postcss-import"),
    require("tailwindcss")("./tailwind.config.js"),
    require("autoprefixer"),
  ],
};
