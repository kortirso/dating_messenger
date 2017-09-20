import React from 'react';
import Task from 'components/tasks_box/task';

class TasksBox extends React.Component {

    constructor() {
        super();
        this.state = {
            tasksList: []
        }
    }

    componentWillMount() {
        this._fetchTasksList();
        this._runTimer();
    }

    componentWillUnmount() {
        clearInterval(this.state.intervalId);
    }

    _runTimer() {
        this._timer = setInterval(() => this._fetchTasksList(), 5000);
        this.setState({intervalId: this._timer});
    }

    _checkCompleting() {
        let amount = 0;
        this.state.tasksList.map((task) => {
            if (task.status == 'active') amount = amount + 1;
        });
        if (amount == 0) clearInterval(this.state.intervalId);
    }

    _fetchTasksList() {
        $.ajax({
            method: 'GET',
            url: `api/v1/tasks.json`,
            success: (data) => {
                this.setState({tasksList: data.tasks});
            }
        });
        this._checkCompleting();
    }

    _prepareTasksList() {
        return this.state.tasksList.map((task) => {
            return (
                <Task task={task} key={task.id} />
            );
        });
    }

    render() {
        let tasks = this._prepareTasksList();
        return (
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>URL</th>
                        <th>Email</th>
                        <th>Profiles</th>
                        <th>Progress</th>
                        <th>Status</th>
                    </tr>
                </thead>
                <tbody>
                    {tasks}
                </tbody>
            </table>
        );
    }
}

export default TasksBox;