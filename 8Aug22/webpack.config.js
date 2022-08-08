module.exports = {
    entry: './entry.jsx',

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
                    presets: [ '@babel/react', '@babel/env' ]
                }
            }
        ]
    },

    devtool: 'source-map',

    resolve: {
        extensions: [ '.js', '.jsx', '*' ]
    }


}