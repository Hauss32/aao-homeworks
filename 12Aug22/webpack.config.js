module.exports = {
    entry: './todo_redux.jsx',

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
        extensions: [ '.jsx', '.js', '*' ]
    }
}