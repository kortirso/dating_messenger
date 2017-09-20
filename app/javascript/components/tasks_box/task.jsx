import React from 'react';

class Task extends React.Component {

    render() {
        let task = this.props.task;
        return (
            <tr>
                <td>{task.id}</td>
                <td>{task.url}</td>
                <td>{task.email}</td>
                <td>{task.profiles_count}</td>
                <td>{task.scrape_progress}</td>
                <td>{task.current_status}</td>
            </tr>
        );
    }
}

export default Task;