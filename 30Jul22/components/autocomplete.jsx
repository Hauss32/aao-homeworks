const React = require( 'react' );
const ReactTransitionGroup = require('react-transition-group');
const CSSTransition = ReactTransitionGroup.CSSTransition;
const TransitionGroup = ReactTransitionGroup.TransitionGroup;

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
        const nameItems = this.state.names.map( name => {
            return ( 
                <CSSTransition
                    key={ name }
                    classNames='fade'
                    timeout={ { enter: 400, exit: 200 } }
                >
                    <li>{ name }</li>
                </CSSTransition >  
            );
        } );

        return (
            <div className='widget autocomplete'>
                    <input 
                        type="text" 
                        placeholder='🔎 Type to Filter List' 
                        value={ this.state.filter }
                        onChange={ this.filterAndSetState }
                    />
                <ul onClick={this.completeFilterAndSetState} >
                    <TransitionGroup>
                        { nameItems }
                    </TransitionGroup>
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