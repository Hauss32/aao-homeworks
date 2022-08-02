const React = require( 'react' );

class Autocomplete extends React.Component {
    constructor(props) {
        super( props );

        this.state = {
            filter: '',
            names: this.props.namesList
        };

        this.filterAndSetState = this.filterAndSetState.bind(this);
        this.completeFilterAndSetState = this.completeFilterAndSetState.bind(this);
    }

    render() {
        return (
            <div className='widget autocomplete'>
                    <input 
                        type="text" 
                        placeholder='🔎 Type to Filter List' 
                        value={ this.state.filter }
                        onChange={ this.filterAndSetState }
                    />
                <ul onClick={this.completeFilterAndSetState} >
                    {
                        this.state.names.map( name => <li key={ name }>{ name }</li> )
                    }
                </ul>
            </div>
        )
    }

    filterAndSetState(event) {
        const newFilterValue = event.currentTarget.value;
        const filterValueTest = newFilterValue.toLowerCase();
        const filteredNames = this.props.namesList.filter( name => {
            return name.toLowerCase().startsWith( filterValueTest );
        } );

        this.setState( { filter: newFilterValue, names: filteredNames } );
    }

    completeFilterAndSetState(event) {
        const elem = event.target;

        if ( elem.tagName === 'LI' ) {
            const name = elem.textContent;
            this.setState( { filter: name, names: [ name ] } );
        }
    }
}

module.exports = Autocomplete;