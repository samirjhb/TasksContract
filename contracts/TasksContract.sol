// SPDX-License-Identifier: MIT
pragma solidity ^0.8.6;

contract TasksContract {
    //Creacion de id
    uint public taskCount = 0;

    constructor() {
        createTask("Mi primer tarea de ejemplo", "tengo que hacer algo");
    }

    event TaskCreated(
        uint id,
        string title,
        string description,
        bool done,
        uint createdAt
    );

    event TaskToggleDone( uint id, bool done);

    struct Task {
        uint256 id;
        string title;
        string description;
        bool done;
        uint256 createdAt;
    }
    //Lista de tareas  es un arreglo
    mapping(uint256 => Task) public tasks;

    // Creacion de funcion que nos permite interactuar con estos datos --> Basicamente  un Crud
    function createTask(
        string memory _title,
        string memory _description
    ) public {
        taskCount++;
        tasks[taskCount] = Task(
            taskCount,
            _title,
            _description,
            false,
            block.timestamp
        );
        emit TaskCreated(taskCount, _title, _description, false,  block.timestamp); //Emitir el resultado mediate el evento
        
    }

    // actualizar la tarea el bool de false a true
    function toggleDone(uint _id) public {
        Task memory _task = tasks[_id];
        _task.done = !_task.done;
        tasks[_id] = _task;
        emit TaskToggleDone(_id, _task.done);
    }
}
