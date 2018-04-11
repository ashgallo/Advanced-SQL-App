import React from 'react';
import axios from 'axios';
import { Form, List } from 'semantic-ui-react';

class FindHome extends React.Component {
  state = {
    agents: [],
    agent: null,
    buyers: [],
    buyer: null,
    properties: [],
  }

  componentDidMount() {
    axios.get('/api/agents')
      .then( res => this.setState({ agents: res.data }) )
  }

  agentList = () => {
    const { agents } = this.state;
    return agents.map( agent => {
      return { 
        key: agent.id,
        text: `${agent.first_name} ${agent.last_name}`,
        value: agent.id
      }
    });
  }

  buyerList = () => {
    const { buyers } = this.state;
    return buyers.map( buyer => {
      return {
        key: buyer.id,
        text: `${buyer.first_name} ${buyer.last_name}`,
        value: buyer.id
      }
    })
  }

  getProperties = (e, {value}) => {
    this.setState({ buyer: value }, () => {
      axios.get(`/api/buyers/${this.state.buyer}`)
        .then( res => this.setState({ properties: res.data }) )
     });
  }
  

  getBuyers = (e, { value }) => {
    this.setState({ agent: value }, () => {
      axios.get(`/api/agents/${this.state.agent}`)
        .then( res => this.setState({ buyers: res.data }) )
    });
  }

  showProperties = () => {
    const { properties } = this.state;
    return properties.map( p =>
      <List key={p.id}>
        <List.Content>
          <List.Header>${p.price} - {p.sq_ft}</List.Header>
          <List.Description>{p.city}</List.Description>
        </List.Content>
      </List>
    )
  }

  render() {
    const { properties, agent } = this.state;
    return (
      <div>
        <Form.Select 
          label="Agent:"
          options={this.agentList()} 
          onChange={this.getBuyers}
        />
        { agent &&
          <Form.Select
            label="Buyer: "
            options={this.buyerList()}
            onChange={this.getProperties}
          />
        }
        { properties.length > 0 && this.showProperties() }
      </div>
    )
  }
}

export default FindHome