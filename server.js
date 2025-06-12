const express = require('express');
const { createProxyMiddleware } = require('http-proxy-middleware');
const path = require('path');

const app = express();
const PORT = process.env.PORT || 8080;

// Serve static files from wwwroot
app.use(express.static(path.join(__dirname, 'wwwroot')));

// Proxy API calls to the working Java backend
app.use('/mj', createProxyMiddleware({
  target: 'https://ash3.up.railway.app',
  changeOrigin: true,
  pathRewrite: {
    '^/mj': '/mj'
  },
  onProxyReq: (proxyReq, req, res) => {
    // Add the API secret header
    proxyReq.setHeader('mj-api-secret', 'MJ_API_SECRET=midjourneyproxy123');
  }
}));

// Proxy other API endpoints
app.use('/api', createProxyMiddleware({
  target: 'https://ash3.up.railway.app',
  changeOrigin: true,
  pathRewrite: {
    '^/api': '/api'
  },
  onProxyReq: (proxyReq, req, res) => {
    // Add the API secret header
    proxyReq.setHeader('mj-api-secret', 'MJ_API_SECRET=midjourneyproxy123');
  }
}));

// Health check endpoint
app.get('/health', (req, res) => {
  res.json({ status: 'ok', message: 'Midjourney Admin Interface is running' });
});

// Serve admin interface for all other routes
app.get('*', (req, res) => {
  res.sendFile(path.join(__dirname, 'wwwroot', 'index.html'));
});

app.listen(PORT, () => {
  console.log(`Midjourney Admin Interface running on port ${PORT}`);
  console.log(`Admin URL: http://localhost:${PORT}/admin`);
  console.log(`API Backend: https://ash3.up.railway.app`);
}); 