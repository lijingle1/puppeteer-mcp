# Puppeteer MCP Server with SSE Support

This project now supports Server-Sent Events (SSE) for real-time communication with MCP clients.

## Running Modes

### 1. Standard MCP Mode (Default)
```bash
# Using npm start (recommended)
npm start

# Using compiled JavaScript
npm run build
node dist/index.js

# Or directly run TypeScript
npx -y tsx index.ts
```

### 2. SSE Local Server Mode
```powershell
# Windows PowerShell
.\start-sse-local.ps1

# Or manually
$env:SSE_LOCAL = "true"
$env:PORT = "3001"
npx -y tsx index.ts
```

### 3. SSE Cloud Server Mode
```powershell
# Windows PowerShell
.\start-sse-cloud.ps1

# Or manually
$env:CLOUD_SERVICE = "true"
$env:PORT = "3002"
npx -y tsx index.ts
```

## SSE Endpoints

When running in SSE mode, the server provides the following endpoints:

- **SSE Connection**: `GET http://localhost:3000/sse`
  - Establishes a Server-Sent Events connection
  - Returns event stream for real-time communication

- **Message Endpoint**: `POST http://localhost:3000/messages`
  - Send MCP protocol messages to the server
  - Content-Type: application/json

- **Health Check** (Cloud mode only): `GET http://localhost:3000/health`
  - Returns "OK" for health monitoring

## Development Tools

### MCP Inspector
Use the MCP Inspector to debug and test the server:
```bash
npm run inspect
```
This will start the MCP Inspector web interface for interactive testing.

## Authentication (Cloud Mode Only)

The SSE Cloud mode includes API key authentication for security. The following API keys are configured:

- `puppeteer-mcp-service` - Production key
- `test1` - Test key  
- `dev` - Development key

API keys can be provided via:
- **Headers**: `apikey` or `apiKey`
- **Query parameters**: `apiKey`
- **Request body**: `apiKey`

### Example with API Key:
```javascript
// SSE Connection with API key in header
const eventSource = new EventSource('http://localhost:3002/sse', {
  headers: { 'apiKey': 'dev' }
});

// POST message with API key in query
fetch('http://localhost:3002/messages?apiKey=dev&sessionId=your-session-id', {
  method: 'POST',
  headers: { 'Content-Type': 'application/json' },
  body: JSON.stringify({ /* MCP message */ })
});
```

**Note**: Local SSE mode does not require authentication.

## Environment Variables

- `SSE_LOCAL=true`: Enable local SSE server mode (no auth required)
- `CLOUD_SERVICE=true`: Enable cloud SSE server mode (API key required)
- `PORT=3000`: Set server port (default: 3000)

## Features

All original Puppeteer MCP tools are available in SSE mode:

- `puppeteer_navigate`: Navigate to URLs
- `puppeteer_screenshot`: Take screenshots
- `puppeteer_click`: Click elements
- `puppeteer_fill`: Fill input fields
- `puppeteer_select`: Select dropdown options
- `puppeteer_hover`: Hover over elements
- `puppeteer_evaluate`: Execute JavaScript

## Usage Example

1. Start the SSE server:
   ```powershell
   .\start-sse-local.ps1
   ```

2. Connect to SSE endpoint:
   ```javascript
   const eventSource = new EventSource('http://localhost:3000/sse');
   ```

3. Send messages via POST:
   ```javascript
   fetch('http://localhost:3000/messages', {
     method: 'POST',
     headers: { 'Content-Type': 'application/json' },
     body: JSON.stringify({
       // MCP protocol message
     })
   });
   ```
