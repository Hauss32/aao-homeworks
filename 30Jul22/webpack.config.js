module.exports = {
    entry: './widgets.jsx',
    output: {
        filename: 'bundle.js'
    },

    module: {
        rules: [
            {
                test: /\.jsx?$/,
                exclude: /(node_modules)/,
                loader: 'babel-loader',
                options: {
                    presets: [ '@babel/env', '@babel/react' ]
                }
            }
        ]
    },

    devtool: 'source-map',
    resolve: {
        extensions: [ '.js', '.jsx', '*']
    }
}