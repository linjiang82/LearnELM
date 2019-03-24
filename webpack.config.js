module.exports = {
  entry: {
    app: [
      './index.js'
    ]
  },

  output: {
    filename: '[name].js',
  },
  module: {
    rules: [{
        test: /\.elm$/,
        use: [{
            loader: 'elm-css-modules-loader',
          },
          {
            loader: 'elm-webpack-loader',
          }
        ],
      },
      {
        test: /\.css$/,
        use: ['style-loader', 'css-loader?modules=true'],
      },
    ],
  },
  devServer: {
    inline: true,
    stats: {
      colors: true
    },
  }
};