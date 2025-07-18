$env:SSE_LOCAL = 'true'
$env:PORT = '3001'
Write-Host 'Starting Puppeteer MCP SSE Local Server...'
npx -y tsx index.ts
