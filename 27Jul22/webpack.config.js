module.exports = {
    entry: './entry.jsx',

    output: {
        filename: 'bundle.js'
    },

    module: {
        rules: [
            {
                test: [/\.jsx?$/], // Specifies file types to transpile
                exclude: /(node_modules)/, // Leaves dependencies alone
                loader: 'babel-loader', // Sets Babel as the transpiler
                options: {
                    presets: ['@babel/env', '@babel/react'] // Tells Babel what syntaxes to translate
                }
            }
        ]
    },

    resolve: {
        extensions: ['.js', '.jsx', '*']
    },

    devtool: 'source-map',
    mode: 'development'
};