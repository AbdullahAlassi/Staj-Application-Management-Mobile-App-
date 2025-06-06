const mongoose = require('mongoose');

const boardSchema = new mongoose.Schema({
  title: { type: String, required: true },
  project: { type: mongoose.Schema.Types.ObjectId, ref: 'Project', required: true },
  members: [{ type: mongoose.Schema.Types.ObjectId, ref: 'User' }], // Users assigned to the board
  tasks: [{ type: mongoose.Schema.Types.ObjectId, ref: 'Task' }],
  status: { 
    type: String, 
    enum: ['To Do', 'In Progress', 'Done'], 
    default: 'To Do' 
  },
  type: { 
    type: String, 
    enum: ['To Do', 'In Progress', 'Done'], 
    default: 'To Do' 
  },
  deadline: { type: Date },
  commentCount: { type: Number, default: 0 },
}, { timestamps: true });

module.exports = mongoose.model('Board', boardSchema);
