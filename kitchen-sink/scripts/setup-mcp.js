#!/usr/bin/env node
/*
Merges ATXP MCP servers into the project's .mcp.json.
Interpolates CONNECTION_STRING into the plugin's mcp.template.json.
*/

const fs = require('fs');
const path = require('path');

function fail(message) {
  console.error(message);
  process.exit(1);
}

function parseArgs(argv) {
  const args = {};
  for (let i = 2; i < argv.length; i++) {
    const arg = argv[i];
    if (arg === '--connection' || arg === '-c') {
      args.connection = argv[++i];
    } else if (arg === '--workspace' || arg === '-w') {
      args.workspace = argv[++i];
    } else if (arg === '--template' || arg === '-t') {
      args.template = argv[++i];
    } else {
      // ignore unknowns for forward compatibility
    }
  }
  return args;
}

function readJson(jsonPath) {
  return JSON.parse(fs.readFileSync(jsonPath, 'utf8'));
}

function writeJson(jsonPath, data) {
  const content = JSON.stringify(data, null, 2) + '\n';
  fs.writeFileSync(jsonPath, content, 'utf8');
}

function deepMergeServers(base, addition) {
  const result = { ...base };
  result.mcpServers = result.mcpServers || {};
  for (const [name, server] of Object.entries(addition.mcpServers || {})) {
    result.mcpServers[name] = server; // override or add
  }
  return result;
}

function main() {
  const { connection, workspace, template } = parseArgs(process.argv);
  if (!connection) {
    fail('Missing required --connection <string>');
  }

  const pluginRoot = process.env.CLAUDE_PLUGIN_ROOT || path.resolve(__dirname, '..');
  const templatePath = template || path.join(pluginRoot, 'mcp.template.json');
  if (!fs.existsSync(templatePath)) {
    fail(`Template not found: ${templatePath}`);
  }

  const templateJson = readJson(templatePath);
  const templated = JSON.parse(
    JSON.stringify(templateJson).replaceAll('${CONNECTION_STRING}', connection)
  );

  // Determine workspace root (current working dir by default)
  const workspaceRoot = workspace || process.cwd();
  const projectMcpPath = path.join(workspaceRoot, '.mcp.json');

  let existing = { mcpServers: {} };
  if (fs.existsSync(projectMcpPath)) {
    try {
      existing = readJson(projectMcpPath);
    } catch (e) {
      fail(`Failed to parse existing ${projectMcpPath}: ${e.message}`);
    }
  }

  const merged = deepMergeServers(existing, templated);
  writeJson(projectMcpPath, merged);

  console.log(`Updated ${projectMcpPath} with ATXP MCP servers.`);
}

main();


