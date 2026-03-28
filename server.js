const express = require('express');
const path = require('path');

const app = express();

// Serve static files (index.html, css, js)
app.use(express.static(__dirname));

// Route for homepage
app.get('/', (req, res) => {
  res.sendFile(path.join(__dirname, 'index.html'));
});

// Port configuration
const PORT = process.env.PORT || 5000;

app.listen(PORT, () => {
  console.log(`🚀 Server running on port ${PORT}`);
});
