import React, { useState, useEffect } from 'react';
import axios from 'axios';
import './App.css';

function App() {
  const [tasks, setTasks] = useState([]);
  const [newTaskTitle, setNewTaskTitle] = useState('');
  const [editingTask, setEditingTask] = useState(null);

  const API_URL = 'http://localhost:8000';

  useEffect(() => {
    fetchTasks();
  }, []);

  const fetchTasks = async () => {
    try {
      const response = await axios.get(`${API_URL}/tasks`);
      setTasks(response.data);
    } catch (error) {
      console.error('Error fetching tasks:', error);
    }
  };

  const handleCreateTask = async (e) => {
    e.preventDefault();
    if (!newTaskTitle.trim()) return;

    try {
      await axios.post(`${API_URL}/tasks`, {
        title: newTaskTitle,
        completed: false
      });
      setNewTaskTitle('');
      fetchTasks();
    } catch (error) {
      console.error('Error creating task:', error);
    }
  };

  const handleUpdateTask = async (taskId, updatedTask) => {
    try {
      await axios.put(`${API_URL}/tasks/${taskId}`, updatedTask);
      setEditingTask(null);
      fetchTasks();
    } catch (error) {
      console.error('Error updating task:', error);
    }
  };

  const handleDeleteTask = async (taskId) => {
    try {
      await axios.delete(`${API_URL}/tasks/${taskId}`);
      fetchTasks();
    } catch (error) {
      console.error('Error deleting task:', error);
    }
  };

  const toggleTaskCompletion = async (task) => {
    const updatedTask = { ...task, completed: !task.completed };
    await handleUpdateTask(task.id, updatedTask);
  };

  return (
    <div className="App">
      <h1>Task Management App</h1>
      
      <form onSubmit={handleCreateTask} className="task-form">
        <input
          type="text"
          value={newTaskTitle}
          onChange={(e) => setNewTaskTitle(e.target.value)}
          placeholder="Enter a new task"
          className="task-input"
        />
        <button type="submit" className="add-button">Add Task</button>
      </form>

      <div className="tasks-list">
        {tasks.map((task) => (
          <div key={task.id} className="task-item">
            {editingTask?.id === task.id ? (
              <input
                type="text"
                value={editingTask.title}
                onChange={(e) => setEditingTask({ ...editingTask, title: e.target.value })}
                onBlur={() => handleUpdateTask(task.id, editingTask)}
                onKeyPress={(e) => {
                  if (e.key === 'Enter') {
                    handleUpdateTask(task.id, editingTask);
                  }
                }}
                autoFocus
              />
            ) : (
              <div className="task-content">
                <input
                  type="checkbox"
                  checked={task.completed}
                  onChange={() => toggleTaskCompletion(task)}
                />
                <span className={task.completed ? 'completed' : ''}>
                  {task.title}
                </span>
              </div>
            )}
            <div className="task-actions">
              <button
                onClick={() => setEditingTask(task)}
                className="edit-button"
              >
                Edit
              </button>
              <button
                onClick={() => handleDeleteTask(task.id)}
                className="delete-button"
              >
                Delete
              </button>
            </div>
          </div>
        ))}
      </div>
    </div>
  );
}

export default App; 