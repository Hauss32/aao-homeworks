module.exports = {
    entry: './index.js',
    output: {
        filename: 'bundle.js'
    },

    module: {
        rules: [
            {
                test: /\.jsx?$/,
                exclude: /(node_modules)/,
                use: {
                    loader: 'babel-loader',
                    options: {
                        presets: [ '@babel/env', '@babel/react' ]
                    }
                }
            }
        ]
    },

    resolve: {
        extensions: [ '.js', '.jsx', '*' ]
    },

    devtool: 'source-map'
}