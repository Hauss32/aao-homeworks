module.exports = {
    entry: './react_minesweeper.jsx',
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

    resolve: {
        extensions: [ '.js', '.jsx', '*' ]
    },
    
    devtool: 'source-map'
}