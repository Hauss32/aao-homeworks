const React = require('react');

class Tabs extends React.Component {
    constructor(props) {
        super(props);

        this.state = {
            selectedTabIdx: 0
        }

        this.updateTabIndex = this.updateTabIndex.bind(this);
    }

    render() {
        const tabs = this.props.tabs;
        const tabListEles = [];
        const currTabIdx = this.state.selectedTabIdx;
        const content = tabs[currTabIdx].content;

        tabs.forEach( ( tab, idx ) => {
            const eleClass = ( currTabIdx == idx ) ? 'tab-item selected' : 'tab-item';
            const tabEle = <li 
                key={ idx } 
                className={ eleClass } 
                list_id={ idx }
                onClick={ this.updateTabIndex }
                >
                    <h1>{ tab.title }</h1>
            </li>

            tabListEles.push( tabEle );
        });

        return (
            <div className='widget tabs'>
                <header>
                    <ul>
                        { tabListEles }
                    </ul>
                </header>
                <article>
                    {content}
                </article>
            </div>
        )
    }

    updateTabIndex(event) {
        const newIdx = event.currentTarget.getAttribute('list_id');
        this.setState( { selectedTabIdx: newIdx } );
    }
}

module.exports = Tabs;